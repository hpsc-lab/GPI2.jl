using TOML
using Pkg

if length(ARGS) > 0
  filename = ARGS[1]
else
  filename = "gpi2-jl-env.toml"
end
if length(ARGS) > 1
  args = ARGS[2:end]
else
  args = []
end

if !isabspath(filename)
end

data = TOML.parsefile(filename)

julia_command = Cmd(data["julia_command"])
env = data["ENV"]
project = data["project"]

withenv(env...) do
  cd(env["PWD"])
  run(`$julia_command --project=$project $args`)
end
