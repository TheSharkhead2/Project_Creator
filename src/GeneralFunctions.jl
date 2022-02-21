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

        # write template to main file
        open(mainDirPath * mainDirName * ".tex", "w") do io 
            println(io, "\\documentclass{article}")
            println(io, "\\usepackage[utf8]{inputenc}")
            println(io, "\\usepackage{textcomp}")
            println(io, "\\usepackage{gensymb}")
            println(io, "\\usepackage{graphicx}")
            println(io, "\\usepackage{multicol}")
            println(io, "\\usepackage{amsmath}")
            println(io, "\\usepackage{amssymb}")
            println(io, "\\usepackage{physics}")
            println(io, "\\usepackage{hyperref}")
            println(io, "\\usepackage{cancel}")

            println(io, "\\graphicspath{ {./images/} }")

            println(io, "\\oddsidemargin=-.3in")
            println(io, "\\evensidemargin=-.5in")
            println(io, "\\textwidth=7in")
            println(io, "\\topmargin=-1in")
            println(io, "\\textheight=10in")

            println(io, "\\parindent=.2in")
            println(io, "\\pagestyle{plain}")

            println(io, "\\title{Placeholder}")
            println(io, "\\author{}")
            println(io, "\\date{}")

            println(io, "\\begin{document}")

            println(io, "\\maketitle")

            println(io, "\\end{document}")
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
    

"""
Generate .gitignore file with specified files included

"""
function create_gitignore(parentPath::String, projectName::String; files::Vector{String}=Vector{String}())
    mainDirName = replace(projectName, " "=>"_") # replace spaces with underscores

    mainDirPath = parentPath * "/" * mainDirName * "/" # get path to main directory

    # create .gitignore file
    open(mainDirPath * ".gitignore", "w") do io 
        for file in files # for each file in files
            println(io, file) # write file to file
        end # for
    end # open

end # function create_gitignore

"""
Initializes git repository and stages first commit. 

"""
function setup_git(parentPath::String, projectName::String)
    mainDirName = replace(projectName, " "=>"_") # replace spaces with underscores

    mainDirPath = parentPath * "/" * mainDirName * "/" # get path to main directory

    cd(mainDirPath) # change to main directory

    # initialize git repository
    run(`git init`) # run git init command
    run(`git add -A`) # run git add command
    run(`git commit -m "Initial commit"`) # run git commit command
    run(`git branch -M main`)

end # function setup_git