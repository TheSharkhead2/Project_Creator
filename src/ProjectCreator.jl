module ProjectCreator 

include("JuliaProject.jl")
include("PythonProject.jl")
include("LatexProject.jl")

using .JuliaProject
using .PythonProject
using .LatexProject

export create_project

"""
Create project. 

"""
function create_project(parentPath::String, projectName::String, projectLang::String, projectType::String; wakatime::Bool=false, packages::Vector{String}=Vector{String}(), git::Bool=false)
    if projectLang == "julia"
        create_julia_project(parentPath, projectName, projectType; wakatime=wakatime, packages=packages, git=git)
    elseif projectLang == "python"
        create_python_project(parentPath, projectName, projectType; wakatime=wakatime, packages=packages, git=git)
    elseif projectLang == "latex"
        if projectType == "hmcmath"
            create_latex_project(parentPath, projectName, projectType; wakatime=wakatime, git=git)
        else 
            create_latex_project(parentPath, projectName, "none"; wakatime=wakatime, git=git)
        end # if
    else
        throw(DomainError(projectLang, "This language is not supported."))
    end # if

end # function create_project

end # ProjectCreator