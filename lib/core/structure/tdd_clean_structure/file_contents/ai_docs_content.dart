const String stylingGuideArgs = '''# Styling Guide for AI Coding Assistants

This guide outlines the styling conventions and color management practices for this project.

## Color Management
**DO NOT** hardcode colors in widgets. All colors should be defined in `AppColors` and accessed via the `context`.

### Using Colors
To access colors in a widget:
1.  Use the `AppColors` extension on `BuildContext`.
2.  For repeated usage, define a local variable:
    ```dart
    final appColors = context.appColors;
    ```
3.  Access specific colors:
    ```dart
    Container(
      color: appColors?.primary,
      // ...
    )
    ```

### Adding New Colors
If a required color is missing from `AppColors`:
1.  **Modify `lib/core/theme/app_colors.dart`**:
    - Add a `final Color? newColorName;` field.
    - Update the constructor to require this new field.
    - Update `copyWith` and `lerp` methods to handle the new field.

2.  **Modify `lib/core/theme/app_theme.dart`**:
    - Update `lightThemeColors()` to provide the light mode value for the new color.
    - Update `darkThemeColors()` to provide the dark mode value for the new color.

## Text Styling
- Use the extensions provided in `lib/core/extensions/theme_ext.dart` to access text styles (e.g., `context.labelLarge`, `context.bodyMedium`).
- **Example**:
    ```dart
    Text(
      "Get Trivia", // Button text
      style: context.labelLarge(
        color: appColors?.surfaceColor,
      ),
    ),
    ```
- **Modifying Styles**: Use `copyWith` if additional changes are needed.
    ```dart
    Text(
      "Get Trivia",
      style: context.labelLarge(
        color: appColors?.surfaceColor,
      ).copyWith(letterSpacing: 4), // Use copyWith for extra changes
    ),
    ```
- **Opacity**: If you need to adjust opacity, use `.withValues` instead of `.withOpacity`, as `.withOpacity` is deprecated.
    ```dart
    color: appColors?.primary?.withValues(alpha: 0.5), // Correct
    // color: appColors?.primary?.withOpacity(0.5), // Deprecated - DO NOT USE
    ```
## General Styling
- Prefer using `context.setThemeBasedColor` (if available in extensions) for simple light/dark mode switches inline, but for shared definition, prefer `AppColors`.

''';

const String apiFlowGuideArgs = '''# API Call Flow & Clean Architecture Guide

This project follows **Clean Architecture** to ensure separation of concerns and scalability. All API integrations must follow this pattern.

## Overview
The architecture is divided into three main layers:
1.  **Data Layer**: Handles data retrieval (API calls, local DB) and serialization.
2.  **Domain Layer**: Contains pure business logic and contracts (Entities, UseCases, Repository Interfaces).
3.  **Presentation Layer**: Handles UI and State Management (BLoC).

## Step-by-Step Implementation Flow

### 1. Define API Endpoints
- Add your API endpoints in `lib/core/api_endpoints/api_endpoints.dart`.

### 2. Domain Layer (The Contract)
Start here to define *what* the feature does.
1.  **Entity**: Create a pure Dart class representing the business object.
    ```dart
    class MyFeatureEntity {
      final String id;
      final String name;

      MyFeatureEntity({required this.id, required this.name});
    }
    ```
2.  **Repository Interface**: Define the abstract contract for data retrieval.
    - Return `Future<Either<Failure, MyFeatureEntity>>`.
    ```dart
    abstract class MyFeatureRepository {
      Future<Either<Failure, MyFeatureEntity>> getData(MyParams params);
    }
    ```
3.  **UseCase**: Implement the business logic for a specific action.
    - Should implement `UseCase<Type, Params>`.
    ```dart
    @lazySingleton
    @injectable
    class GetMyFeatureUseCase implements UseCase<MyFeatureEntity, MyParams> {
      final MyFeatureRepository repository;
      GetMyFeatureUseCase(this.repository);

      @override
      Future<Either<Failure, MyFeatureEntity>> call(MyParams params) async {
        return repository.getData(params);
      }
    }
    ```

### 3. Data Layer (The Implementation)
Implement *how* the data is fetched.
1.  **Model**: Create a class that extends your **Entity**.
    - **MUST** include `fromJson` factory for serialization.
    ```dart
    class MyFeatureModel extends MyFeatureEntity {
      MyFeatureModel({required String id, required String name})
          : super(id: id, name: name);

      factory MyFeatureModel.fromJson(Map<String, dynamic> json) {
        return MyFeatureModel(
          id: json['id'],
          name: json['name'],
        );
      }
    }
    ```
2.  **DataSource**: Define the API call logic.
    - Use `NetworkClient` for requests.
    - Return `Model`.
    ```dart
    @LazySingleton(as: MyFeatureDataSource)
    @injectable
    class MyFeatureDataSourceImpl implements MyFeatureDataSource {
      final NetworkClient client;
      MyFeatureDataSourceImpl(this.client);

      @override
      Future<MyFeatureModel> getData(MyParams params) async {
        try {
          final response = await client.get(path: "/my-feature");
          return MyFeatureModel.fromJson(response.data);
        } catch (e) {
          rethrow;
        }
      }
    }
    ```
3.  **Repository Implementation**: Implement the Domain Repository interface.
    - Call the DataSource.
    - Map exceptions to `Failure`.
    - Return `Either<Failure, Entity>`.
    ```dart
    @LazySingleton(as: MyFeatureRepository)
    @injectable
    class MyFeatureRepoImpl implements MyFeatureRepository {
      final MyFeatureDataSource dataSource;
      MyFeatureRepoImpl(this.dataSource);

      @override
      Future<Either<Failure, MyFeatureEntity>> getData(MyParams params) async {
        try {
          final result = await dataSource.getData(params);
          return Right(result);
        } on CustomException catch (e) {
          return Left(Failure.apiRequestFailure(e.message));
        }
      }
    }
    ```

### 4. Presentation Layer (The UI)
Manage state and user interaction.
1.  **BLoC**: Create a BLoC to handle events and emit states.
    - Inject the UseCase.
    ```dart
    @injectable
    class MyFeatureBloc extends Bloc<MyFeatureEvent, MyFeatureState> {
      final GetMyFeatureUseCase useCase;

      MyFeatureBloc(this.useCase) : super(MyFeatureState.initial()) {
        on<GetDataEvent>((event, emit) async {
            // ... implementation
        });
      }
    }
    ```
2.  **Events & States**:
    - **MUST** use `freezed` for code generation.
    - **State** class **MUST** be a `sealed class`.
    - **DO NOT** use `equatable`.

    **Generic Event Structure**:
    ```dart
    part of 'my_feature_bloc.dart';

    @freezed
    class MyFeatureEvent with _\$MyFeatureEvent {
      const factory MyFeatureEvent.getData() = GetData;
    }
    ```

    **Generic State Structure**:
    ```dart
    part of 'my_feature_bloc.dart';

    @freezed
    sealed class MyFeatureState with _\$MyFeatureState {
      const factory MyFeatureState({
        required bool isLoading,
        String? error,
        MyFeatureEntity? data,
      }) = _Initial;

      factory MyFeatureState.initial() => const MyFeatureState(isLoading: false);
    }
    ```
3.  **Dependency Injection**:
    - Update `lib/app.dart` to provide the new BLoC using `MultiBlocProvider`.
    - Ensure your classes are annotated with `@injectable` or `@lazySingleton`.

## Dependency Injection & Code Generation
- Use `easy_init_cli` structure.
- Run the build runner to generate code (Freezed, JSON serialization, DI):
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```
    *(Or use the `easy build` command if available)*
''';

const String readmeContentArgs = '''
# Project Title

This project is initialized with **Easy Init CLI** using **Clean Architecture**.

## 📂 Folder Structure

The project follows a scalable folder structure:

```
lib/
├── common/             # Common utilities and helper classes
├── core/               # Core application layers
│   ├── api_endpoints/  # API endpoint definitions
│   ├── config/         # Application configuration files
│   ├── dependency_injection/ # Dependency injection setup
│   ├── extensions/     # Dart extensions associated with core
│   ├── failures/       # Error handling and failures
│   ├── network/        # Network client and exceptions
│   ├── routes/         # Application routing
│   ├── services/       # External services integrations
│   └── theme/          # App theme, colors, and typography
├── features/           # Feature-based clean architecture modules
│   └── [feature_name]/
│       ├── data/       # Data layer (Repositories Impl, Data Sources, Models)
│       ├── domain/     # Domain layer (Entities, UseCases, Repositories)
│       └── presentation/ # Presentation layer (BLoC, Screens, Widgets)
├── main.dart           # Entry point
└── app.dart            # Main app widget
```

## 🤖 AI Vibe Coding

To get the most accurate and context-aware code generation from AI tools (Vibe Coding tool like Antigravity,Cursor etc), please refer to the documents in the `ai_docs` folder:

- **[Styling Guide](ai_docs/styling_guide.md)**: Follow this guide for UI styling, color usage, and theming.
- **[API Flow Guide](ai_docs/api_flow_guide.md)**: Follow this guide for implementing new features, API integration, and state management.

### How to use these docs with AI:
When asking the AI to implement a new feature or fix a UI issue, you can reference these files to ensure the output matches the project's standards.

**Example Prompt:**
> "Implement a new feature for 'User Profile' following the @[ai_docs/api_flow_guide.md] and using the styles defined in @[ai_docs/styling_guide.md]."
''';
