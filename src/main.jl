include("ProjectCreator.jl")

using .ProjectCreator

if length(ARGS) < 4
    throw(DomainError(ARGS, "Not enough arguments. Require the following arguments (in order): [project name] [parent directory] [language] [project type]"))
end # if

if lowercase(ARGS[3]) in ["python", "julia", "latex"]
else 
    throw(DomainError(ARGS[3], "This language isn't supported yet. Must be one of the following: [python, julia, latex]"))
end # if

if lowercase(ARGS[4]) in ["module", "script", "hmcmath"]
    if lowercase(ARGS[3]) != "latex" && lowercase(ARGS[4]) == "hmcmath"
        throw(DomainError(ARGS[4], "This project type: $(ARGS[4]) isn't supported for this language: $(ARGS[3])."))
    end # if
else 
    throw(DomainError(ARGS[4], "This project type isn't supported yet. Must be one of the following: [module, script, hmcmath]"))
end # if

println("Creating a $(ARGS[4]) project with name $(ARGS[1]) in the directory $(ARGS[2]) using the language: $(ARGS[3]).")

packages = Vector{String}() # empty vector for packages
wakatime = false # wakatime Bool
git = false # git bool

if length(ARGS) > 4
    for arg in ARGS[5:length(ARGS)] # go through all arguments after required arguments to look for --wakatime, --git, or --packages=[stuff]
        global git, wakatime, packages
        if arg == "--wakatime"
            println("Adding wakatime file to the project.")
            wakatime = true
        elseif arg == "--git"
            println("Initializing git repository.")
            git = true
        elseif arg[1:11] == "--packages="
            try
                packages = split(arg[13:length(arg)-1], ", ") # split the packages string into a vector
                packages = [String(i) for i in packages] # convert to strings
                println("Add the following packages to the project: $(packages).")
            catch
                throw(DomainError(arg, "Invalid argument. To add packages, use the following format: --packages=[package1, package2, package3]"))
            end # try
            
        else
            throw(DomainError(arg, "Unknown additional argument. Must be one of the following: [--wakatime, --git, --packages=[stuff]]"))
        end # if
    end # for
end # if

create_project(ARGS[2], ARGS[1], lowercase(ARGS[3]), lowercase(ARGS[4]); wakatime=wakatime, git=git, packages=packages)