using GPI2
using Test

@time @testset "GPI2.jl tests" begin
  @testset "gaspi_version" begin
    version = Ref{Cfloat}(0.0)
    @test gaspi_version(version) == GASPI_SUCCESS
    @test version[] > 1
  end
end
