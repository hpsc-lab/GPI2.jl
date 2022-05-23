using GPI2
using Test

@time @testset "GPI2.jl tests" begin
  @testset "gaspi_version" begin
    version = Ref{Cfloat}(0.0)
    @test gaspi_version(version) == GASPI_SUCCESS
    @test version[] > 1
  end

  @testset "use_system_library" begin
    @test_logs (:info, "Using user-provided GPI-2 library. Please restart Julia for the change to take effect.") GPI2.use_system_library(GPI2.default_libGPI2)
  end

  @testset "use_jll_library" begin
    @test_logs (:info, "Using JLL-provided GPI-2 library. Please restart Julia for the change to take effect.") GPI2.use_jll_library()
  end

  @testset "use_system_bindings" begin
    @test_logs (:info, "Using user-provided C bindings. Please restart Julia for the change to take effect.") GPI2.use_system_bindings(GPI2.default_bindings_file)
  end

  @testset "use_jll_bindings" begin
    @test_logs (:info, "Using JLL-compatible C bindings. Please restart Julia for the change to take effect.") GPI2.use_jll_bindings()
  end
end
