module LatexProject 

include("GeneralFunctions.jl")

export create_latex_project

"""
Create LaTeX project.

"""
function create_latex_project(parentPath::String, projectName::String; wakatime::Bool=false, git::Bool=false)
    mainDirName = replace(projectName, " "=>"_") # replace spaces with underscores

    # create main directory
    mkdir(parentPath * "/" * mainDirName) 

    # create basic/general files
    create_readme(parentPath, projectName)

    if wakatime # if wakatime, create project file
        create_wakatime(parentPath, projectName)
    end # if 

    # create project file
    create_main_files(parentPath, projectName, "latex", "none")

    if git
        create_gitignore(parentPath, projectName; files=[mainDirName * ".aux", mainDirName * ".fls", mainDirName * ".log", mainDirName * ".out", mainDirName * ".synctex.gz", mainDirName * ".fdb_latexmk"]) # add all irritating rendering files from vs code extension to gitignore
        setup_git(parentPath, projectName)
    end # if

end # function create_latex_project

end # module LatexProject