using TOML
using Pkg

if length(ARGS) > 0
  filename = ARGS[1]
else
  filename = "gpi2-jl-env.toml"
end

data = Dict{String,Any}("ENV" => ENV)
data["julia_command"] = collect(Base.julia_cmd())
data["project"] = dirname(Pkg.project().path)

open(filename, "w") do io
  TOML.print(io, data)
end
