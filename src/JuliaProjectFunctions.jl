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

    cd(parentPath * "/" * mainDirName) # Change directory to the project.

    # Activate project and add packages.
    Pkg.activate(".")

    if length(packages) > 0
        Pkg.add(packages)
    end # if

end # function activate_project


