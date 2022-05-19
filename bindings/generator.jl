using Clang.Generators
using GPI2_jll

cd(@__DIR__)

include_dir = get(ENV, "GPI2_INCLUDE_DIR", joinpath(GPI2_jll.artifact_dir, "include"))

options = load_options(joinpath(@__DIR__, "generator.toml"))

# add compiler flags, e.g. "-DXXXXXXXXX"
args = get_default_args()  # Note you must call this function firstly and then append your own flags
push!(args, "-I$include_dir")

# set header files
headers_rel = ["GASPI.h", "GASPI_types.h", "GASPI_Ext.h", "GASPI_Threads.h", "PGASPI.h"]
headers = [joinpath(include_dir, header) for header in headers_rel]

# create context
ctx = create_context(headers, args, options)

# run generator
build!(ctx)
