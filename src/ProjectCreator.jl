module ProjectCreator 

include("JuliaProject.jl")

using .JuliaProject

export create_project

"""
Create project. 

"""
function create_project(parentPath::String, projectName::String, projectLang::String, projectType::String; wakatime::Bool=false, packages::Vector{String}=Vector{String}())
    if projectLang == "julia"
        create_julia_project(parentPath, projectName, projectType; wakatime=wakatime, packages=packages)
    else
        throw(DomainError(projectLang, "This language is not supported."))
    end

end # function create_project

end # ProjectCreator