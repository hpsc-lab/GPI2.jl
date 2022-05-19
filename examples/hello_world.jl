using GPI2

gaspi_proc_init(GASPI_BLOCK)

rank = Ref{gaspi_rank_t}()
num = Ref{gaspi_rank_t}()

gaspi_proc_rank(rank)
gaspi_proc_num(num)

# gaspi_printf("Hello from rank %d of %d\n", rank, num)
# Uncomment the previous and comment the following line if you want to use the gaspi_logger
println("Hello from rank $(rank[]) of $(num[])")

gaspi_proc_term(GASPI_BLOCK)
