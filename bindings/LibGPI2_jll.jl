module LibGPI2

using CEnum

to_c_type(t::Type) = t
to_c_type_pairs(va_list) = map(enumerate(to_c_type.(va_list))) do (ind, type)
    :(va_list[$ind]::$type)
end

using ..GPI2: libGPI2


const gaspi_uint = Cuint

const gaspi_int = Cint

const gaspi_timeout_t = Culong

"""
    gaspi_network_t

Network type.
"""
@cenum gaspi_network_t::UInt32 begin
    GASPI_IB = 0
    GASPI_ROCE = 1
    GASPI_ETHERNET = 2
    GASPI_GEMINI = 3
    GASPI_ARIES = 4
end

struct __JL_Ctag_11
    netdev_id::gaspi_int
    mtu::gaspi_uint
    port_check::gaspi_uint
end
function Base.getproperty(x::Ptr{__JL_Ctag_11}, f::Symbol)
    f === :netdev_id && return Ptr{gaspi_int}(x + 0)
    f === :mtu && return Ptr{gaspi_uint}(x + 4)
    f === :port_check && return Ptr{gaspi_uint}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_11, f::Symbol)
    r = Ref{__JL_Ctag_11}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_11}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_11}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_12
    port::gaspi_uint
end
function Base.getproperty(x::Ptr{__JL_Ctag_12}, f::Symbol)
    f === :port && return Ptr{gaspi_uint}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_12, f::Symbol)
    r = Ref{__JL_Ctag_12}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_12}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_12}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct __JL_Ctag_10
    ib::__JL_Ctag_11
    tcp::__JL_Ctag_12
end
function Base.getproperty(x::Ptr{__JL_Ctag_10}, f::Symbol)
    f === :ib && return Ptr{__JL_Ctag_11}(x + 0)
    f === :tcp && return Ptr{__JL_Ctag_12}(x + 12)
    return getfield(x, f)
end

function Base.getproperty(x::__JL_Ctag_10, f::Symbol)
    r = Ref{__JL_Ctag_10}(x)
    ptr = Base.unsafe_convert(Ptr{__JL_Ctag_10}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{__JL_Ctag_10}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


"""
    gaspi_dev_config_t

Network Device configuration.
"""
struct gaspi_dev_config_t
    network_type::gaspi_network_t
    params::__JL_Ctag_10
end

const gaspi_number_t = Cuint

const gaspi_size_t = Culong

"""
    gaspi_topology_t

Topology building strategy.
"""
@cenum gaspi_topology_t::UInt32 begin
    GASPI_TOPOLOGY_NONE = 0
    GASPI_TOPOLOGY_STATIC = 1
    GASPI_TOPOLOGY_DYNAMIC = 2
end

"""
    gaspi_config

A structure with configuration.
"""
struct gaspi_config
    logger::gaspi_uint
    sn_port::gaspi_uint
    net_info::gaspi_uint
    user_net::gaspi_uint
    sn_persistent::gaspi_int
    sn_timeout::gaspi_timeout_t
    dev_config::gaspi_dev_config_t
    network::gaspi_network_t
    queue_size_max::gaspi_uint
    queue_num::gaspi_uint
    group_max::gaspi_number_t
    segment_max::gaspi_number_t
    transfer_size_max::gaspi_size_t
    notification_num::gaspi_number_t
    passive_queue_size_max::gaspi_number_t
    passive_transfer_size_max::gaspi_number_t
    allreduce_buf_size::gaspi_size_t
    allreduce_elem_max::gaspi_number_t
    rw_list_elem_max::gaspi_number_t
    build_infrastructure::gaspi_topology_t
    user_defined::Ptr{Cvoid}
end

"""A structure with configuration."""
const gaspi_config_t = gaspi_config

"""
    gaspi_return_t

Functions return type.
"""
@cenum gaspi_return_t::Int32 begin
    GASPI_ERROR = -1
    GASPI_SUCCESS = 0
    GASPI_TIMEOUT = 1
    GASPI_ERR_EMFILE = 2
    GASPI_ERR_ENV = 3
    GASPI_ERR_SN_PORT = 4
    GASPI_ERR_CONFIG = 5
    GASPI_ERR_NOINIT = 6
    GASPI_ERR_INITED = 7
    GASPI_ERR_NULLPTR = 8
    GASPI_ERR_INV_SEGSIZE = 9
    GASPI_ERR_INV_SEG = 10
    GASPI_ERR_INV_GROUP = 11
    GASPI_ERR_INV_RANK = 12
    GASPI_ERR_INV_QUEUE = 13
    GASPI_ERR_INV_LOC_OFF = 14
    GASPI_ERR_INV_REM_OFF = 15
    GASPI_ERR_INV_COMMSIZE = 16
    GASPI_ERR_INV_NOTIF_VAL = 17
    GASPI_ERR_INV_NOTIF_ID = 18
    GASPI_ERR_INV_NUM = 19
    GASPI_ERR_INV_SIZE = 20
    GASPI_ERR_MANY_SEG = 21
    GASPI_ERR_MANY_GRP = 22
    GASPI_QUEUE_FULL = 23
    GASPI_ERR_UNALIGN_OFF = 24
    GASPI_ERR_ACTIVE_COLL = 25
    GASPI_ERR_DEVICE = 26
    GASPI_ERR_SN = 27
    GASPI_ERR_MEMALLOC = 28
end

"""
    gaspi_config_get(config)

Get configuration structure.

### Parameters
* `config`: Output configuration structure.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_config_get (gaspi_config_t * const config);
```
"""
function gaspi_config_get(config)
    @ccall libGPI2.gaspi_config_get(config::Ptr{gaspi_config_t})::gaspi_return_t
end

"""
    gaspi_config_set(new_config)

Set configuration values.

### Parameters
* `new_config`: The new configuration to be set.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_config_set (const gaspi_config_t new_config);
```
"""
function gaspi_config_set(new_config)
    @ccall libGPI2.gaspi_config_set(new_config::gaspi_config_t)::gaspi_return_t
end

"""
    gaspi_version(version)

Get version number.

### Parameters
* `version`: Output parameter with version number.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_version (float *version);
```
"""
function gaspi_version(version)
    @ccall libGPI2.gaspi_version(version::Ptr{Cfloat})::gaspi_return_t
end

"""
    gaspi_proc_init(timeout_ms)

Initialization procedure to start GPI-2. It is a non-local synchronous time-based blocking procedure.

### Parameters
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_proc_init (const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_proc_init(timeout_ms)
    @ccall libGPI2.gaspi_proc_init(timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_proc_term(timeout_ms)

Shutdown procedure. It is a synchronous local time-based blocking operation that releases resources and performs the required clean-up.

### Parameters
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_proc_term (const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_proc_term(timeout_ms)
    @ccall libGPI2.gaspi_proc_term(timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

const gaspi_rank_t = Cushort

"""
    gaspi_proc_rank(rank)

Get the process rank.

### Parameters
* `rank`: Rank of calling process.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_proc_rank (gaspi_rank_t * const rank);
```
"""
function gaspi_proc_rank(rank)
    @ccall libGPI2.gaspi_proc_rank(rank::Ptr{gaspi_rank_t})::gaspi_return_t
end

"""
    gaspi_proc_num(proc_num)

Get the number of processes (ranks) started by the application.

### Parameters
* `proc_num`: The number of processes (ranks) started by the application.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_proc_num (gaspi_rank_t * const proc_num);
```
"""
function gaspi_proc_num(proc_num)
    @ccall libGPI2.gaspi_proc_num(proc_num::Ptr{gaspi_rank_t})::gaspi_return_t
end

"""
    gaspi_proc_kill(rank, timeout_ms)

Kill a given process (rank).

### Parameters
* `rank`: Rank to kill.
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_proc_kill (const gaspi_rank_t rank, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_proc_kill(rank, timeout_ms)
    @ccall libGPI2.gaspi_proc_kill(rank::gaspi_rank_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_connect(rank, timeout_ms)

Connect to a determined rank to be able to communicate. It builds the required infrastructure for communication.

### Parameters
* `rank`: Rank to connect to.
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_connect (const gaspi_rank_t rank, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_connect(rank, timeout_ms)
    @ccall libGPI2.gaspi_connect(rank::gaspi_rank_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_disconnect(rank, timeout_ms)

Disconnect from a particular rank.

### Parameters
* `rank`: Rank to disconnect from.
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_disconnect (const gaspi_rank_t rank, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_disconnect(rank, timeout_ms)
    @ccall libGPI2.gaspi_disconnect(rank::gaspi_rank_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

const gaspi_group_t = Cuchar

"""
    gaspi_group_create(group)

Create a group. In case of success, a empty group is created (without members).

### Parameters
* `group`: The created group.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_group_create (gaspi_group_t * const group);
```
"""
function gaspi_group_create(group)
    @ccall libGPI2.gaspi_group_create(group::Ptr{gaspi_group_t})::gaspi_return_t
end

"""
    gaspi_group_delete(group)

Delete a given group.

### Parameters
* `group`: Group to delete.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_group_delete (const gaspi_group_t group);
```
"""
function gaspi_group_delete(group)
    @ccall libGPI2.gaspi_group_delete(group::gaspi_group_t)::gaspi_return_t
end

"""
    gaspi_group_add(group, rank)

Add a given rank to a group.

### Parameters
* `group`: Group to add.
* `rank`: Rank to add to the group.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_group_add (const gaspi_group_t group, const gaspi_rank_t rank);
```
"""
function gaspi_group_add(group, rank)
    @ccall libGPI2.gaspi_group_add(group::gaspi_group_t, rank::gaspi_rank_t)::gaspi_return_t
end

"""
    gaspi_group_commit(group, timeout_ms)

Establish a group by committing it. A group needs to be committed in order to use collective operations on such group.

### Parameters
* `group`: Group to commit.
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_group_commit (const gaspi_group_t group, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_group_commit(group, timeout_ms)
    @ccall libGPI2.gaspi_group_commit(group::gaspi_group_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_group_num(group_num)

Get the current number of created groups.

### Parameters
* `group_num`: Output paramter with the number of groups.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_group_num (gaspi_number_t * const group_num);
```
"""
function gaspi_group_num(group_num)
    @ccall libGPI2.gaspi_group_num(group_num::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    gaspi_group_size(group, group_size)

Get the size of a given group. It returns the number of processes (ranks) in the group.

### Parameters
* `group`: The group from which we want to know the size.
* `group_size`: Output parameter with the group size.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_group_size (const gaspi_group_t group, gaspi_number_t * const group_size);
```
"""
function gaspi_group_size(group, group_size)
    @ccall libGPI2.gaspi_group_size(group::gaspi_group_t, group_size::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    gaspi_group_ranks(group, group_ranks)

Get the list of ranks forming a given group.

### Parameters
* `group`: The group we are interested in.
* `group_ranks`: Output parameter: an array with the ranks belonging to the given group.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_group_ranks (const gaspi_group_t group, gaspi_rank_t * const group_ranks);
```
"""
function gaspi_group_ranks(group, group_ranks)
    @ccall libGPI2.gaspi_group_ranks(group::gaspi_group_t, group_ranks::Ptr{gaspi_rank_t})::gaspi_return_t
end

"""
    gaspi_group_max(group_max)

Get the maximum number of groups allowed to be created.

### Parameters
* `group_max`: Output parameter with the maximum number of groups.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_group_max (gaspi_number_t * const group_max);
```
"""
function gaspi_group_max(group_max)
    @ccall libGPI2.gaspi_group_max(group_max::Ptr{gaspi_number_t})::gaspi_return_t
end

const gaspi_segment_id_t = Cuchar

"""
    gaspi_alloc_t

Memory allocation policy.
"""
@cenum gaspi_alloc_t::UInt32 begin
    GASPI_MEM_UNINITIALIZED = 0
    GASPI_MEM_INITIALIZED = 1
    GASPI_ALLOC_DEFAULT = 0
end

"""
    gaspi_segment_alloc(segment_id, size, alloc_policy)

Allocate a segment.

### Parameters
* `segment_id`: The segment identifier to be created.
* `size`: The size of the segment to be created.
* `alloc_policy`: The allocation policy.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_segment_alloc (const gaspi_segment_id_t segment_id, const gaspi_size_t size, const gaspi_alloc_t alloc_policy);
```
"""
function gaspi_segment_alloc(segment_id, size, alloc_policy)
    @ccall libGPI2.gaspi_segment_alloc(segment_id::gaspi_segment_id_t, size::gaspi_size_t, alloc_policy::gaspi_alloc_t)::gaspi_return_t
end

"""
    gaspi_segment_delete(segment_id)

Delete a given segment.

### Parameters
* `segment_id`: The segment identifier to be deleted.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_segment_delete (const gaspi_segment_id_t segment_id);
```
"""
function gaspi_segment_delete(segment_id)
    @ccall libGPI2.gaspi_segment_delete(segment_id::gaspi_segment_id_t)::gaspi_return_t
end

"""
    gaspi_segment_register(segment_id, rank, timeout_ms)

Register a segment for communication. In case of success, the segment can be used for communication between the involved ranks.

### Parameters
* `segment_id`: Segment identified to be registered.
* `rank`: The rank to register this segment with.
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_segment_register (const gaspi_segment_id_t segment_id, const gaspi_rank_t rank, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_segment_register(segment_id, rank, timeout_ms)
    @ccall libGPI2.gaspi_segment_register(segment_id::gaspi_segment_id_t, rank::gaspi_rank_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_segment_create(segment_id, size, group, timeout_ms, alloc_policy)

Create a segment. It is semantically equivalent to a collective aggregation of gaspi\\_segment\\_ alloc, [`gaspi_segment_register`](@ref) and [`gaspi_barrier`](@ref) involving all of the mem- bers of a given group.

### Parameters
* `segment_id`: The segment id to identify the segment.
* `size`: The size of the segment (in bytes).
* `group`: The group of ranks with which the segment should be registered.
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
* `alloc_policy`: Memory allocation policy.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_segment_create (const gaspi_segment_id_t segment_id, const gaspi_size_t size, const gaspi_group_t group, const gaspi_timeout_t timeout_ms, const gaspi_alloc_t alloc_policy);
```
"""
function gaspi_segment_create(segment_id, size, group, timeout_ms, alloc_policy)
    @ccall libGPI2.gaspi_segment_create(segment_id::gaspi_segment_id_t, size::gaspi_size_t, group::gaspi_group_t, timeout_ms::gaspi_timeout_t, alloc_policy::gaspi_alloc_t)::gaspi_return_t
end

const gaspi_pointer_t = Ptr{Cvoid}

const gaspi_memory_description_t = Cint

"""
    gaspi_segment_bind(segment_id, pointer, size, memory_description)

Use a user-provided buffer as a segment.

### Parameters
* `segment_id`: The segment identifier to be used.
* `pointer`: The buffer address to use.
* `size`: The size of segment.
* `memory_description`: A description of the memory to be used.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_segment_bind (gaspi_segment_id_t const segment_id, gaspi_pointer_t const pointer, gaspi_size_t const size, gaspi_memory_description_t const memory_description);
```
"""
function gaspi_segment_bind(segment_id, pointer, size, memory_description)
    @ccall libGPI2.gaspi_segment_bind(segment_id::gaspi_segment_id_t, pointer::gaspi_pointer_t, size::gaspi_size_t, memory_description::gaspi_memory_description_t)::gaspi_return_t
end

"""
    gaspi_segment_use(segment_id, pointer, size, group, timeout, memory_description)

Use a user-provided buffer as a segment.

### Parameters
* `segment_id`: The segment identifier to be used.
* `pointer`: The buffer address to use.
* `size`: The size of segment.
* `group`: The group participating in the operation.
* `timeout`: The operation timeout (in milliseconds).
* `memory_description`: A description of the memory to be used.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_segment_use (gaspi_segment_id_t const segment_id, gaspi_pointer_t const pointer, gaspi_size_t const size, gaspi_group_t const group, gaspi_timeout_t const timeout, gaspi_memory_description_t const memory_description);
```
"""
function gaspi_segment_use(segment_id, pointer, size, group, timeout, memory_description)
    @ccall libGPI2.gaspi_segment_use(segment_id::gaspi_segment_id_t, pointer::gaspi_pointer_t, size::gaspi_size_t, group::gaspi_group_t, timeout::gaspi_timeout_t, memory_description::gaspi_memory_description_t)::gaspi_return_t
end

"""
    gaspi_segment_num(segment_num)

Get the number of allocated segments.

### Parameters
* `segment_num`: Output parameter with the number of allocated segments.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_segment_num (gaspi_number_t * const segment_num);
```
"""
function gaspi_segment_num(segment_num)
    @ccall libGPI2.gaspi_segment_num(segment_num::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    gaspi_segment_list(num, segment_id_list)

Get a list of locally allocated segments ID's.

### Parameters
* `num`: The number of segments.
* `segment_id_list`: Output parameter with an array wit the id's of the allocated segments.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_segment_list (const gaspi_number_t num, gaspi_segment_id_t * const segment_id_list);
```
"""
function gaspi_segment_list(num, segment_id_list)
    @ccall libGPI2.gaspi_segment_list(num::gaspi_number_t, segment_id_list::Ptr{gaspi_segment_id_t})::gaspi_return_t
end

"""
    gaspi_segment_ptr(segment_id, ptr)

Get the pointer to the location of a given segment.

### Parameters
* `segment_id`: The segment identifier.
* `ptr`: Output parameter with the pointer to the memory segment.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_segment_ptr (const gaspi_segment_id_t segment_id, gaspi_pointer_t * ptr);
```
"""
function gaspi_segment_ptr(segment_id, ptr)
    @ccall libGPI2.gaspi_segment_ptr(segment_id::gaspi_segment_id_t, ptr::Ptr{gaspi_pointer_t})::gaspi_return_t
end

"""
    gaspi_segment_max(segment_max)

Get the maximum number of segments allowed to be allocated/created.

### Parameters
* `segment_max`: Output paramter with the maximum number of segments.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_segment_max (gaspi_number_t * const segment_max);
```
"""
function gaspi_segment_max(segment_max)
    @ccall libGPI2.gaspi_segment_max(segment_max::Ptr{gaspi_number_t})::gaspi_return_t
end

const gaspi_offset_t = Culong

const gaspi_queue_id_t = Cuchar

"""
    gaspi_write(segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, queue, timeout_ms)

One-sided write.

### Parameters
* `segment_id_local`: The local segment id with the data to write.
* `offset_local`: The local offset with the data to write.
* `rank`: The rank to which we want to write.
* `segment_id_remote`: The remote segment id to write to.
* `offset_remote`: The remote offset where to write to.
* `size`: The size of data to write.
* `queue`: The queue where to post the write request.
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_QUEUE\\_FULL if the requested could not be posted because the provided queue is full, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_write (const gaspi_segment_id_t segment_id_local, const gaspi_offset_t offset_local, const gaspi_rank_t rank, const gaspi_segment_id_t segment_id_remote, const gaspi_offset_t offset_remote, const gaspi_size_t size, const gaspi_queue_id_t queue, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_write(segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, queue, timeout_ms)
    @ccall libGPI2.gaspi_write(segment_id_local::gaspi_segment_id_t, offset_local::gaspi_offset_t, rank::gaspi_rank_t, segment_id_remote::gaspi_segment_id_t, offset_remote::gaspi_offset_t, size::gaspi_size_t, queue::gaspi_queue_id_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_read(segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, queue, timeout_ms)

One-sided read.

### Parameters
* `segment_id_local`: The local segment id where data will be placed.
* `offset_local`: The local offset where the data will be placed.
* `rank`: The rank from which we want to read.
* `segment_id_remote`: The remote segment id to read from.
* `offset_remote`: The remote offset where to read from.
* `size`: The size of data to read.
* `queue`: The queue where to post the read request.
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_QUEUE\\_FULL if the requested could not be posted because the provided queue is full, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_read (const gaspi_segment_id_t segment_id_local, const gaspi_offset_t offset_local, const gaspi_rank_t rank, const gaspi_segment_id_t segment_id_remote, const gaspi_offset_t offset_remote, const gaspi_size_t size, const gaspi_queue_id_t queue, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_read(segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, queue, timeout_ms)
    @ccall libGPI2.gaspi_read(segment_id_local::gaspi_segment_id_t, offset_local::gaspi_offset_t, rank::gaspi_rank_t, segment_id_remote::gaspi_segment_id_t, offset_remote::gaspi_offset_t, size::gaspi_size_t, queue::gaspi_queue_id_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_write_list(num, segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, queue, timeout_ms)

List of writes.

### Parameters
* `num`: The number of list elements (see also [`gaspi_rw_list_elem_max`](@ref))
* `segment_id_local`: List of local segments with data to be written.
* `offset_local`: List of local offsets with data to be written.
* `rank`: Rank to which will be written.
* `segment_id_remote`: List of remote segments to write to.
* `offset_remote`: List of remote offsets to write to.
* `size`: List of sizes to write.
* `queue`: The queue where to post the list.
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_QUEUE\\_FULL if the requested could not be posted because the provided queue is full, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_write_list (const gaspi_number_t num, gaspi_segment_id_t * const segment_id_local, gaspi_offset_t * const offset_local, const gaspi_rank_t rank, gaspi_segment_id_t * const segment_id_remote, gaspi_offset_t * const offset_remote, gaspi_size_t * const size, const gaspi_queue_id_t queue, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_write_list(num, segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, queue, timeout_ms)
    @ccall libGPI2.gaspi_write_list(num::gaspi_number_t, segment_id_local::Ptr{gaspi_segment_id_t}, offset_local::Ptr{gaspi_offset_t}, rank::gaspi_rank_t, segment_id_remote::Ptr{gaspi_segment_id_t}, offset_remote::Ptr{gaspi_offset_t}, size::Ptr{gaspi_size_t}, queue::gaspi_queue_id_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_read_list(num, segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, queue, timeout_ms)

List of reads.

### Parameters
* `num`: The number of list elements.
* `segment_id_local`: List of local segments where data will be placed.
* `offset_local`: List of local offsets where data will be placed.
* `rank`: Rank from which will be read.
* `segment_id_remote`: List of remote segments to read from.
* `offset_remote`: List of remote offsets to read from.
* `size`: List of sizes to read.
* `queue`: The queue where to post the list.
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_QUEUE\\_FULL if the requested could not be posted because the provided queue is full, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_read_list (const gaspi_number_t num, gaspi_segment_id_t * const segment_id_local, gaspi_offset_t * const offset_local, const gaspi_rank_t rank, gaspi_segment_id_t * const segment_id_remote, gaspi_offset_t * const offset_remote, gaspi_size_t * const size, const gaspi_queue_id_t queue, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_read_list(num, segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, queue, timeout_ms)
    @ccall libGPI2.gaspi_read_list(num::gaspi_number_t, segment_id_local::Ptr{gaspi_segment_id_t}, offset_local::Ptr{gaspi_offset_t}, rank::gaspi_rank_t, segment_id_remote::Ptr{gaspi_segment_id_t}, offset_remote::Ptr{gaspi_offset_t}, size::Ptr{gaspi_size_t}, queue::gaspi_queue_id_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_wait(queue, timeout_ms)

Wait for requests posted to a given queue.

### Parameters
* `queue`: Queue to wait for.
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_wait (const gaspi_queue_id_t queue, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_wait(queue, timeout_ms)
    @ccall libGPI2.gaspi_wait(queue::gaspi_queue_id_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_barrier(group, timeout_ms)

Barrier.

### Parameters
* `group`: The group involved in the barrier.
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_barrier (const gaspi_group_t group, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_barrier(group, timeout_ms)
    @ccall libGPI2.gaspi_barrier(group::gaspi_group_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_operation_t

Operations for Collective communication.

| Enumerator       | Note     |
| :--------------- | :------- |
| GASPI\\_OP\\_MIN | Minimum  |
| GASPI\\_OP\\_MAX | Maximum  |
| GASPI\\_OP\\_SUM | Sum      |
"""
@cenum gaspi_operation_t::UInt32 begin
    GASPI_OP_MIN = 0
    GASPI_OP_MAX = 1
    GASPI_OP_SUM = 2
end

"""
    gaspi_datatype_t

Element types for Collective communication.
"""
@cenum gaspi_datatype_t::UInt32 begin
    GASPI_TYPE_INT = 0
    GASPI_TYPE_UINT = 1
    GASPI_TYPE_FLOAT = 2
    GASPI_TYPE_DOUBLE = 3
    GASPI_TYPE_LONG = 4
    GASPI_TYPE_ULONG = 5
end

"""
    gaspi_allreduce(buffer_send, buffer_receive, num, operation, datatype, group, timeout_ms)

All Reduce collective operation.

### Parameters
* `buffer_send`: The buffer with data for the operation.
* `buffer_receive`: The buffer to receive the result of the operation.
* `num`: The number of data elements in the buffer (beware of maximum - use [`gaspi_allreduce_elem_max`](@ref)).
* `operation`: The type of operations (see [`gaspi_operation_t`](@ref)).
* `datatyp`: Type of data (see [`gaspi_datatype_t`](@ref)).
* `group`: The group involved in the operation.
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_allreduce (const gaspi_pointer_t buffer_send, gaspi_pointer_t const buffer_receive, const gaspi_number_t num, const gaspi_operation_t operation, const gaspi_datatype_t datatype, const gaspi_group_t group, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_allreduce(buffer_send, buffer_receive, num, operation, datatype, group, timeout_ms)
    @ccall libGPI2.gaspi_allreduce(buffer_send::gaspi_pointer_t, buffer_receive::gaspi_pointer_t, num::gaspi_number_t, operation::gaspi_operation_t, datatype::gaspi_datatype_t, group::gaspi_group_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

# typedef gaspi_return_t ( * gaspi_reduce_operation_t ) ( gaspi_pointer_t const operand_one , gaspi_pointer_t const operand_two , gaspi_pointer_t const result , gaspi_reduce_state_t const state , const gaspi_number_t num , const gaspi_size_t element_size , const gaspi_timeout_t timeout_ms )
const gaspi_reduce_operation_t = Ptr{Cvoid}

const gaspi_reduce_state_t = Ptr{Cvoid}

"""
    gaspi_allreduce_user(buffer_send, buffer_receive, num, element_size, reduce_operation, reduce_state, group, timeout_ms)

### Prototype
```c
gaspi_return_t gaspi_allreduce_user (const gaspi_pointer_t buffer_send, gaspi_pointer_t const buffer_receive, const gaspi_number_t num, const gaspi_size_t element_size, gaspi_reduce_operation_t const reduce_operation, gaspi_reduce_state_t const reduce_state, const gaspi_group_t group, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_allreduce_user(buffer_send, buffer_receive, num, element_size, reduce_operation, reduce_state, group, timeout_ms)
    @ccall libGPI2.gaspi_allreduce_user(buffer_send::gaspi_pointer_t, buffer_receive::gaspi_pointer_t, num::gaspi_number_t, element_size::gaspi_size_t, reduce_operation::gaspi_reduce_operation_t, reduce_state::gaspi_reduce_state_t, group::gaspi_group_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

const gaspi_atomic_value_t = Culong

"""
    gaspi_atomic_fetch_add(segment_id, offset, rank, val_add, val_old, timeout_ms)

Atomic fetch-and-add

!!! warning

    The offset must be 8 bytes aligned.

### Parameters
* `segment_id`: Segment identifier where data is located.
* `offset`: Offset where data is located.
* `rank`: The rank where to perform the operation.
* `val_add`: The value to add.
* `val_old`: Output parameter with the old value (before the add operation).
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_atomic_fetch_add (const gaspi_segment_id_t segment_id, const gaspi_offset_t offset, const gaspi_rank_t rank, const gaspi_atomic_value_t val_add, gaspi_atomic_value_t * const val_old, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_atomic_fetch_add(segment_id, offset, rank, val_add, val_old, timeout_ms)
    @ccall libGPI2.gaspi_atomic_fetch_add(segment_id::gaspi_segment_id_t, offset::gaspi_offset_t, rank::gaspi_rank_t, val_add::gaspi_atomic_value_t, val_old::Ptr{gaspi_atomic_value_t}, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_atomic_compare_swap(segment_id, offset, rank, comparator, val_new, val_old, timeout_ms)

Atomic compare-and-swap.

### Parameters
* `segment_id`: Segment identifier of data.
* `offset`: Offset of data.
* `rank`: The rank where to perform the operation.
* `comparator`: The comparison value for the operation.
* `val_new`: The new value to swap if comparison is successful.
* `val_old`: Output parameter with the old value (before the operation).
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_atomic_compare_swap (const gaspi_segment_id_t segment_id, const gaspi_offset_t offset, const gaspi_rank_t rank, const gaspi_atomic_value_t comparator, const gaspi_atomic_value_t val_new, gaspi_atomic_value_t * const val_old, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_atomic_compare_swap(segment_id, offset, rank, comparator, val_new, val_old, timeout_ms)
    @ccall libGPI2.gaspi_atomic_compare_swap(segment_id::gaspi_segment_id_t, offset::gaspi_offset_t, rank::gaspi_rank_t, comparator::gaspi_atomic_value_t, val_new::gaspi_atomic_value_t, val_old::Ptr{gaspi_atomic_value_t}, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_passive_send(segment_id_local, offset_local, rank, size, timeout_ms)

Send data of a given size to a given rank.

### Parameters
* `segment_id_local`: The local segment identifier.
* `offset_local`: The offset where the data to send is located.
* `rank`: The rank to send to.
* `size`: The size of the data to send.
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_passive_send (const gaspi_segment_id_t segment_id_local, const gaspi_offset_t offset_local, const gaspi_rank_t rank, const gaspi_size_t size, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_passive_send(segment_id_local, offset_local, rank, size, timeout_ms)
    @ccall libGPI2.gaspi_passive_send(segment_id_local::gaspi_segment_id_t, offset_local::gaspi_offset_t, rank::gaspi_rank_t, size::gaspi_size_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_passive_receive(segment_id_local, offset_local, rem_rank, size, timeout_ms)

Receive data of a given size from any rank.

### Parameters
* `segment_id_local`: The segment where to place the received data.
* `offset_local`: The local offset where to place the received data.
* `rem_rank`: Output parameter with the sender (rank).
* `size`: The size to receive.
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_passive_receive (const gaspi_segment_id_t segment_id_local, const gaspi_offset_t offset_local, gaspi_rank_t * const rem_rank, const gaspi_size_t size, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_passive_receive(segment_id_local, offset_local, rem_rank, size, timeout_ms)
    @ccall libGPI2.gaspi_passive_receive(segment_id_local::gaspi_segment_id_t, offset_local::gaspi_offset_t, rem_rank::Ptr{gaspi_rank_t}, size::gaspi_size_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

const gaspi_notification_id_t = Cushort

const gaspi_notification_t = Cuint

"""
    gaspi_notify(segment_id_remote, rank, notification_id, notification_value, queue, timeout_ms)

Post a notification with a particular value to a given rank.

### Parameters
* `segment_id_remote`: The remote segment id.
* `rank`: The rank to notify.
* `notification_id`: The notification id.
* `notification_value`: The notification value.
* `queue`: The queue to post the notification request.
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_notify (const gaspi_segment_id_t segment_id_remote, const gaspi_rank_t rank, const gaspi_notification_id_t notification_id, const gaspi_notification_t notification_value, const gaspi_queue_id_t queue, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_notify(segment_id_remote, rank, notification_id, notification_value, queue, timeout_ms)
    @ccall libGPI2.gaspi_notify(segment_id_remote::gaspi_segment_id_t, rank::gaspi_rank_t, notification_id::gaspi_notification_id_t, notification_value::gaspi_notification_t, queue::gaspi_queue_id_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_notify_waitsome(segment_id_local, notification_begin, num, first_id, timeout_ms)

Wait for some notification.

### Parameters
* `segment_id_local`: The segment identifier.
* `notification_begin`: The notification id where to start to wait.
* `num`: The number of notifications to wait for.
* `first_id`: Output parameter with the identifier of a received notification.
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_notify_waitsome (const gaspi_segment_id_t segment_id_local, const gaspi_notification_id_t notification_begin, const gaspi_number_t num, gaspi_notification_id_t * const first_id, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_notify_waitsome(segment_id_local, notification_begin, num, first_id, timeout_ms)
    @ccall libGPI2.gaspi_notify_waitsome(segment_id_local::gaspi_segment_id_t, notification_begin::gaspi_notification_id_t, num::gaspi_number_t, first_id::Ptr{gaspi_notification_id_t}, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_notify_reset(segment_id_local, notification_id, old_notification_val)

Reset a given notification (and retrieve its value).

### Parameters
* `segment_id_local`: The segment identifier.
* `notification_id`: The notification identifier to reset.
* `old_notification_val`: Output parameter with the value of the notification (before the reset).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_notify_reset (const gaspi_segment_id_t segment_id_local, const gaspi_notification_id_t notification_id, gaspi_notification_t * const old_notification_val);
```
"""
function gaspi_notify_reset(segment_id_local, notification_id, old_notification_val)
    @ccall libGPI2.gaspi_notify_reset(segment_id_local::gaspi_segment_id_t, notification_id::gaspi_notification_id_t, old_notification_val::Ptr{gaspi_notification_t})::gaspi_return_t
end

"""
    gaspi_write_notify(segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, notification_id, notification_value, queue, timeout_ms)

Write data to a given node and notify it.

### Parameters
* `segment_id_local`: The segment identifier where data to be written is located.
* `offset_local`: The offset where the data to be written is located.
* `rank`: The rank where to write and notify.
* `segment_id_remote`: The remote segment identifier where to write the data to.
* `offset_remote`: The remote offset where to write to.
* `size`: The size of the data to write.
* `notification_id`: The notification identifier to use.
* `notification_value`: The notification value used.
* `queue`: The queue where to post the request.
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_QUEUE\\_FULL if the requested could not be posted because the provided queue is full, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_write_notify (const gaspi_segment_id_t segment_id_local, const gaspi_offset_t offset_local, const gaspi_rank_t rank, const gaspi_segment_id_t segment_id_remote, const gaspi_offset_t offset_remote, const gaspi_size_t size, const gaspi_notification_id_t notification_id, const gaspi_notification_t notification_value, const gaspi_queue_id_t queue, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_write_notify(segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, notification_id, notification_value, queue, timeout_ms)
    @ccall libGPI2.gaspi_write_notify(segment_id_local::gaspi_segment_id_t, offset_local::gaspi_offset_t, rank::gaspi_rank_t, segment_id_remote::gaspi_segment_id_t, offset_remote::gaspi_offset_t, size::gaspi_size_t, notification_id::gaspi_notification_id_t, notification_value::gaspi_notification_t, queue::gaspi_queue_id_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_write_list_notify(num, segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, segment_id_notification, notification_id, notification_value, queue, timeout_ms)

Write to different locations and notify that particular rank.

### Parameters
* `num`: The number of elements in the list.
* `segment_id_local`: The list of local segments where data is located.
* `offset_local`: The list of local offsets where data to write is located.
* `rank`: The rank where to write the list and notification.
* `segment_id_remote`: The list of remote segments where to write.
* `offset_remote`: The list of remote offsets where to write.
* `size`: The list of sizes to write.
* `segment_id_notification`: The segment id used for notification.
* `notification_id`: The notification identifier to use.
* `notification_value`: The notification value to send.
* `queue`: The queue where to post the request.
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_QUEUE\\_FULL if the requested could not be posted because the provided queue is full, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_write_list_notify (const gaspi_number_t num, gaspi_segment_id_t * const segment_id_local, gaspi_offset_t * const offset_local, const gaspi_rank_t rank, gaspi_segment_id_t * const segment_id_remote, gaspi_offset_t * const offset_remote, gaspi_size_t * const size, const gaspi_segment_id_t segment_id_notification, const gaspi_notification_id_t notification_id, const gaspi_notification_t notification_value, const gaspi_queue_id_t queue, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_write_list_notify(num, segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, segment_id_notification, notification_id, notification_value, queue, timeout_ms)
    @ccall libGPI2.gaspi_write_list_notify(num::gaspi_number_t, segment_id_local::Ptr{gaspi_segment_id_t}, offset_local::Ptr{gaspi_offset_t}, rank::gaspi_rank_t, segment_id_remote::Ptr{gaspi_segment_id_t}, offset_remote::Ptr{gaspi_offset_t}, size::Ptr{gaspi_size_t}, segment_id_notification::gaspi_segment_id_t, notification_id::gaspi_notification_id_t, notification_value::gaspi_notification_t, queue::gaspi_queue_id_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_read_notify(segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, notification_id, queue, timeout_ms)

Read data from a given rank with a notification on the local side.

### Parameters
* `segment_id_local`: The segment identifier where data to be written is located.
* `offset_local`: The offset where the data to be written is located.
* `rank`: The rank where to write and notify.
* `segment_id_remote`: The remote segment identifier where to write the data to.
* `offset_remote`: The remote offset where to write to.
* `size`: The size of the data to write.
* `notification_id`: The notification identifier to use.
* `queue`: The queue where to post the request.
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_QUEUE\\_FULL if the requested could not be posted because the provided queue is full, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_read_notify (const gaspi_segment_id_t segment_id_local, const gaspi_offset_t offset_local, const gaspi_rank_t rank, const gaspi_segment_id_t segment_id_remote, const gaspi_offset_t offset_remote, const gaspi_size_t size, const gaspi_notification_id_t notification_id, const gaspi_queue_id_t queue, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_read_notify(segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, notification_id, queue, timeout_ms)
    @ccall libGPI2.gaspi_read_notify(segment_id_local::gaspi_segment_id_t, offset_local::gaspi_offset_t, rank::gaspi_rank_t, segment_id_remote::gaspi_segment_id_t, offset_remote::gaspi_offset_t, size::gaspi_size_t, notification_id::gaspi_notification_id_t, queue::gaspi_queue_id_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_read_list_notify(num, segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, segment_id_notification, notification_id, queue, timeout_ms)

Read from different locations on a given rank and notify on local side.

### Parameters
* `num`: The number of elements in the list.
* `segment_id_local`: The list of local segments where data is located.
* `offset_local`: The list of local offsets where data to write is located.
* `rank`: The rank where to write the list and notification.
* `segment_id_remote`: The list of remote segments where to write.
* `offset_remote`: The list of remote offsets where to write.
* `size`: The list of sizes to write.
* `segment_id_notification`: The segment id used for notification.
* `notification_id`: The notification identifier to use.
* `queue`: The queue where to post the request.
* `timeout_ms`: Timeout in milliseconds (or GASPI\\_BLOCK/GASPI\\_TEST).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_QUEUE\\_FULL if the requested could not be posted because the provided queue is full, GASPI\\_ERROR in case of error, GASPI\\_TIMEOUT in case of timeout.
### Prototype
```c
gaspi_return_t gaspi_read_list_notify (const gaspi_number_t num, gaspi_segment_id_t * const segment_id_local, gaspi_offset_t * const offset_local, const gaspi_rank_t rank, gaspi_segment_id_t * const segment_id_remote, gaspi_offset_t * const offset_remote, gaspi_size_t * const size, const gaspi_segment_id_t segment_id_notification, const gaspi_notification_id_t notification_id, const gaspi_queue_id_t queue, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_read_list_notify(num, segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, segment_id_notification, notification_id, queue, timeout_ms)
    @ccall libGPI2.gaspi_read_list_notify(num::gaspi_number_t, segment_id_local::Ptr{gaspi_segment_id_t}, offset_local::Ptr{gaspi_offset_t}, rank::gaspi_rank_t, segment_id_remote::Ptr{gaspi_segment_id_t}, offset_remote::Ptr{gaspi_offset_t}, size::Ptr{gaspi_size_t}, segment_id_notification::gaspi_segment_id_t, notification_id::gaspi_notification_id_t, queue::gaspi_queue_id_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_queue_purge(queue, timeout_ms)

Purge queue.

### Parameters
* `queue`: The queue to purge.
* `timeout_ms`: Timeout for operation.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error or GASPI\\_TIMEOUT in case time has expired.
### Prototype
```c
gaspi_return_t pgaspi_queue_purge(const gaspi_queue_id_t queue, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_queue_purge(queue, timeout_ms)
    @ccall libGPI2.pgaspi_queue_purge(queue::gaspi_queue_id_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_queue_size(queue, queue_size)

Get the current number of elements on a given queue.

### Parameters
* `queue`: The queue to get the size.
* `queue_size`: Output parameter with the size/elements in the queue.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_queue_size (const gaspi_queue_id_t queue, gaspi_number_t * const queue_size);
```
"""
function gaspi_queue_size(queue, queue_size)
    @ccall libGPI2.gaspi_queue_size(queue::gaspi_queue_id_t, queue_size::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    gaspi_queue_num(queue_num)

Get the number of queue available for communication.

### Parameters
* `queue_num`: Output parameter with the number of queues.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_queue_num (gaspi_number_t * const queue_num);
```
"""
function gaspi_queue_num(queue_num)
    @ccall libGPI2.gaspi_queue_num(queue_num::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    gaspi_queue_size_max(queue_size_max)

Get the maximum number of elements that can be posted to a queue (outstanding requests).

### Parameters
* `queue_size_max`: Output parameter with the maximum number of requests that can be posted to a queue.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_queue_size_max (gaspi_number_t * const queue_size_max);
```
"""
function gaspi_queue_size_max(queue_size_max)
    @ccall libGPI2.gaspi_queue_size_max(queue_size_max::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    gaspi_queue_create(queue, timeout_ms)

Create a new communication queue.

### Parameters
* `queue`: Output parameter with id of created queue.
* `timeout_ms`: A timeout value in milliseconds.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_queue_create(gaspi_queue_id_t * const queue, const gaspi_timeout_t timeout_ms);
```
"""
function gaspi_queue_create(queue, timeout_ms)
    @ccall libGPI2.gaspi_queue_create(queue::Ptr{gaspi_queue_id_t}, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_queue_delete(queue)

Delete a new communication queue.

### Parameters
* `queue`: The queue ID to delete.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_queue_delete(const gaspi_queue_id_t queue);
```
"""
function gaspi_queue_delete(queue)
    @ccall libGPI2.gaspi_queue_delete(queue::gaspi_queue_id_t)::gaspi_return_t
end

"""
    gaspi_transfer_size_min(transfer_size_min)

Get the minimum size (in bytes) that can be communicated in a single request (write, read, etc.)

### Parameters
* `transfer_size_min`: Output parameter with the minimum size that be transfered.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_transfer_size_min (gaspi_size_t * const transfer_size_min);
```
"""
function gaspi_transfer_size_min(transfer_size_min)
    @ccall libGPI2.gaspi_transfer_size_min(transfer_size_min::Ptr{gaspi_size_t})::gaspi_return_t
end

"""
    gaspi_transfer_size_max(transfer_size_max)

Get the maximum size (in bytes) that can be communicated in a single request (read, write, etc.).

### Parameters
* `transfer_size_max`: Output parameter with the maximum transfer size.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_transfer_size_max (gaspi_size_t * const transfer_size_max);
```
"""
function gaspi_transfer_size_max(transfer_size_max)
    @ccall libGPI2.gaspi_transfer_size_max(transfer_size_max::Ptr{gaspi_size_t})::gaspi_return_t
end

"""
    gaspi_notification_num(notification_num)

Get the number of available notification ids. Important to note is that the allowed ids are in [ 0, notification\\_num ) .

### Parameters
* `notification_num`: Output parameter with the number of available notifications ids.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_notification_num (gaspi_number_t * const notification_num);
```
"""
function gaspi_notification_num(notification_num)
    @ccall libGPI2.gaspi_notification_num(notification_num::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    gaspi_passive_transfer_size_min(passive_transfer_size_min)

Get the minimum allowed size (in bytes) allowed in passive communication.

### Parameters
* `passive_transfer_size_min`: Output parameter with the minimum allowed size (in bytes) for passive communication.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_passive_transfer_size_min (gaspi_size_t * const passive_transfer_size_min);
```
"""
function gaspi_passive_transfer_size_min(passive_transfer_size_min)
    @ccall libGPI2.gaspi_passive_transfer_size_min(passive_transfer_size_min::Ptr{gaspi_size_t})::gaspi_return_t
end

"""
    gaspi_passive_transfer_size_max(passive_transfer_size_max)

Get the maximum allowed size (in bytes) allowed in passive communication.

### Parameters
* `passive_transfer_size_max`: Output parameter with the maximum allowed size (in bytes) for passive communication.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_passive_transfer_size_max (gaspi_size_t * const passive_transfer_size_max);
```
"""
function gaspi_passive_transfer_size_max(passive_transfer_size_max)
    @ccall libGPI2.gaspi_passive_transfer_size_max(passive_transfer_size_max::Ptr{gaspi_size_t})::gaspi_return_t
end

"""
    gaspi_atomic_max(max_value)

Maximum value an [`gaspi_atomic_value_t`](@ref) can hold.

### Parameters
* `max_value`: Output parameter with the maximum value allowed for atomic operations.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_atomic_max(gaspi_atomic_value_t *max_value);
```
"""
function gaspi_atomic_max(max_value)
    @ccall libGPI2.gaspi_atomic_max(max_value::Ptr{gaspi_atomic_value_t})::gaspi_return_t
end

"""
    gaspi_allreduce_buf_size(buf_size)

Get the internal buffer size for [`gaspi_allreduce_user`](@ref).

### Parameters
* `buf_size`: Output parameter with the buffer size.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_allreduce_buf_size (gaspi_size_t * const buf_size);
```
"""
function gaspi_allreduce_buf_size(buf_size)
    @ccall libGPI2.gaspi_allreduce_buf_size(buf_size::Ptr{gaspi_size_t})::gaspi_return_t
end

"""
    gaspi_allreduce_elem_max(elem_max)

Get the maximum number of elements allowed in [`gaspi_allreduce`](@ref).

### Parameters
* `elem_max`: Output parameter with the maximum number of elements.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_allreduce_elem_max (gaspi_number_t * const elem_max);
```
"""
function gaspi_allreduce_elem_max(elem_max)
    @ccall libGPI2.gaspi_allreduce_elem_max(elem_max::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    gaspi_queue_max(queue_max)

Get the maximum number of queues that may be used. It is the maximum of initialized queues plus dynamically created queues.

### Parameters
* `queue_max`: Output parameter with maximum number of queues.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_queue_max(gaspi_number_t * const queue_max);
```
"""
function gaspi_queue_max(queue_max)
    @ccall libGPI2.gaspi_queue_max(queue_max::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    gaspi_network_type(network_type)

Get the network type.

### Parameters
* `network_type`: Output parameter with the network type.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_network_type (gaspi_network_t * const network_type);
```
"""
function gaspi_network_type(network_type)
    @ccall libGPI2.gaspi_network_type(network_type::Ptr{gaspi_network_t})::gaspi_return_t
end

"""
    gaspi_build_infrastructure(build)

Get current value of config build\\_infrastructure.

### Parameters
* `build`: Output parameter with the value.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_build_infrastructure (gaspi_number_t * const build);
```
"""
function gaspi_build_infrastructure(build)
    @ccall libGPI2.gaspi_build_infrastructure(build::Ptr{gaspi_number_t})::gaspi_return_t
end

const gaspi_cycles_t = Culong

"""
    gaspi_time_ticks(ticks)

Get the number of cycles (ticks).

### Parameters
* `ticks`: Output parameter with the ticks.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_time_ticks (gaspi_cycles_t * const ticks);
```
"""
function gaspi_time_ticks(ticks)
    @ccall libGPI2.gaspi_time_ticks(ticks::Ptr{gaspi_cycles_t})::gaspi_return_t
end

const gaspi_time_t = Cfloat

"""
    gaspi_time_get(wtime)

Get elapsed time (in milliseconds).

### Parameters
* `wtime`: Output parameter with the time in milliseconds.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_time_get (gaspi_time_t * const wtime);
```
"""
function gaspi_time_get(wtime)
    @ccall libGPI2.gaspi_time_get(wtime::Ptr{gaspi_time_t})::gaspi_return_t
end

const gaspi_string_t = Cstring

"""
    gaspi_print_error(error_code, error_message)

Translate a error code to a text message. NOTE: the parameter error\\_message will allocate memory which the application must de-allocate (using free())

### Parameters
* `error_code`: The error code to translate.
* `error_message`: Output parameter with the text message.
### Returns
GASPI\\_SUCCESS in case of SUCCESS, GASPI\\_ERR\\_MEMALLOC in case of error there was an error allocating the error\\_message buffer.
### Prototype
```c
gaspi_return_t gaspi_print_error( gaspi_return_t error_code, gaspi_string_t *error_message);
```
"""
function gaspi_print_error(error_code, error_message)
    @ccall libGPI2.gaspi_print_error(error_code::gaspi_return_t, error_message::Ptr{gaspi_string_t})::gaspi_return_t
end

"""
    gaspi_state_t

State of queue.
"""
@cenum gaspi_state_t::UInt32 begin
    GASPI_STATE_HEALTHY = 0
    GASPI_STATE_CORRUPT = 1
end

const gaspi_state_vector_t = Ptr{gaspi_state_t}

"""
    gaspi_state_vec_get(state_vector)

Get the state vector.

### Parameters
* `state_vector`: Vector with state of each rank. The vector must be allocated with enough place to hold the state of all ranks.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_state_vec_get (gaspi_state_vector_t state_vector);
```
"""
function gaspi_state_vec_get(state_vector)
    @ccall libGPI2.gaspi_state_vec_get(state_vector::gaspi_state_vector_t)::gaspi_return_t
end

"""
    gaspi_statistic_verbosity_level(_verbosity_level)

Set the verbosity level.

### Parameters
* `_verbosity_level`: the level of desired verbosity
### Returns
GASPI\\_SUCCESS in case of SUCCESS, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_statistic_verbosity_level(gaspi_number_t _verbosity_level);
```
"""
function gaspi_statistic_verbosity_level(_verbosity_level)
    @ccall libGPI2.gaspi_statistic_verbosity_level(_verbosity_level::gaspi_number_t)::gaspi_return_t
end

"""
    gaspi_statistic_counter_max(counter_max)

Get the maximum number of statistics counters.

### Parameters
* `counter_max`: Output parameter with the maximum number of counters.
### Returns
GASPI\\_SUCCESS in case of SUCCESS, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_statistic_counter_max(gaspi_number_t* counter_max);
```
"""
function gaspi_statistic_counter_max(counter_max)
    @ccall libGPI2.gaspi_statistic_counter_max(counter_max::Ptr{gaspi_number_t})::gaspi_return_t
end

const gaspi_statistic_counter_t = Cuint

"""
    gaspi_statistic_argument_t

Statistical information
"""
@cenum gaspi_statistic_argument_t::UInt32 begin
    GASPI_STATISTIC_ARGUMENT_NONE = 0
    GASPI_STATISTIC_ARGUMENT_RANK = 1
end

"""
    gaspi_statistic_counter_info(counter, counter_argument, counter_name, counter_description, verbosity_level)

Get information about a counter.

### Parameters
* `counter`: the counter.
* `counter_argument`: Output parameter with meaning of the counter.
* `counter_name`: Output parameter with the name of the counter.
* `counter_description`: Output parameter with a more detailed description of the counter.
* `verbosity_level`: Output parameter with the minumum verbosity level to activate the counter.
### Returns
GASPI\\_SUCCESS in case of SUCCESS, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_statistic_counter_info( gaspi_statistic_counter_t counter, gaspi_statistic_argument_t* counter_argument, gaspi_string_t* counter_name, gaspi_string_t* counter_description, gaspi_number_t* verbosity_level);
```
"""
function gaspi_statistic_counter_info(counter, counter_argument, counter_name, counter_description, verbosity_level)
    @ccall libGPI2.gaspi_statistic_counter_info(counter::gaspi_statistic_counter_t, counter_argument::Ptr{gaspi_statistic_argument_t}, counter_name::Ptr{gaspi_string_t}, counter_description::Ptr{gaspi_string_t}, verbosity_level::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    gaspi_statistic_counter_get(counter, argument, value)

Get statistical counter.

### Parameters
* `counter`: the counter to be retrieved.
* `argument`: the argument for the counter.
* `value`: Output paramter with the current value of the counter.
### Returns
GASPI\\_SUCCESS in case of SUCCESS, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_statistic_counter_get ( gaspi_statistic_counter_t counter, gaspi_number_t argument, unsigned long *value);
```
"""
function gaspi_statistic_counter_get(counter, argument, value)
    @ccall libGPI2.gaspi_statistic_counter_get(counter::gaspi_statistic_counter_t, argument::gaspi_number_t, value::Ptr{Culong})::gaspi_return_t
end

"""
    gaspi_statistic_counter_reset(counter)

Reset a counter (set to 0).

### Parameters
* `counter`: The counter to reset.
### Returns
GASPI\\_SUCCESS in case of SUCCESS, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_statistic_counter_reset (gaspi_statistic_counter_t counter);
```
"""
function gaspi_statistic_counter_reset(counter)
    @ccall libGPI2.gaspi_statistic_counter_reset(counter::gaspi_statistic_counter_t)::gaspi_return_t
end

const gaspi_char = Cchar

const gaspi_uchar = Cuchar

const gaspi_short = Cshort

const gaspi_ushort = Cushort

const gaspi_long = Clong

const gaspi_ulong = Culong

const gaspi_float = Cfloat

const gaspi_double = Cdouble

"""
    gaspi_initialized(initialized)

Check if GPI-2 is initialized

### Parameters
* `initialized`: Output parameter with flag value.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_initialized (gaspi_number_t * initialized);
```
"""
function gaspi_initialized(initialized)
    @ccall libGPI2.gaspi_initialized(initialized::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    gaspi_proc_local_rank(local_rank)

Get the process local rank.

### Parameters
* `local_rank`: Rank within a node of calling process.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_proc_local_rank (gaspi_rank_t * const local_rank);
```
"""
function gaspi_proc_local_rank(local_rank)
    @ccall libGPI2.gaspi_proc_local_rank(local_rank::Ptr{gaspi_rank_t})::gaspi_return_t
end

"""
    gaspi_proc_local_num(local_num)

Get the number of processes (ranks) started by the application.

### Parameters
* `local_num`: The number of processes (ranks) in the same node
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_proc_local_num (gaspi_rank_t * const local_num);
```
"""
function gaspi_proc_local_num(local_num)
    @ccall libGPI2.gaspi_proc_local_num(local_num::Ptr{gaspi_rank_t})::gaspi_return_t
end

"""
    gaspi_cpu_frequency(cpu_mhz)

Get the CPU frequency.

### Parameters
* `cpu_mhz`: Output parameter with the frequency.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_cpu_frequency (gaspi_float * const cpu_mhz);
```
"""
function gaspi_cpu_frequency(cpu_mhz)
    @ccall libGPI2.gaspi_cpu_frequency(cpu_mhz::Ptr{gaspi_float})::gaspi_return_t
end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function gaspi_printf(fmt, va_list...)
        :(@ccall(libGPI2.gaspi_printf(fmt::Cstring; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function gaspi_printf_to(rank, fmt, va_list...)
        :(@ccall(libGPI2.gaspi_printf_to(rank::gaspi_rank_t, fmt::Cstring; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

"""
    gaspi_print_affinity_mask()

Print the CPU's affinity mask.

### Prototype
```c
void gaspi_print_affinity_mask (void);
```
"""
function gaspi_print_affinity_mask()
    @ccall libGPI2.gaspi_print_affinity_mask()::Cvoid
end

"""
    gaspi_numa_socket(socket)

Get NUMA socket

### Parameters
* `socket`: Output parameter with the socket
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case GPI2 was not started with NUMA enabled.
### Prototype
```c
gaspi_return_t gaspi_numa_socket(gaspi_uchar * const socket);
```
"""
function gaspi_numa_socket(socket)
    @ccall libGPI2.gaspi_numa_socket(socket::Ptr{gaspi_uchar})::gaspi_return_t
end

"""
    gaspi_set_socket_affinity(socket)

Set socket affinity

### Prototype
```c
gaspi_return_t gaspi_set_socket_affinity (const gaspi_uchar socket);
```
"""
function gaspi_set_socket_affinity(socket)
    @ccall libGPI2.gaspi_set_socket_affinity(socket::gaspi_uchar)::gaspi_return_t
end

"""
    gaspi_error_str(error_code)

Get string describing return value. This is slightly more practical than [`gaspi_print_error`](@ref).

### Parameters
* `error_code`: The return value to be described.
### Returns
A string that describes the return value.
### Prototype
```c
gaspi_string_t gaspi_error_str(gaspi_return_t error_code);
```
"""
function gaspi_error_str(error_code)
    @ccall libGPI2.gaspi_error_str(error_code::gaspi_return_t)::gaspi_string_t
end

"""
    gaspi_proc_ping(rank, tout)

Ping a particular proc (rank). This is useful in FT applications to determine if a rank is alive.

### Parameters
* `rank`: The rank to ping.
* `tout`: A timeout value in milliseconds.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_proc_ping (const gaspi_rank_t rank, gaspi_timeout_t tout);
```
"""
function gaspi_proc_ping(rank, tout)
    @ccall libGPI2.gaspi_proc_ping(rank::gaspi_rank_t, tout::gaspi_timeout_t)::gaspi_return_t
end

"""
    gaspi_segment_avail_local(avail_seg_id)

Get an available segment id (only locally).

To create/alloc a segment, the application must provide a segment id. This provides a helper function to find the next available id locally i.e. for the calling rank.

### Parameters
* `avail_seg_id`: The available segment id.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_segment_avail_local (gaspi_segment_id_t* const avail_seg_id);
```
"""
function gaspi_segment_avail_local(avail_seg_id)
    @ccall libGPI2.gaspi_segment_avail_local(avail_seg_id::Ptr{gaspi_segment_id_t})::gaspi_return_t
end

"""
    gaspi_segment_size(segment_id, rank, size)

Get the size of a given segment on a particular rank.

### Parameters
* `segment_id`: The segment id we are interested in.
* `rank`: The rank.
* `size`: Output parameter with the size of the segment.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_segment_size (const gaspi_segment_id_t segment_id, const gaspi_rank_t rank, gaspi_size_t * const size);
```
"""
function gaspi_segment_size(segment_id, rank, size)
    @ccall libGPI2.gaspi_segment_size(segment_id::gaspi_segment_id_t, rank::gaspi_rank_t, size::Ptr{gaspi_size_t})::gaspi_return_t
end

"""
    gaspi_rw_list_elem_max(elem_max)

Get the maximum number of elements allowed in list (read, write) operations.

### Parameters
* `elem_max`: Output parameter with the maximum number of elements.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_rw_list_elem_max (gaspi_number_t * const elem_max);
```
"""
function gaspi_rw_list_elem_max(elem_max)
    @ccall libGPI2.gaspi_rw_list_elem_max(elem_max::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    gaspi_threads_get_tid(tid)

Get thread identifier

### Parameters
* `Output`: parameter with thread identifier
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_threads_get_tid(gaspi_int * const tid) __attribute__ ((deprecated));
```
"""
function gaspi_threads_get_tid(tid)
    @ccall libGPI2.gaspi_threads_get_tid(tid::Ptr{gaspi_int})::gaspi_return_t
end

"""
    gaspi_threads_get_total(num)

Get total number of threads

### Parameters
* `Output`: parameter with total number of threads
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_threads_get_total(gaspi_int *const num) __attribute__ ((deprecated));
```
"""
function gaspi_threads_get_total(num)
    @ccall libGPI2.gaspi_threads_get_total(num::Ptr{gaspi_int})::gaspi_return_t
end

"""
    gaspi_threads_get_num_cores(cores)

Get total number of available cpu cores

### Parameters
* `cores`: Output paramter with the number of cores.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_threads_get_num_cores(gaspi_int * const cores) __attribute__ ((deprecated));
```
"""
function gaspi_threads_get_num_cores(cores)
    @ccall libGPI2.gaspi_threads_get_num_cores(cores::Ptr{gaspi_int})::gaspi_return_t
end

"""
    gaspi_threads_init(num)

Initialize threads (in all available cores)

### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_threads_init(gaspi_int * const num) __attribute__ ((deprecated));
```
"""
function gaspi_threads_init(num)
    @ccall libGPI2.gaspi_threads_init(num::Ptr{gaspi_int})::gaspi_return_t
end

"""
    gaspi_threads_init_user(use_nr_of_threads)

Initialize threads (a particular number of threads)

### Parameters
* `use_nr_of_threads`: Number of threads to start.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_threads_init_user(const unsigned int use_nr_of_threads) __attribute__ ((deprecated));
```
"""
function gaspi_threads_init_user(use_nr_of_threads)
    @ccall libGPI2.gaspi_threads_init_user(use_nr_of_threads::Cuint)::gaspi_return_t
end

"""
    gaspi_threads_term()

Finalize threads

### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_threads_term(void) __attribute__ ((deprecated));
```
"""
function gaspi_threads_term()
    @ccall libGPI2.gaspi_threads_term()::gaspi_return_t
end

"""
    gaspi_threads_run(_function, arg)

Run a particular task (function)

### Parameters
* `function`: The function to run.
* `arg`: The arguments of the function to run.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_threads_run(void* (*function)(void*), void *arg) __attribute__ ((deprecated));
```
"""
function gaspi_threads_run(_function, arg)
    @ccall libGPI2.gaspi_threads_run(_function::Ptr{Cvoid}, arg::Ptr{Cvoid})::gaspi_return_t
end

"""
    gaspi_threads_register(tid)

Register a thread with the pool.

### Parameters
* `tid`: Output parameter with the thread identifier.
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_threads_register(gaspi_int * tid);
```
"""
function gaspi_threads_register(tid)
    @ccall libGPI2.gaspi_threads_register(tid::Ptr{gaspi_int})::gaspi_return_t
end

"""
    gaspi_threads_sync()

Synchronize all local threads (local barrier).

### Prototype
```c
void gaspi_threads_sync(void);
```
"""
function gaspi_threads_sync()
    @ccall libGPI2.gaspi_threads_sync()::Cvoid
end

"""
    gaspi_threads_sync_all(g, timeout_ms)

Synchronize all threads in a group (global barrier). Implies a [`gaspi_barrier`](@ref) within the group.

### Parameters
* `group`: The group involved in the barrier.
* `timeout`: The timeout to be applied in the global barrier([`gaspi_barrier`](@ref)).
### Returns
GASPI\\_SUCCESS in case of success, GASPI\\_ERROR in case of error.
### Prototype
```c
gaspi_return_t gaspi_threads_sync_all(const gaspi_group_t g, const gaspi_timeout_t timeout_ms) __attribute__ ((deprecated));
```
"""
function gaspi_threads_sync_all(g, timeout_ms)
    @ccall libGPI2.gaspi_threads_sync_all(g::gaspi_group_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_config_get(config)

### Prototype
```c
gaspi_return_t pgaspi_config_get (gaspi_config_t * const config);
```
"""
function pgaspi_config_get(config)
    @ccall libGPI2.pgaspi_config_get(config::Ptr{gaspi_config_t})::gaspi_return_t
end

"""
    pgaspi_config_set(new_config)

### Prototype
```c
gaspi_return_t pgaspi_config_set (const gaspi_config_t new_config);
```
"""
function pgaspi_config_set(new_config)
    @ccall libGPI2.pgaspi_config_set(new_config::gaspi_config_t)::gaspi_return_t
end

"""
    pgaspi_version(version)

### Prototype
```c
gaspi_return_t pgaspi_version (float *version);
```
"""
function pgaspi_version(version)
    @ccall libGPI2.pgaspi_version(version::Ptr{Cfloat})::gaspi_return_t
end

"""
    pgaspi_proc_init(timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_proc_init (const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_proc_init(timeout_ms)
    @ccall libGPI2.pgaspi_proc_init(timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_initialized(initialized)

### Prototype
```c
gaspi_return_t pgaspi_initialized (gaspi_number_t * initialized);
```
"""
function pgaspi_initialized(initialized)
    @ccall libGPI2.pgaspi_initialized(initialized::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    pgaspi_proc_term(timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_proc_term (const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_proc_term(timeout_ms)
    @ccall libGPI2.pgaspi_proc_term(timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_proc_local_rank(local_rank)

### Prototype
```c
gaspi_return_t pgaspi_proc_local_rank (gaspi_rank_t * const local_rank);
```
"""
function pgaspi_proc_local_rank(local_rank)
    @ccall libGPI2.pgaspi_proc_local_rank(local_rank::Ptr{gaspi_rank_t})::gaspi_return_t
end

"""
    pgaspi_proc_local_num(local_num)

### Prototype
```c
gaspi_return_t pgaspi_proc_local_num (gaspi_rank_t * const local_num);
```
"""
function pgaspi_proc_local_num(local_num)
    @ccall libGPI2.pgaspi_proc_local_num(local_num::Ptr{gaspi_rank_t})::gaspi_return_t
end

"""
    pgaspi_proc_rank(rank)

### Prototype
```c
gaspi_return_t pgaspi_proc_rank (gaspi_rank_t * const rank);
```
"""
function pgaspi_proc_rank(rank)
    @ccall libGPI2.pgaspi_proc_rank(rank::Ptr{gaspi_rank_t})::gaspi_return_t
end

"""
    pgaspi_proc_num(proc_num)

### Prototype
```c
gaspi_return_t pgaspi_proc_num (gaspi_rank_t * const proc_num);
```
"""
function pgaspi_proc_num(proc_num)
    @ccall libGPI2.pgaspi_proc_num(proc_num::Ptr{gaspi_rank_t})::gaspi_return_t
end

"""
    pgaspi_proc_kill(rank, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_proc_kill (const gaspi_rank_t rank, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_proc_kill(rank, timeout_ms)
    @ccall libGPI2.pgaspi_proc_kill(rank::gaspi_rank_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_connect(rank, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_connect (const gaspi_rank_t rank, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_connect(rank, timeout_ms)
    @ccall libGPI2.pgaspi_connect(rank::gaspi_rank_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_disconnect(rank, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_disconnect (const gaspi_rank_t rank, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_disconnect(rank, timeout_ms)
    @ccall libGPI2.pgaspi_disconnect(rank::gaspi_rank_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_group_create(group)

### Prototype
```c
gaspi_return_t pgaspi_group_create (gaspi_group_t * const group);
```
"""
function pgaspi_group_create(group)
    @ccall libGPI2.pgaspi_group_create(group::Ptr{gaspi_group_t})::gaspi_return_t
end

"""
    pgaspi_group_delete(group)

### Prototype
```c
gaspi_return_t pgaspi_group_delete (const gaspi_group_t group);
```
"""
function pgaspi_group_delete(group)
    @ccall libGPI2.pgaspi_group_delete(group::gaspi_group_t)::gaspi_return_t
end

"""
    pgaspi_group_add(group, rank)

### Prototype
```c
gaspi_return_t pgaspi_group_add (const gaspi_group_t group, const gaspi_rank_t rank);
```
"""
function pgaspi_group_add(group, rank)
    @ccall libGPI2.pgaspi_group_add(group::gaspi_group_t, rank::gaspi_rank_t)::gaspi_return_t
end

"""
    pgaspi_group_commit(group, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_group_commit (const gaspi_group_t group, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_group_commit(group, timeout_ms)
    @ccall libGPI2.pgaspi_group_commit(group::gaspi_group_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_group_num(group_num)

### Prototype
```c
gaspi_return_t pgaspi_group_num (gaspi_number_t * const group_num);
```
"""
function pgaspi_group_num(group_num)
    @ccall libGPI2.pgaspi_group_num(group_num::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    pgaspi_group_size(group, group_size)

### Prototype
```c
gaspi_return_t pgaspi_group_size (const gaspi_group_t group, gaspi_number_t * const group_size);
```
"""
function pgaspi_group_size(group, group_size)
    @ccall libGPI2.pgaspi_group_size(group::gaspi_group_t, group_size::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    pgaspi_group_ranks(group, group_ranks)

### Prototype
```c
gaspi_return_t pgaspi_group_ranks (const gaspi_group_t group, gaspi_rank_t * const group_ranks);
```
"""
function pgaspi_group_ranks(group, group_ranks)
    @ccall libGPI2.pgaspi_group_ranks(group::gaspi_group_t, group_ranks::Ptr{gaspi_rank_t})::gaspi_return_t
end

"""
    pgaspi_group_max(group_max)

### Prototype
```c
gaspi_return_t pgaspi_group_max (gaspi_number_t * const group_max);
```
"""
function pgaspi_group_max(group_max)
    @ccall libGPI2.pgaspi_group_max(group_max::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    pgaspi_segment_alloc(segment_id, size, alloc_policy)

### Prototype
```c
gaspi_return_t pgaspi_segment_alloc (const gaspi_segment_id_t segment_id, const gaspi_size_t size, const gaspi_alloc_t alloc_policy);
```
"""
function pgaspi_segment_alloc(segment_id, size, alloc_policy)
    @ccall libGPI2.pgaspi_segment_alloc(segment_id::gaspi_segment_id_t, size::gaspi_size_t, alloc_policy::gaspi_alloc_t)::gaspi_return_t
end

"""
    pgaspi_segment_delete(segment_id)

### Prototype
```c
gaspi_return_t pgaspi_segment_delete (const gaspi_segment_id_t segment_id);
```
"""
function pgaspi_segment_delete(segment_id)
    @ccall libGPI2.pgaspi_segment_delete(segment_id::gaspi_segment_id_t)::gaspi_return_t
end

"""
    pgaspi_segment_register(segment_id, rank, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_segment_register (const gaspi_segment_id_t segment_id, const gaspi_rank_t rank, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_segment_register(segment_id, rank, timeout_ms)
    @ccall libGPI2.pgaspi_segment_register(segment_id::gaspi_segment_id_t, rank::gaspi_rank_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_segment_create(segment_id, size, group, timeout_ms, alloc_policy)

### Prototype
```c
gaspi_return_t pgaspi_segment_create (const gaspi_segment_id_t segment_id, const gaspi_size_t size, const gaspi_group_t group, const gaspi_timeout_t timeout_ms, const gaspi_alloc_t alloc_policy);
```
"""
function pgaspi_segment_create(segment_id, size, group, timeout_ms, alloc_policy)
    @ccall libGPI2.pgaspi_segment_create(segment_id::gaspi_segment_id_t, size::gaspi_size_t, group::gaspi_group_t, timeout_ms::gaspi_timeout_t, alloc_policy::gaspi_alloc_t)::gaspi_return_t
end

"""
    pgaspi_segment_bind(segment_id, pointer, size, memory_description)

### Prototype
```c
gaspi_return_t pgaspi_segment_bind ( gaspi_segment_id_t const segment_id, gaspi_pointer_t const pointer, gaspi_size_t const size, gaspi_memory_description_t const memory_description);
```
"""
function pgaspi_segment_bind(segment_id, pointer, size, memory_description)
    @ccall libGPI2.pgaspi_segment_bind(segment_id::gaspi_segment_id_t, pointer::gaspi_pointer_t, size::gaspi_size_t, memory_description::gaspi_memory_description_t)::gaspi_return_t
end

"""
    pgaspi_segment_use(segment_id, pointer, size, group, timeout, memory_description)

### Prototype
```c
gaspi_return_t pgaspi_segment_use ( gaspi_segment_id_t const segment_id, gaspi_pointer_t const pointer, gaspi_size_t const size, gaspi_group_t const group, gaspi_timeout_t const timeout, gaspi_memory_description_t const memory_description);
```
"""
function pgaspi_segment_use(segment_id, pointer, size, group, timeout, memory_description)
    @ccall libGPI2.pgaspi_segment_use(segment_id::gaspi_segment_id_t, pointer::gaspi_pointer_t, size::gaspi_size_t, group::gaspi_group_t, timeout::gaspi_timeout_t, memory_description::gaspi_memory_description_t)::gaspi_return_t
end

"""
    pgaspi_segment_num(segment_num)

### Prototype
```c
gaspi_return_t pgaspi_segment_num (gaspi_number_t * const segment_num);
```
"""
function pgaspi_segment_num(segment_num)
    @ccall libGPI2.pgaspi_segment_num(segment_num::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    pgaspi_segment_list(num, segment_id_list)

### Prototype
```c
gaspi_return_t pgaspi_segment_list (const gaspi_number_t num, gaspi_segment_id_t * const segment_id_list);
```
"""
function pgaspi_segment_list(num, segment_id_list)
    @ccall libGPI2.pgaspi_segment_list(num::gaspi_number_t, segment_id_list::Ptr{gaspi_segment_id_t})::gaspi_return_t
end

"""
    pgaspi_segment_ptr(segment_id, ptr)

### Prototype
```c
gaspi_return_t pgaspi_segment_ptr (const gaspi_segment_id_t segment_id, gaspi_pointer_t * ptr);
```
"""
function pgaspi_segment_ptr(segment_id, ptr)
    @ccall libGPI2.pgaspi_segment_ptr(segment_id::gaspi_segment_id_t, ptr::Ptr{gaspi_pointer_t})::gaspi_return_t
end

"""
    pgaspi_segment_size(segment_id, rank, size)

### Prototype
```c
gaspi_return_t pgaspi_segment_size (const gaspi_segment_id_t segment_id, const gaspi_rank_t rank, gaspi_size_t * const size);
```
"""
function pgaspi_segment_size(segment_id, rank, size)
    @ccall libGPI2.pgaspi_segment_size(segment_id::gaspi_segment_id_t, rank::gaspi_rank_t, size::Ptr{gaspi_size_t})::gaspi_return_t
end

"""
    pgaspi_segment_max(segment_max)

### Prototype
```c
gaspi_return_t pgaspi_segment_max (gaspi_number_t * const segment_max);
```
"""
function pgaspi_segment_max(segment_max)
    @ccall libGPI2.pgaspi_segment_max(segment_max::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    pgaspi_write(segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, queue, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_write (const gaspi_segment_id_t segment_id_local, const gaspi_offset_t offset_local, const gaspi_rank_t rank, const gaspi_segment_id_t segment_id_remote, const gaspi_offset_t offset_remote, const gaspi_size_t size, const gaspi_queue_id_t queue, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_write(segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, queue, timeout_ms)
    @ccall libGPI2.pgaspi_write(segment_id_local::gaspi_segment_id_t, offset_local::gaspi_offset_t, rank::gaspi_rank_t, segment_id_remote::gaspi_segment_id_t, offset_remote::gaspi_offset_t, size::gaspi_size_t, queue::gaspi_queue_id_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_read(segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, queue, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_read (const gaspi_segment_id_t segment_id_local, const gaspi_offset_t offset_local, const gaspi_rank_t rank, const gaspi_segment_id_t segment_id_remote, const gaspi_offset_t offset_remote, const gaspi_size_t size, const gaspi_queue_id_t queue, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_read(segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, queue, timeout_ms)
    @ccall libGPI2.pgaspi_read(segment_id_local::gaspi_segment_id_t, offset_local::gaspi_offset_t, rank::gaspi_rank_t, segment_id_remote::gaspi_segment_id_t, offset_remote::gaspi_offset_t, size::gaspi_size_t, queue::gaspi_queue_id_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_write_list(num, segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, queue, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_write_list (const gaspi_number_t num, gaspi_segment_id_t * const segment_id_local, gaspi_offset_t * const offset_local, const gaspi_rank_t rank, gaspi_segment_id_t * const segment_id_remote, gaspi_offset_t * const offset_remote, gaspi_size_t * const size, const gaspi_queue_id_t queue, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_write_list(num, segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, queue, timeout_ms)
    @ccall libGPI2.pgaspi_write_list(num::gaspi_number_t, segment_id_local::Ptr{gaspi_segment_id_t}, offset_local::Ptr{gaspi_offset_t}, rank::gaspi_rank_t, segment_id_remote::Ptr{gaspi_segment_id_t}, offset_remote::Ptr{gaspi_offset_t}, size::Ptr{gaspi_size_t}, queue::gaspi_queue_id_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_read_list(num, segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, queue, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_read_list (const gaspi_number_t num, gaspi_segment_id_t * const segment_id_local, gaspi_offset_t * const offset_local, const gaspi_rank_t rank, gaspi_segment_id_t * const segment_id_remote, gaspi_offset_t * const offset_remote, gaspi_size_t * const size, const gaspi_queue_id_t queue, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_read_list(num, segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, queue, timeout_ms)
    @ccall libGPI2.pgaspi_read_list(num::gaspi_number_t, segment_id_local::Ptr{gaspi_segment_id_t}, offset_local::Ptr{gaspi_offset_t}, rank::gaspi_rank_t, segment_id_remote::Ptr{gaspi_segment_id_t}, offset_remote::Ptr{gaspi_offset_t}, size::Ptr{gaspi_size_t}, queue::gaspi_queue_id_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_wait(queue, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_wait (const gaspi_queue_id_t queue, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_wait(queue, timeout_ms)
    @ccall libGPI2.pgaspi_wait(queue::gaspi_queue_id_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_barrier(group, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_barrier (const gaspi_group_t group, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_barrier(group, timeout_ms)
    @ccall libGPI2.pgaspi_barrier(group::gaspi_group_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_allreduce(buffer_send, buffer_receive, num, operation, datatyp, group, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_allreduce (const gaspi_pointer_t buffer_send, gaspi_pointer_t const buffer_receive, const gaspi_number_t num, const gaspi_operation_t operation, const gaspi_datatype_t datatyp, const gaspi_group_t group, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_allreduce(buffer_send, buffer_receive, num, operation, datatyp, group, timeout_ms)
    @ccall libGPI2.pgaspi_allreduce(buffer_send::gaspi_pointer_t, buffer_receive::gaspi_pointer_t, num::gaspi_number_t, operation::gaspi_operation_t, datatyp::gaspi_datatype_t, group::gaspi_group_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_allreduce_user(buffer_send, buffer_receive, num, element_size, reduce_operation, reduce_state, group, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_allreduce_user (const gaspi_pointer_t buffer_send, gaspi_pointer_t const buffer_receive, const gaspi_number_t num, const gaspi_size_t element_size, gaspi_reduce_operation_t const reduce_operation, gaspi_reduce_state_t const reduce_state, const gaspi_group_t group, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_allreduce_user(buffer_send, buffer_receive, num, element_size, reduce_operation, reduce_state, group, timeout_ms)
    @ccall libGPI2.pgaspi_allreduce_user(buffer_send::gaspi_pointer_t, buffer_receive::gaspi_pointer_t, num::gaspi_number_t, element_size::gaspi_size_t, reduce_operation::gaspi_reduce_operation_t, reduce_state::gaspi_reduce_state_t, group::gaspi_group_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_atomic_fetch_add(segment_id, offset, rank, val_add, val_old, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_atomic_fetch_add (const gaspi_segment_id_t segment_id, const gaspi_offset_t offset, const gaspi_rank_t rank, const gaspi_atomic_value_t val_add, gaspi_atomic_value_t * const val_old, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_atomic_fetch_add(segment_id, offset, rank, val_add, val_old, timeout_ms)
    @ccall libGPI2.pgaspi_atomic_fetch_add(segment_id::gaspi_segment_id_t, offset::gaspi_offset_t, rank::gaspi_rank_t, val_add::gaspi_atomic_value_t, val_old::Ptr{gaspi_atomic_value_t}, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_atomic_compare_swap(segment_id, offset, rank, comparator, val_new, val_old, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_atomic_compare_swap (const gaspi_segment_id_t segment_id, const gaspi_offset_t offset, const gaspi_rank_t rank, const gaspi_atomic_value_t comparator, const gaspi_atomic_value_t val_new, gaspi_atomic_value_t * const val_old, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_atomic_compare_swap(segment_id, offset, rank, comparator, val_new, val_old, timeout_ms)
    @ccall libGPI2.pgaspi_atomic_compare_swap(segment_id::gaspi_segment_id_t, offset::gaspi_offset_t, rank::gaspi_rank_t, comparator::gaspi_atomic_value_t, val_new::gaspi_atomic_value_t, val_old::Ptr{gaspi_atomic_value_t}, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_passive_send(segment_id_local, offset_local, rank, size, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_passive_send (const gaspi_segment_id_t segment_id_local, const gaspi_offset_t offset_local, const gaspi_rank_t rank, const gaspi_size_t size, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_passive_send(segment_id_local, offset_local, rank, size, timeout_ms)
    @ccall libGPI2.pgaspi_passive_send(segment_id_local::gaspi_segment_id_t, offset_local::gaspi_offset_t, rank::gaspi_rank_t, size::gaspi_size_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_passive_receive(segment_id_local, offset_local, rem_rank, size, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_passive_receive (const gaspi_segment_id_t segment_id_local, const gaspi_offset_t offset_local, gaspi_rank_t * const rem_rank, const gaspi_size_t size, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_passive_receive(segment_id_local, offset_local, rem_rank, size, timeout_ms)
    @ccall libGPI2.pgaspi_passive_receive(segment_id_local::gaspi_segment_id_t, offset_local::gaspi_offset_t, rem_rank::Ptr{gaspi_rank_t}, size::gaspi_size_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_notify(segment_id_remote, rank, notification_id, notification_value, queue, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_notify (const gaspi_segment_id_t segment_id_remote, const gaspi_rank_t rank, const gaspi_notification_id_t notification_id, const gaspi_notification_t notification_value, const gaspi_queue_id_t queue, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_notify(segment_id_remote, rank, notification_id, notification_value, queue, timeout_ms)
    @ccall libGPI2.pgaspi_notify(segment_id_remote::gaspi_segment_id_t, rank::gaspi_rank_t, notification_id::gaspi_notification_id_t, notification_value::gaspi_notification_t, queue::gaspi_queue_id_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_notify_waitsome(segment_id_local, notification_begin, num, first_id, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_notify_waitsome (const gaspi_segment_id_t segment_id_local, const gaspi_notification_id_t notification_begin, const gaspi_number_t num, gaspi_notification_id_t * const first_id, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_notify_waitsome(segment_id_local, notification_begin, num, first_id, timeout_ms)
    @ccall libGPI2.pgaspi_notify_waitsome(segment_id_local::gaspi_segment_id_t, notification_begin::gaspi_notification_id_t, num::gaspi_number_t, first_id::Ptr{gaspi_notification_id_t}, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_notify_reset(segment_id_local, notification_id, old_notification_val)

### Prototype
```c
gaspi_return_t pgaspi_notify_reset (const gaspi_segment_id_t segment_id_local, const gaspi_notification_id_t notification_id, gaspi_notification_t * const old_notification_val);
```
"""
function pgaspi_notify_reset(segment_id_local, notification_id, old_notification_val)
    @ccall libGPI2.pgaspi_notify_reset(segment_id_local::gaspi_segment_id_t, notification_id::gaspi_notification_id_t, old_notification_val::Ptr{gaspi_notification_t})::gaspi_return_t
end

"""
    pgaspi_write_notify(segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, notification_id, notification_value, queue, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_write_notify (const gaspi_segment_id_t segment_id_local, const gaspi_offset_t offset_local, const gaspi_rank_t rank, const gaspi_segment_id_t segment_id_remote, const gaspi_offset_t offset_remote, const gaspi_size_t size, const gaspi_notification_id_t notification_id, const gaspi_notification_t notification_value, const gaspi_queue_id_t queue, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_write_notify(segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, notification_id, notification_value, queue, timeout_ms)
    @ccall libGPI2.pgaspi_write_notify(segment_id_local::gaspi_segment_id_t, offset_local::gaspi_offset_t, rank::gaspi_rank_t, segment_id_remote::gaspi_segment_id_t, offset_remote::gaspi_offset_t, size::gaspi_size_t, notification_id::gaspi_notification_id_t, notification_value::gaspi_notification_t, queue::gaspi_queue_id_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_write_list_notify(num, segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, segment_id_notification, notification_id, notification_value, queue, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_write_list_notify (const gaspi_number_t num, gaspi_segment_id_t * const segment_id_local, gaspi_offset_t * const offset_local, const gaspi_rank_t rank, gaspi_segment_id_t * const segment_id_remote, gaspi_offset_t * const offset_remote, gaspi_size_t * const size, const gaspi_segment_id_t segment_id_notification, const gaspi_notification_id_t notification_id, const gaspi_notification_t notification_value, const gaspi_queue_id_t queue, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_write_list_notify(num, segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, segment_id_notification, notification_id, notification_value, queue, timeout_ms)
    @ccall libGPI2.pgaspi_write_list_notify(num::gaspi_number_t, segment_id_local::Ptr{gaspi_segment_id_t}, offset_local::Ptr{gaspi_offset_t}, rank::gaspi_rank_t, segment_id_remote::Ptr{gaspi_segment_id_t}, offset_remote::Ptr{gaspi_offset_t}, size::Ptr{gaspi_size_t}, segment_id_notification::gaspi_segment_id_t, notification_id::gaspi_notification_id_t, notification_value::gaspi_notification_t, queue::gaspi_queue_id_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_read_notify(segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, notification_id, queue, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_read_notify (const gaspi_segment_id_t segment_id_local, const gaspi_offset_t offset_local, const gaspi_rank_t rank, const gaspi_segment_id_t segment_id_remote, const gaspi_offset_t offset_remote, const gaspi_size_t size, const gaspi_notification_id_t notification_id, const gaspi_queue_id_t queue, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_read_notify(segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, notification_id, queue, timeout_ms)
    @ccall libGPI2.pgaspi_read_notify(segment_id_local::gaspi_segment_id_t, offset_local::gaspi_offset_t, rank::gaspi_rank_t, segment_id_remote::gaspi_segment_id_t, offset_remote::gaspi_offset_t, size::gaspi_size_t, notification_id::gaspi_notification_id_t, queue::gaspi_queue_id_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_read_list_notify(num, segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, segment_id_notification, notification_id, queue, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_read_list_notify (const gaspi_number_t num, gaspi_segment_id_t * const segment_id_local, gaspi_offset_t * const offset_local, const gaspi_rank_t rank, gaspi_segment_id_t * const segment_id_remote, gaspi_offset_t * const offset_remote, gaspi_size_t * const size, const gaspi_segment_id_t segment_id_notification, const gaspi_notification_id_t notification_id, const gaspi_queue_id_t queue, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_read_list_notify(num, segment_id_local, offset_local, rank, segment_id_remote, offset_remote, size, segment_id_notification, notification_id, queue, timeout_ms)
    @ccall libGPI2.pgaspi_read_list_notify(num::gaspi_number_t, segment_id_local::Ptr{gaspi_segment_id_t}, offset_local::Ptr{gaspi_offset_t}, rank::gaspi_rank_t, segment_id_remote::Ptr{gaspi_segment_id_t}, offset_remote::Ptr{gaspi_offset_t}, size::Ptr{gaspi_size_t}, segment_id_notification::gaspi_segment_id_t, notification_id::gaspi_notification_id_t, queue::gaspi_queue_id_t, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_queue_size(queue, queue_size)

### Prototype
```c
gaspi_return_t pgaspi_queue_size (const gaspi_queue_id_t queue, gaspi_number_t * const queue_size);
```
"""
function pgaspi_queue_size(queue, queue_size)
    @ccall libGPI2.pgaspi_queue_size(queue::gaspi_queue_id_t, queue_size::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    pgaspi_queue_num(queue_num)

### Prototype
```c
gaspi_return_t pgaspi_queue_num (gaspi_number_t * const queue_num);
```
"""
function pgaspi_queue_num(queue_num)
    @ccall libGPI2.pgaspi_queue_num(queue_num::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    pgaspi_queue_create(queue_id, timeout_ms)

### Prototype
```c
gaspi_return_t pgaspi_queue_create(gaspi_queue_id_t * const queue_id, const gaspi_timeout_t timeout_ms);
```
"""
function pgaspi_queue_create(queue_id, timeout_ms)
    @ccall libGPI2.pgaspi_queue_create(queue_id::Ptr{gaspi_queue_id_t}, timeout_ms::gaspi_timeout_t)::gaspi_return_t
end

"""
    pgaspi_queue_delete(queue_id)

### Prototype
```c
gaspi_return_t pgaspi_queue_delete(const gaspi_queue_id_t queue_id);
```
"""
function pgaspi_queue_delete(queue_id)
    @ccall libGPI2.pgaspi_queue_delete(queue_id::gaspi_queue_id_t)::gaspi_return_t
end

"""
    pgaspi_queue_size_max(queue_size_max)

### Prototype
```c
gaspi_return_t pgaspi_queue_size_max (gaspi_number_t * const queue_size_max);
```
"""
function pgaspi_queue_size_max(queue_size_max)
    @ccall libGPI2.pgaspi_queue_size_max(queue_size_max::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    pgaspi_transfer_size_min(transfer_size_min)

### Prototype
```c
gaspi_return_t pgaspi_transfer_size_min (gaspi_size_t * const transfer_size_min);
```
"""
function pgaspi_transfer_size_min(transfer_size_min)
    @ccall libGPI2.pgaspi_transfer_size_min(transfer_size_min::Ptr{gaspi_size_t})::gaspi_return_t
end

"""
    pgaspi_transfer_size_max(transfer_size_max)

### Prototype
```c
gaspi_return_t pgaspi_transfer_size_max (gaspi_size_t * const transfer_size_max);
```
"""
function pgaspi_transfer_size_max(transfer_size_max)
    @ccall libGPI2.pgaspi_transfer_size_max(transfer_size_max::Ptr{gaspi_size_t})::gaspi_return_t
end

"""
    pgaspi_notification_num(notification_num)

### Prototype
```c
gaspi_return_t pgaspi_notification_num (gaspi_number_t * const notification_num);
```
"""
function pgaspi_notification_num(notification_num)
    @ccall libGPI2.pgaspi_notification_num(notification_num::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    pgaspi_passive_transfer_size_max(passive_transfer_size_max)

### Prototype
```c
gaspi_return_t pgaspi_passive_transfer_size_max (gaspi_size_t * const passive_transfer_size_max);
```
"""
function pgaspi_passive_transfer_size_max(passive_transfer_size_max)
    @ccall libGPI2.pgaspi_passive_transfer_size_max(passive_transfer_size_max::Ptr{gaspi_size_t})::gaspi_return_t
end

"""
    pgaspi_allreduce_buf_size(buf_size)

### Prototype
```c
gaspi_return_t pgaspi_allreduce_buf_size (gaspi_size_t * const buf_size);
```
"""
function pgaspi_allreduce_buf_size(buf_size)
    @ccall libGPI2.pgaspi_allreduce_buf_size(buf_size::Ptr{gaspi_size_t})::gaspi_return_t
end

"""
    pgaspi_allreduce_elem_max(elem_max)

### Prototype
```c
gaspi_return_t pgaspi_allreduce_elem_max (gaspi_number_t * const elem_max);
```
"""
function pgaspi_allreduce_elem_max(elem_max)
    @ccall libGPI2.pgaspi_allreduce_elem_max(elem_max::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    pgaspi_rw_list_elem_max(elem_max)

### Prototype
```c
gaspi_return_t pgaspi_rw_list_elem_max (gaspi_number_t * const elem_max);
```
"""
function pgaspi_rw_list_elem_max(elem_max)
    @ccall libGPI2.pgaspi_rw_list_elem_max(elem_max::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    pgaspi_queue_max(queue_max)

### Prototype
```c
gaspi_return_t pgaspi_queue_max(gaspi_number_t * const queue_max);
```
"""
function pgaspi_queue_max(queue_max)
    @ccall libGPI2.pgaspi_queue_max(queue_max::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    pgaspi_network_type(network_type)

### Prototype
```c
gaspi_return_t pgaspi_network_type (gaspi_network_t * const network_type);
```
"""
function pgaspi_network_type(network_type)
    @ccall libGPI2.pgaspi_network_type(network_type::Ptr{gaspi_network_t})::gaspi_return_t
end

"""
    pgaspi_time_ticks(ticks)

### Prototype
```c
gaspi_return_t pgaspi_time_ticks (gaspi_cycles_t * const ticks);
```
"""
function pgaspi_time_ticks(ticks)
    @ccall libGPI2.pgaspi_time_ticks(ticks::Ptr{gaspi_cycles_t})::gaspi_return_t
end

"""
    pgaspi_time_get(wtime)

### Prototype
```c
gaspi_return_t pgaspi_time_get (gaspi_time_t * const wtime);
```
"""
function pgaspi_time_get(wtime)
    @ccall libGPI2.pgaspi_time_get(wtime::Ptr{gaspi_time_t})::gaspi_return_t
end

"""
    pgaspi_cpu_frequency(cpu_mhz)

### Prototype
```c
gaspi_return_t pgaspi_cpu_frequency (gaspi_float * const cpu_mhz);
```
"""
function pgaspi_cpu_frequency(cpu_mhz)
    @ccall libGPI2.pgaspi_cpu_frequency(cpu_mhz::Ptr{gaspi_float})::gaspi_return_t
end

"""
    pgaspi_state_vec_get(state_vector)

### Prototype
```c
gaspi_return_t pgaspi_state_vec_get (gaspi_state_vector_t state_vector);
```
"""
function pgaspi_state_vec_get(state_vector)
    @ccall libGPI2.pgaspi_state_vec_get(state_vector::gaspi_state_vector_t)::gaspi_return_t
end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function pgaspi_printf(fmt, va_list...)
        :(@ccall(libGPI2.pgaspi_printf(fmt::Cstring; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

"""
    pgaspi_print_affinity_mask()

### Prototype
```c
void pgaspi_print_affinity_mask (void);
```
"""
function pgaspi_print_affinity_mask()
    @ccall libGPI2.pgaspi_print_affinity_mask()::Cvoid
end

"""
    pgaspi_numa_socket(socket)

### Prototype
```c
gaspi_return_t pgaspi_numa_socket(gaspi_uchar * const socket);
```
"""
function pgaspi_numa_socket(socket)
    @ccall libGPI2.pgaspi_numa_socket(socket::Ptr{gaspi_uchar})::gaspi_return_t
end

"""
    pgaspi_set_socket_affinity(socket)

### Prototype
```c
gaspi_return_t pgaspi_set_socket_affinity (const gaspi_uchar socket);
```
"""
function pgaspi_set_socket_affinity(socket)
    @ccall libGPI2.pgaspi_set_socket_affinity(socket::gaspi_uchar)::gaspi_return_t
end

"""
    pgaspi_statistic_verbosity_level(_verbosity_level)

### Prototype
```c
gaspi_return_t pgaspi_statistic_verbosity_level(gaspi_number_t _verbosity_level);
```
"""
function pgaspi_statistic_verbosity_level(_verbosity_level)
    @ccall libGPI2.pgaspi_statistic_verbosity_level(_verbosity_level::gaspi_number_t)::gaspi_return_t
end

"""
    pgaspi_statistic_counter_max(counter_max)

### Prototype
```c
gaspi_return_t pgaspi_statistic_counter_max(gaspi_statistic_counter_t* counter_max);
```
"""
function pgaspi_statistic_counter_max(counter_max)
    @ccall libGPI2.pgaspi_statistic_counter_max(counter_max::Ptr{gaspi_statistic_counter_t})::gaspi_return_t
end

"""
    pgaspi_statistic_counter_info(counter, counter_argument, counter_name, counter_description, verbosity_leve)

### Prototype
```c
gaspi_return_t pgaspi_statistic_counter_info(gaspi_statistic_counter_t counter, gaspi_statistic_argument_t* counter_argument, gaspi_string_t* counter_name, gaspi_string_t* counter_description, gaspi_number_t* verbosity_leve);
```
"""
function pgaspi_statistic_counter_info(counter, counter_argument, counter_name, counter_description, verbosity_leve)
    @ccall libGPI2.pgaspi_statistic_counter_info(counter::gaspi_statistic_counter_t, counter_argument::Ptr{gaspi_statistic_argument_t}, counter_name::Ptr{gaspi_string_t}, counter_description::Ptr{gaspi_string_t}, verbosity_leve::Ptr{gaspi_number_t})::gaspi_return_t
end

"""
    pgaspi_statistic_counter_get(counter, argument, valu)

### Prototype
```c
gaspi_return_t pgaspi_statistic_counter_get (gaspi_statistic_counter_t counter, gaspi_number_t argument, unsigned long *valu);
```
"""
function pgaspi_statistic_counter_get(counter, argument, valu)
    @ccall libGPI2.pgaspi_statistic_counter_get(counter::gaspi_statistic_counter_t, argument::gaspi_number_t, valu::Ptr{Culong})::gaspi_return_t
end

"""
    pgaspi_statistic_counter_reset(counter)

### Prototype
```c
gaspi_return_t pgaspi_statistic_counter_reset (gaspi_statistic_counter_t counter);
```
"""
function pgaspi_statistic_counter_reset(counter)
    @ccall libGPI2.pgaspi_statistic_counter_reset(counter::gaspi_statistic_counter_t)::gaspi_return_t
end

"""
    pgaspi_error_str(error_code)

### Prototype
```c
gaspi_string_t pgaspi_error_str(gaspi_return_t error_code);
```
"""
function pgaspi_error_str(error_code)
    @ccall libGPI2.pgaspi_error_str(error_code::gaspi_return_t)::gaspi_string_t
end

const GASPI_GROUP_ALL = gaspi_rank_t(0)
const GASPI_BLOCK = gaspi_timeout_t(0xffffffffffffffff)
const GASPI_TEST = gaspi_timeout_t(0x0)


# exports
const PREFIXES = ["gaspi_", "GASPI_", "pgaspi_", "PGASPI_"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module
