# GPI2.jl

[![Build Status](https://github.com/hlrs-tasc/GPI2.jl/actions/workflows/ci.yml/badge.svg)](https://github.com/hlrs-tasc/GPI2.jl/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-success.svg)](https://opensource.org/licenses/MIT)


GPI2.jl is a lightweight Julia wrapper for the [GASPI](https://www.gaspi.de/)-conforming
[GPI-2](https://github.com/cc-hpc-itwm/GPI-2) library.


## Installation
If you have not yet installed Julia, please [follow the instructions for your
operating system](https://julialang.org/downloads/platform/). GPI2.jl works
with Julia v1.7. Since GPI-2 only works on Linux systems, GPI2.jl is also
restricted to this platform.

At the time of writing, GPI2.jl is not a registered package. Thus to install it
in your default environment, execute the following command:
```shell
julia -e 'using Pkg; Pkg.add("https://github.com/hlrs-tasc/GPI2.jl.git")'
```
Alternatively, you can also just clone this repository and then instantiate it,
i.e., installing all dependencies:
```shell
git clone https://github.com/hlrs-tasc/GPI2.jl.git
julia --project=GPI2.jl -e 'using Pkg; Pkg.instantiate()'
```
If you decide to use the latter approach with a cloned `GPI2.jl` directory, in
the following, you need to run all commands from within the cloned folder and
add `--project=.` to the `julia` command, e.g.,
```shell
julia --project=. -e 'using GPI2; ...'
```


## Usage

### Getting started
You can start running GASPI functions after executing `using GPI2`. All GASPI
functions are prefixed by `gaspi_`. For example, to check the version of the
currently used GPI-2 library, start the Julia REPL and paste the following
snippet:
```julia
julia> using GPI2

julia> version = Ref{Cfloat}()
Base.RefValue{Float32}(0.0f0)

julia> gaspi_version(version)
GASPI_SUCCESS::gaspi_return_t = 0

julia> println("GPI-2 library version: $(version[])")
GPI-2 library version: 1.51
```


### Parallel execution
To run a GPI-2 program in parallel, you need to start it with the helper script
`gaspi_run`. It requires a machinefile with the names of the nodes on which a
rank should be started, see also the GPI-2 [docs](https://github.com/cc-hpc-itwm/GPI-2).
For a simple test, you can create a machinefile that will start three ranks on
the current node by running
```shell
yes `hostname` | head -n 3 > machinefile
```

For convenience, GPI2.jl provides the function `gaspi_run()` that
will start `gaspi_run` for you, using the GPI2\_jll.jl-provided executable. GPI2.jl also
provides some example files in the [examples/](examples/) folder you can check
out to get started.

For example, to run the [`hello_world.jl`](examples/hello_world.jl) example in
parallel, execute the following commands in Julia:
```shell
julia -e 'using GPI2; gaspi_run()' -- -m machinefile $(which julia) $(pwd)/examples/hello_world.jl
```
Yes, you need `julia` twice in the command: The first one just executes the `gaspi_run`
command, while the second one is the command that is executed in parallel. And
yes, you need the `$(pwd)`s to ensure that the `gaspi_run` does pick the right
files. If you have not installed GPI2.jl in your default Julia depot, you also
need to add a `--project="/abs/path/to/GPI2.jl"` argument to each call to Julia.


### Issues when relying on the `module` command
If you want to start a parallel process using GPI-2's `gaspi_run` on a cluster
where paths are set using the `module` command provided by, e.g., Lmod, there are
some issues you need to handle in order to make a GASPI program run properly.
They boil down to the fact that, as far as I can tell, GPI-2 uses SSH to set up
communication between nodes and uses a non-login shell for this purpose. This
means that, e.g., the `module` command will not work and thus you need to
manually put all relevant changes to the environment variables directly in your
`~/.bashrc` file.

As a workaround, this repository provides two auxiliary utilities:
[`storeenv.jl`](utils/storeenv.jl) and [`launcher.jl`](utils/launcher.jl). They
help you to run a GPI-2-powered Julia program on a cluster with the environment
set up using, e.g., Lmod, by storing the entire environment and reloading it..

First, go to the folder from which you want to start your GASPI-parallelized Julia program
and execute the `storeenv.jl` script:
```shell
julia --project=path/to/GPI2.jl path/to/storeenv.jl
```
If you installed GPI2.jl as a package instead of just cloning this repo, you
can also omit the `--project` part. The `storeenv.jl` script will record the
current environment variables and store them in a file `gaspi-jl-env.toml`.

Then, run your Julia program in parallel with the `launcher.jl` script using the
following command:
```shell
gaspi_run -m <machinefile> $(which julia) /abs/path/to/launcher.jl $(pwd)/gaspi-jl-env.toml path/to/julia/program.jl
```
The `<machinefile>` is the normal machinefile with all nodes on which to start a
GASPI rank. The `/abs/path/to/launcher.jl` must be an *absolute* path again. The
launcher script will take care of recreating the environment using the
information in the TOML file `$(pwd)/gaspi-jl-env.toml`. Finally, you can
provide the path to the Julia programm (and optional command line arguments to
it) as the final part. The path to the Julia program may be relative or
absolute, since the launcher knows your current directory by now.


## Configuration
### Using a system library
When using GPI2.jl, you can specify the path to the GASPI
library you want to use. By default, GPI2.jl uses the precompiled GPI-2 library
available in the GPI2\_jll.jl package. This is only recommended for
non-performance critical usage and/or development. To switch to a
library installed on your system, execute
```julia
julia -e 'using GPI2; GPI2.use_system_library("/path/to/libGPI2.so")'
```
where `/path/to/libGPI.so` should be the path to your *shared* GPI-2 library.
To switch back to using the JLL-provided library, execute
```julia
julia -e 'using GPI2; GPI2.use_jll_library()'
```
After switching the library, you need to restart Julia for the changes to take
effect.

### Generating C bindings
In case you are using a system-provided GPI-2 library with an API that is different
to the one provided by the JLL-provided library, you need to re-generate the
C bindings file `LibGPI2.jl` and tell the GPI2.jl package to use it.

To this end, enter the `bindings/` directory and run the following command:
```shell
julia --project=. -e 'using Pkg; Pkg.instantiate()' # only required once
GPI_INCLUDE_DIR=path/to/GPI-2/include julia --project=. generator.jl
```
This will create a `LibGPI2.jl` file in the current working directory. To switch
to the custom bindings file, execute
```julia
julia -e 'using GPI2; GPI2.use_system_bindings("path/to/LibGPI2.jl")'
```
where `path/to/libGPI.so` should be the path to your custom C bindings file.
To switch back to using the JLL-compatible library, execute
```julia
julia -e 'using GPI2; GPI2.use_jll_bindings()'
```
After switching the C bindings, you need to restart Julia for the changes to take
effect.


## Authors
GPI2.jl is maintained by
[Michael Schlottke-Lakemper](https://www.hlrs.de/about-us/organization/divisions-departments/av/tasc/)
(University of Stuttgart, Germany). The GPI-2 library itself is developed by the
[Fraunhofer Institute for Industrial Mathematics (ITWM)](https://www.itwm.fraunhofer.de/).


## License and contributing
GPI2.jl is published under the MIT license (see [LICENSE.md](LICENSE.md)). We
are very happy to accept contributions from everyone, preferably in the form of
a PR.
[GPI-2](https://github.com/cc-hpc-itwm/GPI-2) itself is published under the GNU
General Public license, version 3.
