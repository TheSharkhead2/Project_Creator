# Project Creator

This is a small project aimed at creating the bare-bones files and folders for various project types. Currently, I have not compiled an executable so you will have to have Julia installed in order to use it. If you are using the git functionality, you will also need git installed.

## Usage

In order to run this program, you simply have to run the ```src/main.jl``` file like so: 

```> julia Project_Creator/src/main.jl```

There are four required arguments for creating a project: 

```> julia Project_Creator/src/main.jl [project_name] [project_path] [language] [type]```

Failing to supply any of these four arguments will result in an error. **Note: if there are spaces in any argument, there needs to be quotation marks (") around the argument**. Here is what each argument does: 

### Required Arguments

#### project_name 

Self explainatory, the name of the project. If the name of the project is multiple words, use the format of: "This Is Title" (Use spaces between the words and capitalize them). 

#### project_path 

The path to the directory in which you want the project to be created (the path to the parent directory). This must be **relative** to where you are running this command. 

#### language

The language for the project you want to create. Currently, the only supported languages are: julia, python, latex. 

#### type

The type of the project. Currently either "script" or "module". Will chance the format of the files for Julia and Python. 

### Optional Arguments 

#### --wakatime

Including "--wakatime" as another arugment after the forth argument will generate a .wakatime-project file with the project name for more accurate tracking with wakatime. If "--git" is also supplied, this file will be added to .gitignore.

#### --git 

Suppling "--git" as an argument will add a .gitignore file and run the following git commands: 
```bash 
> git init 
> git add -A
> git commit -m "Initial commit" 
> git branch -M main
```
Note: this means that you will still have to run the following to push your repository to github: 
```bash
> git remote add origin <REMOTE_URL>
> git push -u origin main
```

#### --packages=[]

This is used to include packages in your project (they will be automatically imported to the files. For Julia, they will be added with Pkg, whereas currently for Python they are only added to a ```dependencies``` file). Use the argument like so: 
```bash
"--packages=[package1, package2, package3]"
```
You must have quotation marks around the entire argument, and the characters ", " between each package (that is a comma followed by a space). 