"""
Create dependencies file. In the future, implementing pipenv 
(https://packaging.python.org/en/latest/tutorials/managing-dependencies/)
is probably ideal, but for now this is fine. 

"""
function create_dependencies(parentPath::String, projectName::String; packages::Vector{String}=Vector{String}())
    mainDirName = replace(projectName, " "=>"_") # replace spaces with underscores

    open(parentPath * "/" * mainDirName * "/dependencies", "w") do io # create a dependencies file to log dependencies for project and allow easy pip installation 
        for package in packages
            println(io, package)
        end # for
    end # open

end # function create_dependencies

