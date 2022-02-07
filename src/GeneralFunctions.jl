"""
Creates main directory, src directory, and test directory for project. 

# Parameters

## parentPath::String
The path to the parent directory of the project.

## projectName::String
Name of project

"""
function create_project_dir(parentPath::String, projectName::String)
    mainDirName = replace(projectName, " "=>"_") # replace spaces with underscores

    # create main directory
    mkdir(parentPath * "/" * mainDirName) 

    # create src and test directories 
    mkdir(parentPath * "/" * mainDirName * "/" * "src")
    mkdir(parentPath * "/" * mainDirName * "/" * "test")

end # function create_project_dir

""" 
Creates README.md file for project with default description. 

# Parameters

## parentPath::String
The path to the parent directory of the project.

## projectName::String
Name of project

"""
function create_readme(parentPath::String, projectName::String)
    mainDirName = replace(projectName, " "=>"_") # replace spaces with underscores

    mainDirPath = parentPath * "/" * mainDirName * "/" # get path to main directory 

    # create README.md file
    open(mainDirPath * "README.md", "w") do io 
        println(io, "# " * projectName) # write project name to file
        println(io, "") # new line
        println(io, "This is a placeholder description. If you are reading this description it means I was too lazy to actually describe my project.") # write description header
    end # open

end # function create_readme

"""
Creates wakatime project file for accurate tracking of time spent on project.

# Parameters

## parentPath::String
The path to the parent directory of the project.

## projectName::String
Name of project

"""
function create_wakatime(parentPath::String, projectName::String)
    mainDirName = replace(projectName, " "=>"_") # replace spaces with underscores

    mainDirPath = parentPath * "/" * mainDirName * "/" # get path to main directory 

    # create wakatime file
    open(mainDirPath * ".wakatime-project", "w") do io 
        println(io, projectName) # write project name to file
    end # open

end # function create_wakatime

"""
Creates main file(s) for project. 

# Parameters

"""
function create_main_files(parentPath::String, projectName::String, projectLang::String, projectType::String; packages::Vector{String}=Vector{String}())
    mainDirName = replace(projectName, " "=>"_") # replace spaces with underscores

    mainDirPath = parentPath * "/" * mainDirName * "/" # get path to main directory

    # create main file(s) based on project type
    if projectLang == "latex" # LaTeX projects are different, so handle them first. (no script vs module)
        mkdir(mainDirPath * "images") # create images directory

        # copy latex file from template
        templateString = "" # initialize string

        open("./src/templates/latexTemplate") do io 
            for line in eachline(io) # for each line in template file
                if line == "\\title{Placeholder}" # if title section, replace with project title
                    templateString = templateString * "\\title{$projectName}\n"
                else
                    templateString = templateString * line * "\n" # append line to string
                end # if 
            end # for
        end # open

        # write template to main file
        open(mainDirPath * mainDirName * ".tex", "w") do io 
            println(io, templateString) # write template to file
        end # open

    elseif projectLang == "julia"
        if projectType == "script"
            # for julia script, just create empty main file
            open(mainDirPath * "src/main" * ".jl", "w") do io 
                if length(packages) > 0 # if packages are specified, add them to file
                    packageString = "using " # initialize string
                    for package in packages
                        packageString = packageString * package * ", " # append package to string
                    end # for
                    packageString = packageString[1:length(packageString)-2] # remove last comma

                    println(io, packageString) # write package string to file
                end # if
            end # open
        
        elseif projectType == "module"
            # for julia module, create module file in src 
            open(mainDirPath * "src/" * replace(projectName, " "=>"") * ".jl", "w") do io # create file with name as project name w/o spaces 
                println(io, "module " * replace(projectName, " "=>"") * "\n\n") # write module header

                if length(packages) > 0 # if packages are specified, add them to file
                    packageString = "using " # initialize string
                    for package in packages
                        packageString = packageString * package * ", " # append package to string
                    end # for
                    packageString = packageString[1:length(packageString)-2] # remove last comma

                    println(io, packageString) # write package string to file
                end # if

                println(io, "\n\nend # module " * replace(projectName, " "=>"")) # write end of module

            end # open
        end # if
    
    elseif projectLang == "python"
        if projectType == "script"
            # for python script, just create empty main file
            open(mainDirPath * "src/main" * ".py", "w") do io 
                if length(packages) > 0 # if packages are specified, add them to file
                    packageString = "import " # initialize string
                    for package in packages
                        packageString = packageString * package * ", " # append package to string
                    end # for
                    packageString = packageString[1:length(packageString)-2] # remove last comma

                    println(io, packageString * "\n\n") # write package string to file
                end # if

                println(io, "def main():") # write main function header
                println(io, "    pass") # write pass statement

                println(io, "\n\nif __name__ == \"__main__\":") # write if main function header
                println(io, "    main()") # write main function call

            end # open
        
        elseif projectType == "module"
            # for python module, create module file in src 
            open(mainDirPath * "src/" * replace(projectName, " "=>"") * ".py", "w") do io # create file with name as project name w/o spaces 
                println(io, "class " * replace(projectName, " "=>"" * "") * ":") # write class header
                println(io, "    def __init__(self):") # write constructor header
                println(io, "        pass") # write pass statement
            end # open

            # create __init__.py file in src
            open(mainDirPath * "src/__init__.py", "w") do io 
                if length(packages) > 0 # if packages are specified, add them to file
                    packageString = "import " # initialize string
                    for package in packages
                        packageString = packageString * package * ", " # append package to string
                    end # for
                    packageString = packageString[1:length(packageString)-2] # remove last comma

                    println(io, packageString * "\n\n") # write package string to file
                end # if

                println(io, "from ." * replace(projectName, " "=>"") * " import " * replace(projectName, " "=>"")) # write import statement
            end # open

        end # if
    end # if
end # function create_main_files
    