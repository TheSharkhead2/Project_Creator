include("../src/ProjectCreator.jl")

using .ProjectCreator

create_project("./test/testProject", "First Project pScript", "python", "script"; wakatime=true, packages=["numpy", "pandas"], git=true)