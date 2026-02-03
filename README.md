# Easy Init CLI

[![Pub Version](https://img.shields.io/pub/v/easy_init_cli)](https://pub.dev/packages/easy_init_cli)
[![Likes](https://img.shields.io/pub/likes/easy_init_cli)](https://pub.dev/packages/easy_init_cli)
[![License](https://img.shields.io/badge/license-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

![easy_init](https://github.com/Vineeth-Kolichal/easy_init_cli/assets/92266542/1e82177d-f4f0-4b51-bbf2-856616ed2a1f)

## 🚀 Overview

**Easy Init CLI** is a powerful command-line tool designed to streamline the initialization of Flutter projects. It automatically sets up your project with a well-structured, scalable, and testable architecture, saving you time on boilerplate setup.

Currently, it supports **TDD + Clean Architecture**, a robust pattern favoured by many professional Flutter developers for its separation of concerns and testability.

## ✨ Key Features

- **Automated Project Setup**: Instantly generate a complete project structure.
- **Clean Architecture**: Follows industry-standard TDD + Clean Architecture principles.
- **Feature Generation**: Easily add new features (like Authentication) with a single command.
- **Dependency Management**: Automatically adds necessary dependencies and dev-dependencies.
- **Customizable**: Generated code is a starting point you can tailor to your needs.

## 📦 Installation

Install the package globally from the command line:

```shell
dart pub global activate easy_init_cli
```

## 🛠️ Usage Guide

### 1. Create a New Project

Generate a new Flutter project with a custom organization domain:

```shell
easy create project
```

Follow the prompts to enter your project name and organization domain (e.g., `com.example`).

### 2. Initialize Architecture

Navigate to your project directory:

```shell
cd <your_project_name>
```

Initialize the project structure:

```shell
easy init
```

You will be prompted to select an architecture. Currently, **TDD + Clean Architecture** is the supported pattern.

![Architecture Selection](https://github.com/Vineeth-Kolichal/easy_init_cli/assets/92266542/b4fd61a6-5c54-4af6-8b48-e22b136f315f)

### 3. Create a Feature

Generate a new feature module following Clean Architecture principles:

```shell
easy create feature
```

Or specify the feature name directly:

```shell
easy create feature:<feature_name>
```

> **Note**: If you name your feature `auth` or `authentication`, the CLI will automatically include authentication-related screen files.

### 4. Run Build Runner

Simplify running the build_runner for code generation:

```shell
easy build
```

### 5. Update CLI

Keep your CLI up to date with the latest features and fixes:

```shell
easy update
```

### 6. Create Services

Generate common service helpers and utilities:

```shell
easy create services
```

You will be prompted to choose from available services:
- **FCM Services**: Firebase Cloud Messaging setup.
- **Token Manager**: Secure storage defined token management.
- **Shared Preferences Services**: Shared Preferences helper.

The CLI will automatically add the necessary dependencies to your `pubspec.yaml` and create the service files in `lib/core/services/`.

## 🏗️ Architecture

### TDD + Clean Architecture

This architecture separates the code into three main layers: **Data**, **Domain**, and **Presentation**, ensuring independence and testability.

#### Project Structure

```
lib/
├── app.dart                     # Main application widget
├── app_runner.dart              # Application runner configuration
├── main.dart                    # Application entry point
├── common/                      # Reusable components, utilities, and shared logic across features
│   └── widgets/                 # Common UI components
├── core/                        # Core functionalities, infrastructure, and cross-cutting concerns
│   ├── api_endpoints/           # API endpoint definitions
│   ├── base_usecase/            # Base use case definitions
│   ├── config/                  # Application configuration
│   ├── dependency_injection/    # Dependency injection setup
│   ├── extensions/              # Dart extensions
│   ├── failures/                # Custom failure classes for error handling
│   ├── network/                 # Network client and handling
│   ├── routes/                  # Application routing definitions
│   ├── services/                # Core services
│   └── theme/                   # Application theme and colors
└── features/                    # Feature-specific modules, each following clean architecture
    └── <feature_name>/
        ├── data/                # Data layer (repositories implementation, data sources, models)
        │   ├── data_sources/    # Remote and local data sources
        │   ├── models/          # Data transfer objects (DTOs)
        │   └── repositories_impl/# Repository implementations
        ├── domain/              # Domain layer (entities, repository interfaces, use cases)
        │   ├── entities/        # Core business entities
        │   ├── repositories/    # Repository interfaces
        │   └── usecases/        # Business logic (use cases)
        └── presentation/        # Presentation layer (UI, blocs, widgets)
            ├── blocs/           # BLoC for state management
            ├── screens/         # Screens/Pages
            └── widgets/         # UI components specific to the feature
```
For a deep dive into this architecture, we recommend [Reso Coder's Flutter Clean Architecture Course](https://resocoder.com/flutter-clean-architecture-tdd/).

> **Note**: A "Number Trivia" feature is generated by default to demonstrate the architecture's flow. You can use this as a reference or remove it when you start building your core features.

## 🤝 Contributing

Contributions are welcome! If you find a bug or have a feature request, please open an issue.

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/my-feature`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/my-feature`).
5. Open a Pull Request.

## � Contributors

<a href="https://github.com/Vineeth-Kolichal/easy_init_cli/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Vineeth-Kolichal/easy_init_cli" />
</a>

## �📄 License

This project is licensed under the BSD 3-Clause License - see the [LICENSE](LICENSE) file for details.
