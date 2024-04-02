
![Screenshot from 2024-03-28 17-31-44](https://github.com/Vineeth-Kolichal/easy_init_cli/assets/92266542/f8e03637-107f-445b-bf3a-2fee6557eafa)

# Exploring the CLI
---
Easy Init CLI is a command-line tool that streamlines the creation of Flutter projects. It initializes the project with boilerplate code following a well-structured, Test-Driven Development (TDD) Clean Architecture approach. Future versions will incorporate additional architectural patterns.
### Installation
You can install the package from the command line:
```shell
dart pub global activate easy_init_cli
```

### Create Project
```shell
easy create project
```
Use this command to create new flutter project. This command will prompt you to provide a project name and organization domain. 
 (example- project name : todo app, organization domain : com.example )
### Initialize project
```shell
#replace project_name with your project's name
cd project_name
```
Use the cd command in the terminal to navigate to the project's root directory.
```shell
easy init
```
Use this command to initialize your project with a well-structured architectural pattern (Currently, only TDD Clean Architecture (feature wise) is available.). All required dependencies and dev dependencies will added automatically. The generated files can be customized to suit your specific needs.

### Create feature
```shell
easy create feature
```
Use this command to create new Clean architecture feature. this command will promt you to provide a feature name.\
OR \

```shell
easy create feature:feature_name

```
The ```screens``` folder will contain authentication-related screen files if the feature name is either 'auth' or 'authentication'



