include("../src/ProjectCreator.jl")

using .ProjectCreator

create_project("./test/testProject", "First Project pModule", "python", "module"; wakatime=true, packages=["numpy", "pandas"])