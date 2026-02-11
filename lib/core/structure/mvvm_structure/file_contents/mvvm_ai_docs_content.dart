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

const String mvvmApiFlowGuideArgs = '''# API Call Flow & MVVM Architecture Guide

This project follows **MVVM Architecture** with **Provider** for state management.

## Overview
The architecture is divided into three main layers:
1.  **Data Layer**: Handles data retrieval (API calls, local DB) and serialization.
2.  **Domain Layer (Repositories)**: Defines contracts for data retrieval.
3.  **Presentation Layer (MVVM)**: 
    - **View (UI)**: Displays data and captures user input.
    - **ViewModel**: Manages state, business logic, and communicates with repositories.

## Step-by-Step Implementation Flow

### 1. Define API Endpoints
- Add your API endpoints in `lib/core/api_endpoints/api_endpoints.dart`.

### 2. Data Layer
1.  **Model**: Create a class representing the data.
    - **MUST** include `fromJson` factory for serialization.
    ```dart
    class MyFeatureModel {
      final String id;
      final String name;

      MyFeatureModel({required this.id, required this.name});

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
3.  **Repository**: Implement the Repository interface to bridge DataSource and ViewModel.
    ```dart
    abstract class MyFeatureRepository {
      Future<MyFeatureModel> getData(MyParams params);
    }

    @LazySingleton(as: MyFeatureRepository)
    @injectable
    class MyFeatureRepoImpl implements MyFeatureRepository {
      final MyFeatureDataSource dataSource;
      MyFeatureRepoImpl(this.dataSource);

      @override
      Future<MyFeatureModel> getData(MyParams params) async {
        return await dataSource.getData(params);
      }
    }
    ```

### 3. Presentation Layer (MVVM)
1.  **ViewModel**: Create a `ChangeNotifier` to handle state.
    - Inject the Repository.
    ```dart
    @injectable
    class MyFeatureViewModel extends ChangeNotifier {
      final MyFeatureRepository repository;
      MyFeatureViewModel(this.repository);

      MyFeatureModel? _data;
      MyFeatureModel? get data => _data;

      bool _isLoading = false;
      bool get isLoading => _isLoading;

      String? _error;
      String? get error => _error;

      Future<void> fetchData() async {
        _isLoading = true;
        _error = null;
        notifyListeners();

        try {
          _data = await repository.getData(MyParams());
        } catch (e) {
          _error = "Something went wrong";
        } finally {
          _isLoading = false;
          notifyListeners();
        }
      }
    }
    ```
2.  **View (UI)**: Use `Consumer` or `context.watch/read` to listen to ViewModel.
    - Provide the ViewModel using `ChangeNotifierProvider`.
    ```dart
    class MyFeatureScreen extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return ChangeNotifierProvider(
          create: (context) => getIt<MyFeatureViewModel>(),
          child: Consumer<MyFeatureViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) return CircularProgressIndicator();
              if (viewModel.error != null) return Text(viewModel.error!);
              return Text(viewModel.data?.name ?? "No Data");
            },
          ),
        );
      }
    }
    ```

## Dependency Injection
- Use `@injectable`, `@lazySingleton` annotations.
- Run `dart run build_runner build` to generate DI code.
''';

const String readmeContentArgs = '''
# Project Title

This project is initialized with **Easy Init CLI** using **MVVM Architecture** (Provider).

## 📂 Folder Structure

The project follows a scalable feature-first folder structure:

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
├── features/           # Feature-based modules
│   └── [feature_name]/
│       ├── data/       # Data layer (Repositories Impl, Data Sources)
│       ├── models/     # Data models
│       ├── view_model/ # ViewModels (State Management)
│       └── view/       # UI Screens and Widgets
├── main.dart           # Entry point
└── app.dart            # Main app widget
```

## 🤖 AI Vibe Coding

To get the most accurate and context-aware code generation from AI tools, please refer to the documents in the `ai_docs` folder:

- **[Styling Guide](ai_docs/styling_guide.md)**: Follow this guide for UI styling, color usage, and theming.
- **[API Flow Guide](ai_docs/api_flow_guide.md)**: Follow this guide for implementing new features and state management with MVVM/Provider.
''';
