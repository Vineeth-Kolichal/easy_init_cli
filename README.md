
![easy_init](https://github.com/Vineeth-Kolichal/easy_init_cli/assets/92266542/1e82177d-f4f0-4b51-bbf2-856616ed2a1f)


# Exploring the CLI

Easy Init CLI is a command-line tool that streamlines the creation of Flutter projects. It initializes the project with boilerplate code following a well-structured and maintainable architecture pattern.

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
```sh
#replace project_name with your project's name
cd project_name
```
Use the cd command in the terminal to navigate to the project's root directory.
```shell
easy init
```
Use this command to initialize your project with a well-structured architectural pattern. This command will prompt you to select the architecture. 
![Screenshot from 2024-04-11 15-37-44](https://github.com/Vineeth-Kolichal/easy_init_cli/assets/92266542/b4fd61a6-5c54-4af6-8b48-e22b136f315f)

Currently two architecture pattern is available in ```easy_init_cli```

1. #### TDD + Clean Architecture
The folder structure of TDD + Clean Architecture looks like this:


![Screenshot from 2024-04-11 15-31-36](https://github.com/Vineeth-Kolichal/easy_init_cli/assets/92266542/ac1cc2ea-69ad-4b2d-87dd-2796507e451d)

To learn more about TDD + Clean architecture refer [Reso Coder](https://resocoder.com/flutter-clean-architecture-tdd/)'s website



2. #### MVC
The folder structure of MVC Architecture looks like this:


![Screenshot from 2024-04-11 15-28-09](https://github.com/Vineeth-Kolichal/easy_init_cli/assets/92266542/1c1b9bdf-7cf5-46cf-9668-0cf64ace629f)




```All required dependencies and dev dependencies will added automatically. The generated files can be customized to suit your specific needs.```

### Create feature
```shell
easy create feature
```
Use this command to create new Clean architecture feature. this command will promt you to provide a feature name.

OR 

```shell
easy create feature:feature_name

```
The ```screens``` folder will contain authentication-related screen files if the feature name is either 'auth' or 'authentication'





