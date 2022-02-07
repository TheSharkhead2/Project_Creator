include("../src/ProjectCreator.jl")

using .ProjectCreator

create_project("./test/testProject", "First Project LaTeX", "latex", "module"; wakatime=true, git=true)