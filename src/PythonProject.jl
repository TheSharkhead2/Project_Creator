module PythonProject

include("GeneralFunctions.jl")
include("PythonProjectFunctions.jl")

export create_python_project
"""
Create python project. 

"""
function create_python_project(parentPath::String, projectName::String, projectType::String; wakatime::Bool=false, packages::Vector{String}=Vector{String}())
    # basic folder and git creation stuff
    create_project_dir(parentPath, projectName)
    create_readme(parentPath, projectName)

    if wakatime # if wakatime, create project file
        create_wakatime(parentPath, projectName)
    end # if 

    # create project file
    create_main_files(parentPath, projectName, "python", projectType; packages=packages)

    # handle dependencies
    create_dependencies(parentPath, projectName; packages=packages)
    
end # function

end # module PythonProject