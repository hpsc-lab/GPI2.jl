using Documenter
import Pkg
using GPI2

# Define module-wide setups such that the respective modules are available in doctests
DocMeta.setdocmeta!(GPI2,     :DocTestSetup, :(using GPI2);     recursive=true)

# Make documentation
makedocs(
    # Specify modules for which docstrings should be shown
    modules = [GPI2],
    # Set sitename to GPI2
    sitename="GPI2.jl",
    # Provide additional formatting options
    format = Documenter.HTML(
        # Disable pretty URLs during manual testing
        prettyurls = get(ENV, "CI", nothing) == "true",
        # Explicitly add favicon as asset
        # assets = ["assets/favicon.ico"],
        # Set canonical URL to GitHub pages URL
        canonical = "https://hlrs-tasc.github.io/GPI2.jl/dev"
    ),
    # Explicitly specify documentation structure
    pages = [
        "Home" => "index.md",
        "Reference" => "reference.md",
        "License" => "license.md"
    ],
    # strict = true # to make the GitHub action fail when doctests fail
    strict = Documenter.except(:cross_references)
)

deploydocs(
    repo = "github.com/hlrs-tasc/GPI2.jl",
    devbranch = "main",
    push_preview = true
)
