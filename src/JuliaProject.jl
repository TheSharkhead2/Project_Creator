module JuliaProject

using Pkg 

include("GeneralFunctions.jl")
include("JuliaProjectFunctions.jl")

export create_julia_project
"""
Create julia project. 

"""
function create_julia_project(parentPath::String, projectName::String, projectType::String; wakatime::Bool=false, packages::Vector{String}=Vector{String}(), git::Bool=false)
    # basic folder and git creation stuff
    create_project_dir(parentPath, projectName)
    create_readme(parentPath, projectName)

    if wakatime # if wakatime, create project file
        create_wakatime(parentPath, projectName)
    end # if 

    # create project file
    create_main_files(parentPath, projectName, "julia", projectType; packages=packages)

    # initialize julia project 
    activate_project(parentPath, projectName; packages=packages)

    if git
        if wakatime # if wakatime, add .wakatime-project to .gitignore
            create_gitignore(parentPath, projectName; files=[".wakatime-project"])
        else 
            create_gitignore(parentPath, projectName)
        end # if
        setup_git(parentPath, projectName)
    end # if
end # function

end # module JuliaProject