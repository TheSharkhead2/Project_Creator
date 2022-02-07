"""
Activates project and adds relevant packages.

# Parameters

## parentPath::String
Path to the parent directory of the project.

## projectName::String
Name of the project.

## packages::Vector{String}
A list of all the packages to be added to the project.

"""
function activate_project(parentPath::String, projectName::String; packages::Vector{String}=Vector{String}())
    mainDirName = replace(projectName, " "=>"_") # replace spaces with underscores

    # Activate project and add packages.
    Pkg.activate(parentPath * "/" * mainDirName)

    if length(packages) > 0
        Pkg.add(packages)
    end # if

end # function activate_project


