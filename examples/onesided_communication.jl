using GPI2

function wait_if_queue_full(queue_id, request_size)
  queue_size_max = Ref{gaspi_number_t}()
  queue_size = Ref{gaspi_number_t}()

  gaspi_queue_size_max(queue_size_max)
  gaspi_queue_size(queue_id, queue_size)

  if (queue_size[] + request_size >= queue_size_max[])
    gaspi_wait(queue_id, GASPI_BLOCK)
  end
end

gaspi_proc_init(GASPI_BLOCK)

iProc = Ref{gaspi_rank_t}()
nProc = Ref{gaspi_rank_t}()

gaspi_proc_rank(iProc)
gaspi_proc_num(nProc)

segment_id_src = gaspi_segment_id_t(0)
segment_id_dst = gaspi_segment_id_t(1)

segment_size = gaspi_size_t(nProc[] * sizeof(Cint))

# create 2 segments for data
gaspi_segment_create(segment_id_src, segment_size, GASPI_GROUP_ALL, GASPI_BLOCK,
                     GASPI_ALLOC_DEFAULT)
gaspi_segment_create(segment_id_dst, segment_size, GASPI_GROUP_ALL, GASPI_BLOCK,
                     GASPI_ALLOC_DEFAULT)

# Use `Array` instead of `Ref` to allow auto-conversion to `Ptr{Cvoid}`
src_ptr = Array{Ptr{Cint}, 0}(undef)
dst_ptr = Array{Ptr{Cint}, 0}(undef)

# get initial pointers to each segment
gaspi_segment_ptr(segment_id_src, src_ptr)
gaspi_segment_ptr(segment_id_dst, dst_ptr)

# Wrap pointers in plain Julia array for convenient access
src = unsafe_wrap(Array, src_ptr[], nProc[])
dst = unsafe_wrap(Array, dst_ptr[], nProc[])

queue_id = gaspi_queue_id_t(0)

for r in 0:(nProc[]-1)
  src[r + 1] = iProc[] * nProc[] + r
end

# sync
gaspi_barrier(GASPI_GROUP_ALL, GASPI_BLOCK)
println("BEFORE: iProc=$(iProc[]), src=$src")
println("BEFORE: iProc=$(iProc[]), dst=$dst")

for rank in 0:(nProc[]-1)
  offset_src = gaspi_offset_t(iProc[] * sizeof(Cint))
  offset_dst = gaspi_offset_t(rank * sizeof(Cint))

  wait_if_queue_full(queue_id, 1)

  gaspi_read(segment_id_dst, offset_dst, rank, segment_id_src, offset_src, sizeof(Cint),
             queue_id, GASPI_BLOCK)
end

# .... work ....

gaspi_wait(queue_id, GASPI_BLOCK)

gaspi_barrier(GASPI_GROUP_ALL, GASPI_BLOCK)
println("AFTER:  iProc=$(iProc[]), dst=$dst")

gaspi_proc_term(GASPI_BLOCK)

