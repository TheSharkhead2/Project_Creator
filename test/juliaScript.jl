include("../src/ProjectCreator.jl")

using .ProjectCreator

create_project("./test/testProject", "First Project Script", "julia", "script"; wakatime=true, packages=["HTTP", "Random"], git=true)