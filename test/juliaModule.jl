include("../src/ProjectCreator.jl")

using .ProjectCreator

create_project("./test/testProject", "First Project Module", "julia", "module"; wakatime=true, packages=["HTTP", "Random"], git=true)