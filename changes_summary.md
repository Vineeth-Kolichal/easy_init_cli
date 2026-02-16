# Changes Summary

This document describes the changes made in Clean architecture file content.

> **Note:** The `sample` feature has been introduced to replace the `number_trivia` feature. All content in the `sample` feature is new and replaces the functionality previously provided by `number_trivia`.

## Modified Files

### `lib/app.dart`

**Old Code**
```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/dependency_injection/config/configure_injection.dart';
import 'core/routes/app_router.dart';
import 'core/theme/theme.dart';
import 'features/number_trivia/presentation/blocs/number_trivia_bloc/number_trivia_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Text styles
    TextTheme appTextTheme = AppTextStyles.getTextTheme();
    //Theme
    AppTheme theme = AppTheme(appTextTheme);
    return MultiBlocProvider(
      // Providing multiple blocs at the root of the widget tree
      providers: [BlocProvider(create: (context) => getIt<NumberTriviaBloc>())],
      child: MaterialApp.router(
        title: "App title",
        themeMode: ThemeMode.system,
        theme: theme.light(),
        darkTheme: theme.dark(),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
```

**New Code**
```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/dependency_injection/config/configure_injection.dart';
import 'core/routes/app_router.dart';
import 'core/theme/theme.dart';

import 'core/theme/theme_service.dart';
import 'features/sample/presentation/blocs/sample_bloc/sample_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Text styles
    TextTheme appTextTheme = AppTextStyles.getTextTheme();
    //Theme
    AppTheme theme = AppTheme(appTextTheme);
    return MultiBlocProvider(
      // Providing multiple blocs at the root of the widget tree
      providers: [BlocProvider(create: (context) => getIt<SampleBloc>())],
      child: ValueListenableBuilder(
        valueListenable: ThemeService.isDarkThemeNotifier,
        builder: (context, isDark, child) {
          return MaterialApp.router(
            title: "App title",
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            theme: theme.light(),
            darkTheme: theme.dark(),
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
```

### `lib/common/widgets/loading.dart`

**Old Code**
```dart
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/extensions/extensions.dart';
import '../../core/theme/app_colors.dart';

class Loading extends StatelessWidget {
  ///Example:
  ///-------------------------
  ///```
  /// class HomeScreen extends StatelessWidget {
  ///   const HomeScreen({super.key});
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return Scaffold(
  ///       appBar: AppBar(
  ///         title: const Text("Home Screen"),
  ///       ),
  ///       body: const Loading(
  ///         isLoading: true // your loding contidtion here
  ///         child: MyUI(), //code for your screen UI,
  ///       ),
  ///     );
  ///   }
  /// }
  /// ```
  const Loading({
    super.key,
    required this.child,
    required this.isLoading,
  });
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    AppColors? appColors = context.appColors;

    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: appColors?.kBlack.withOpacity(0.3),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                height: 70,
                decoration: BoxDecoration(
                  color: appColors?.surfaceColor,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Platform.isIOS
                        ? const CupertinoActivityIndicator(
                            radius: 15,
                          )
                        : const CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                    15.horizontalSpace,
                    Text(
                      "Please Wait...",
                      style: context.labelLarge(),
                    )
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
```

**New Code**
```dart
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/extensions/theme_ext.dart';
import '../../core/theme/app_colors.dart';

class Loading extends StatelessWidget {
  ///Example:
  ///-------------------------
  ///```
  /// class HomeScreen extends StatelessWidget {
  ///   const HomeScreen({super.key});
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return Scaffold(
  ///       appBar: AppBar(
  ///         title: const Text("Home Screen"),
  ///       ),
  ///       body: const Loading(
  ///         isLoading: true // your loding contidtion here
  ///         child: MyUI(), //code for your screen UI,
  ///       ),
  ///     );
  ///   }
  /// }
  /// ```
  const Loading({super.key, required this.child, required this.isLoading});
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    AppColors? appColors = context.appColors;
    if (!isLoading) {
      return child;
    }

    return Stack(
      children: [
        child,
        Container(
          color: appColors?.kBlack.withValues(alpha: 0.3),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              height: 70,
              decoration: BoxDecoration(
                color: appColors?.surfaceColor,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Platform.isIOS
                      ? const CupertinoActivityIndicator(radius: 15)
                      : const CircularProgressIndicator(strokeWidth: 2),
                  const SizedBox(width: 15),
                  Text("Please Wait...", style: context.labelLarge()),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
```

### `lib/common/widgets/responsive.dart`

**Old Code**
```dart
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive(
      {super.key, required this.desktop, this.tablet, required this.mobile});
  final Widget desktop;
  final Widget? tablet;
  final Widget mobile;

  static bool isMobile(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width < 500;
  }

  static bool isTabltet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width > 500 && width < 1024;
  }

  static bool isDestop(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 1024;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1024) {
          return desktop;
        } else if (constraints.maxWidth > 500 && constraints.maxWidth < 1024) {
          return tablet == null ? mobile : tablet!;
        } else {
          return mobile;
        }
      },
    );
  }
}
```

**New Code**
```dart
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({
    super.key,
    required this.desktop,
    this.tablet,
    required this.mobile,
  });
  final Widget desktop;
  final Widget? tablet;
  final Widget mobile;

  static bool isMobile(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width < 500;
  }

  static bool isTabltet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width > 500 && width < 1024;
  }

  static bool isDestop(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 1024;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1024) {
          return desktop;
        } else if (constraints.maxWidth > 500 && constraints.maxWidth < 1024) {
          return tablet == null ? mobile : tablet!;
        } else {
          return mobile;
        }
      },
    );
  }
}
```

### `lib/core/api_endpoints/api_endpoints.dart`

**Old Code**
```dart
class ApiEndpoints {
  /// change the [baseUrl] value as per your api
  static String baseUrl = "http://numbersapi.com";
}
```

**New Code**
```dart
class ApiEndpoints {
  static String users = "/api/user";
  static String cliDetails = "/api/cli-details";
}
```

### `lib/core/config/flavor_config.dart`

**Old Code**
```dart
enum Flavor {
  dev,
  prod;

  @override
  String toString() => name;
}

class FlavorConfig {
  final String baseUrl;

  final Flavor flavor;

  FlavorConfig({required this.baseUrl, required this.flavor});

  static FlavorConfig? _instance;

  static void initialize(Flavor flavor) {
    switch (flavor) {
      case Flavor.dev:
        _instance = FlavorConfig(
          baseUrl: "http://numbersapi.com",
          flavor: Flavor.dev,
        );
        break;

      case Flavor.prod:
        _instance = FlavorConfig(
          baseUrl: "http://numbersapi.com",
          flavor: Flavor.prod,
        );
        break;
    }
  }

  static FlavorConfig get instance {
    _instance ??= FlavorConfig(
      baseUrl: "http://numbersapi.com",
      flavor: Flavor.dev,
    );
    return _instance!;
  }
}
```

**New Code**
```dart
enum Flavor {
  dev,
  prod;

  @override
  String toString() => name;
}

class FlavorConfig {
  final String baseUrl;

  final Flavor flavor;

  FlavorConfig({required this.baseUrl, required this.flavor});

  static FlavorConfig? _instance;

  static void initialize(Flavor flavor) {
    switch (flavor) {
      case Flavor.dev:
        _instance = FlavorConfig(
          baseUrl: "https://easy-init-demo-api.vercel.app",
          flavor: Flavor.dev,
        );
        break;

      case Flavor.prod:
        _instance = FlavorConfig(
          baseUrl: "https://easy-init-demo-api.vercel.app",
          flavor: Flavor.prod,
        );
        break;
    }
  }

  static FlavorConfig get instance {
    _instance ??= FlavorConfig(
      baseUrl: "https://easy-init-demo-api.vercel.app",
      flavor: Flavor.dev,
    );
    return _instance!;
  }
}
```

### `lib/core/routes/app_router.dart`

**Old Code**
```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/number_trivia/presentation/screens/number_trivia_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const NumberTriviaScreen(),
      ),
    ],
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('Something Error'))),
  );
}
```

**New Code**
```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/sample/presentation/screens/sample_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SampleScreen()),
    ],
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('Something Error'))),
  );
}
```

### `lib/core/theme/app_colors.dart`

**Old Code**
```dart
import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  //TODO: Add branding based theme colors
  final Color? primary;
  final Color? secondary;

  //Utility colors
  final Color? surfaceColor;
  final Color? onSurface;
  final Color? appBarColor;

  //constant colors
  final Color kBlack;
  final Color kWhite;

  const AppColors({
    required this.primary,
    required this.secondary,
    required this.surfaceColor,
    required this.onSurface,
    required this.appBarColor,
    this.kBlack = Colors.black,
    this.kWhite = Colors.white,
  });

  @override
  AppColors copyWith({
    Color? primary,
    Color? secondary,
    Color? surfaceColor,
    Color? onSurface,
    Color? appBarColor,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      onSurface: onSurface ?? this.onSurface,
      appBarColor: appBarColor ?? this.appBarColor,
    );
  }

  @override
  AppColors lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(
        primary,
        other.primary,
        t,
      ),
      secondary: Color.lerp(
        secondary,
        other.secondary,
        t,
      ),
      surfaceColor: Color.lerp(
        surfaceColor,
        other.surfaceColor,
        t,
      ),
      onSurface: Color.lerp(
        onSurface,
        other.onSurface,
        t,
      ),
      appBarColor: Color.lerp(
        appBarColor,
        other.appBarColor,
        t,
      ),
    );
  }
}
```

**New Code**
```dart
import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  //TODO: Add branding based theme colors
  final Color? primary;
  final Color? secondary;

  //Utility colors
  final Color? surfaceColor;
  final Color? onSurface;
  final Color? appBarColor;
  final Color? contentBorder;
  final Color? subtext;
  final Color? cardBg;
  final Color? errorRed;

  //constant colors
  final Color kBlack;
  final Color kWhite;

  const AppColors({
    required this.primary,
    required this.secondary,
    required this.surfaceColor,
    required this.onSurface,
    required this.appBarColor,
    required this.contentBorder,
    required this.subtext,
    this.cardBg,
    this.errorRed,
    this.kBlack = Colors.black,
    this.kWhite = Colors.white,
  });

  @override
  AppColors copyWith({
    Color? primary,
    Color? secondary,
    Color? surfaceColor,
    Color? onSurface,
    Color? appBarColor,
    Color? contentBorder,
    Color? subtext,
    Color? cardBg,
    Color? errorRed,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      onSurface: onSurface ?? this.onSurface,
      appBarColor: appBarColor ?? this.appBarColor,
      contentBorder: contentBorder ?? this.contentBorder,
      subtext: subtext ?? this.subtext,
      cardBg: cardBg ?? this.cardBg,
      errorRed: errorRed ?? this.errorRed,
    );
  }

  @override
  AppColors lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t),
      secondary: Color.lerp(secondary, other.secondary, t),
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t),
      onSurface: Color.lerp(onSurface, other.onSurface, t),
      appBarColor: Color.lerp(appBarColor, other.appBarColor, t),
      contentBorder: Color.lerp(contentBorder, other.contentBorder, t),
      subtext: Color.lerp(subtext, other.subtext, t),
      cardBg: Color.lerp(cardBg, other.cardBg, t),
      errorRed: Color.lerp(errorRed, other.errorRed, t),
    );
  }
}
```

### `lib/core/theme/app_theme.dart`

**Old Code**
```dart
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  final TextTheme textTheme;

  const AppTheme(this.textTheme);

  //Light theme Colors
  static AppColors lightThemeColors() => const AppColors(
        primary: Color(0xFF0F34E9),
        secondary: Color(0xFFD3F5B7),
        surfaceColor: Color(0xFFFFFFFF),
        onSurface: Color(0xFF000000),
        appBarColor: Color(0xFFFFFFFF),
      );
  // Light theme ColorScheme
  static ColorScheme lightScheme() {
    return ColorScheme.fromSeed(
      seedColor: const Color(0xFF0F34E9),
      brightness: Brightness.light,
      errorContainer: const Color(0xFFFFF2EC),
      onErrorContainer: const Color(0xFFF44336),
    );
  }

  ThemeData light() {
    return theme(lightScheme(), lightThemeColors());
  }

  //Dark Theme colors
  static AppColors darkThemeColors() => const AppColors(
        primary: Color(0xFF0F9D58),
        secondary: Color(0xFF1DE9B6),
        surfaceColor: Color(0xFF121212),
        onSurface: Color(0xFFFFFFFF),
        appBarColor: Color(0xFF1F1F1F),
      );

  //Dark ColorScheme
  static ColorScheme darkScheme() {
    return ColorScheme.fromSeed(
      seedColor: const Color(0xFF0F34E9),
      brightness: Brightness.dark,
      error: const Color(0xFFCF6679),
      onError: const Color(0xFF1E1213),
      errorContainer: const Color(0xFF8E001A),
      onErrorContainer: const Color(0xFFFFDAD6),
    );
  }

  ThemeData dark() {
    return theme(darkScheme(), darkThemeColors());
  }

  ThemeData theme(ColorScheme colorScheme, AppColors appColors) => ThemeData(
        //Material 3 style
        useMaterial3: true,

        // Theme mode
        brightness: colorScheme.brightness,

        //Color scheme -set of all colors
        colorScheme: colorScheme,

        //Theme extensions
        extensions: <ThemeExtension<dynamic>>[appColors],

        //Default font family
        // fontFamily: FontFamily.inter,

        //Text theme for configure typography of app
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: appColors.primary,
        ),

        //Scffold background color of the app
        scaffoldBackgroundColor: appColors.surfaceColor,

        //Canvas color
        canvasColor: colorScheme.surfaceContainer,

        //Bottom navigation bar theme
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          backgroundColor: appColors.surfaceColor,
          selectedItemColor: appColors.primary,
          unselectedItemColor: appColors.onSurface?.withOpacity(0.5),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
        ),

        //Button theme
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              45,
            ),
          ),
        ),


        //Appbar theme
        appBarTheme: AppBarTheme(
          scrolledUnderElevation: 0,
          backgroundColor: appColors.appBarColor,
          iconTheme: IconThemeData(color: appColors.onSurface),
        ),
      );
}
```

**New Code**
```dart
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  final TextTheme textTheme;

  const AppTheme(this.textTheme);

  //Light theme Colors
  static AppColors lightThemeColors() => const AppColors(
    primary: Color(0xFF135BEC),
    secondary: Color(0xFFD3F5B7),
    surfaceColor: Color(0xFFF6F6F8),
    onSurface: Color(0xFF000000),
    appBarColor: Color(0xFFFFFFFF),
    contentBorder: Color(0xFF334155),
    subtext: Color(0xFF64748B),
    cardBg: Color(0xFFFFFFFF),
    errorRed: Color(0xFFFF3B30),
  );
  // Light theme ColorScheme
  static ColorScheme lightScheme() {
    return ColorScheme.fromSeed(
      seedColor: const Color(0xFF135BEC),
      brightness: Brightness.light,
      errorContainer: const Color(0xFFFFF2EC),
      onErrorContainer: const Color(0xFFF44336),
    );
  }

  ThemeData light() {
    return theme(lightScheme(), lightThemeColors());
  }

  //Dark Theme colors
  static AppColors darkThemeColors() => const AppColors(
    primary: Color(0xFF135BEC),
    secondary: Color(0xFF1DE9B6),
    surfaceColor: Color(0xFF101622),
    onSurface: Color(0xFFFFFFFF),
    appBarColor: Color(0xFF1F1F1F),
    contentBorder: Color(0xFF334155),
    subtext: Color(0xFF64748B),
    cardBg: Color(0xFF1F1F1F),
    errorRed: Color(0xFFFF453A),
  );

  //Dark ColorScheme
  static ColorScheme darkScheme() {
    return ColorScheme.fromSeed(
      seedColor: const Color(0xFF135BEC),
      brightness: Brightness.dark,
      error: const Color(0xFFCF6679),
      onError: const Color(0xFF1E1213),
      errorContainer: const Color(0xFF8E001A),
      onErrorContainer: const Color(0xFFFFDAD6),
    );
  }

  ThemeData dark() {
    return theme(darkScheme(), darkThemeColors());
  }

  ThemeData theme(ColorScheme colorScheme, AppColors appColors) => ThemeData(
    //Material 3 style
    useMaterial3: true,

    // Theme mode
    brightness: colorScheme.brightness,

    //Color scheme -set of all colors
    colorScheme: colorScheme,

    //Theme extensions
    extensions: <ThemeExtension<dynamic>>[appColors],

    //Default font family
    // fontFamily: FontFamily.inter,

    //Text theme for configure typography of app
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: appColors.primary,
    ),

    //Scffold background color of the app
    scaffoldBackgroundColor: appColors.surfaceColor,

    //Canvas color
    canvasColor: colorScheme.surfaceContainer,

    //Bottom navigation bar theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: appColors.surfaceColor,
      selectedItemColor: appColors.primary,
      unselectedItemColor: appColors.onSurface?.withOpacity(0.5),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),

    //Button theme
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
    ),

    //Appbar theme
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0,
      backgroundColor: appColors.appBarColor,
      iconTheme: IconThemeData(color: appColors.onSurface),
    ),
  );
}
```

## Newly Created Directories
- `lib/common/ui_utils/`
- `lib/features/sample/`

## Newly Created Files

### `lib/common/ui_utils/snack_bar.dart`
```dart
import 'package:flutter/material.dart';
import '../../core/extensions/theme_ext.dart';

class AppSnackBar {
  static void showSnackBar(
    BuildContext context, {
    required String message,
    bool isError = false,
    Duration duration = const Duration(seconds: 3),
  }) {
    final appColors = context.appColors;

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.bodyMedium(color: appColors?.kWhite ?? Colors.white),
        ),
        backgroundColor: isError
            ? (appColors?.errorRed ?? Colors.red)
            : Colors.green,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
```

### `lib/common/widgets/custom_text_field.dart`
```dart
import 'package:flutter/material.dart';
import '../../core/extensions/theme_ext.dart';

class CustomTextField extends FormField<String> {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final Widget? suffixIcon;
  final String? label;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? onVisibilityToggle;
  final Color? primaryColor;
  final Color? surfaceColor;
  final Color? onSurfaceColor;
  final TextInputType? keyboardType;
  final int? maxLines;

  CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.suffixIcon,
    this.label,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.onVisibilityToggle,
    this.primaryColor,
    this.surfaceColor,
    this.onSurfaceColor,
    this.keyboardType,
    super.validator,
    this.maxLines,
  }) : super(
         initialValue: controller.text,
         autovalidateMode: AutovalidateMode.onUserInteraction,
         builder: (FormFieldState<String> state) {
           return Builder(
             builder: (context) {
               final colors = context.appColors;
               final primary = primaryColor ?? colors?.primary ?? Colors.green;
               final onSurface =
                   onSurfaceColor ??
                   colors?.onSurface ??
                   Theme.of(context).colorScheme.onSurface;
               final errorColor =
                   colors?.errorRed ?? Theme.of(context).colorScheme.error;

               return Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   if (label != null) ...[
                     Align(
                       alignment: Alignment.centerLeft,
                       child: Padding(
                         padding: const EdgeInsets.only(left: 4),
                         child: Text(
                           label.toUpperCase(),
                           style: context.labelMedium(
                             color: onSurface.withValues(alpha: 0.8),
                             fontWeight: FontWeight.w500,
                           ),
                         ),
                       ),
                     ),
                     const SizedBox(height: 8),
                   ],
                   Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(16),
                       border: Border.all(
                         color: onSurface.withValues(alpha: 0.5),
                       ),
                     ),
                     child: TextField(
                       maxLines: isPassword ? 1 : maxLines,
                       controller: controller,
                       keyboardType: keyboardType,
                       obscureText: isPassword && !isPasswordVisible,
                       style: context.bodyMedium(color: onSurface),
                       cursorColor: primary,
                       onChanged: (text) {
                         state.didChange(text);
                       },
                       decoration: InputDecoration(
                         hintText: hintText,
                         hintStyle: context.bodyMedium(
                           color: onSurface.withValues(alpha: 0.5),
                         ),
                         prefixIcon: icon != null
                             ? Icon(
                                 icon,
                                 color: onSurface.withValues(alpha: 0.4),
                               )
                             : null,
                         suffixIcon:
                             suffixIcon ??
                             (isPassword
                                 ? IconButton(
                                     icon: Icon(
                                       isPasswordVisible
                                           ? Icons.visibility
                                           : Icons.visibility_off,
                                       color: onSurface.withValues(alpha: 0.4),
                                     ),
                                     onPressed: onVisibilityToggle,
                                   )
                                 : null),
                         border: InputBorder.none,
                         contentPadding: const EdgeInsets.symmetric(
                           horizontal: 16,
                           vertical: 16,
                         ),
                         enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(16),
                           borderSide: const BorderSide(
                             color: Colors.transparent,
                           ),
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(16),
                           borderSide: BorderSide(color: primary, width: 1.0),
                         ),
                       ),
                     ),
                   ),
                   if (state.hasError)
                     Padding(
                       padding: const EdgeInsets.only(top: 6.0, left: 4.0),
                       child: Text(
                         state.errorText!,
                         style: context.labelSmall(color: errorColor),
                       ),
                     ),
                 ],
               );
             },
           );
         },
       );
}
```

### `lib/common/widgets/generic_button.dart`
```dart
import 'package:flutter/material.dart';
import '../../core/extensions/theme_ext.dart';

class GenericButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double width;
  final double height;
  final double borderRadius;
  final bool isLoading;
  final IconData? icon;

  const GenericButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
    this.width = double.infinity,
    this.height = 56,
    this.borderRadius = 16,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final primary = backgroundColor ?? colors?.primary ?? Colors.green;
    final onPrimary = foregroundColor ?? Colors.white;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style:
            ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: onPrimary,
              elevation: 0,
              shadowColor: primary.withValues(alpha: 0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ).copyWith(
              shadowColor: WidgetStateProperty.all(
                primary.withValues(alpha: 0.3),
              ),
              elevation: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.hovered) && !isLoading) {
                  return 8;
                }
                return 0;
              }),
            ),
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(onPrimary),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: context
                        .labelLarge(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: onPrimary,
                        )
                        .copyWith(letterSpacing: 0.5),
                  ),
                  if (icon != null) ...[
                    const SizedBox(width: 8),
                    Icon(icon, color: onPrimary, size: 20),
                  ],
                ],
              ),
      ),
    );
  }
}
```

### `lib/core/theme/theme_service.dart`
```dart
import 'package:flutter/material.dart';

class ThemeService {
  static ValueNotifier<bool> isDarkThemeNotifier = ValueNotifier<bool>(false);

  static void toggleTheme() {
    isDarkThemeNotifier.value = !isDarkThemeNotifier.value;
  }

  static void setTheme({required bool isDark}) {
    isDarkThemeNotifier.value = isDark;
  }
}
```

### `lib/features/sample/presentation/screens/sample_screen.dart`
```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/ui_utils/snack_bar.dart';
import '../../../../common/widgets/custom_text_field.dart';
import '../../../../common/widgets/generic_button.dart';
import '../../../../common/widgets/loading.dart';
import '../../../../core/extensions/theme_ext.dart';
import '../../../../core/theme/theme_service.dart';
import '../../domain/entities/user_entity.dart';
import '../blocs/sample_bloc/sample_bloc.dart';
import '../widgets/header_section.dart';

class SampleScreen extends StatefulWidget {
  const SampleScreen({super.key});

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  final TextEditingController _textController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Trigger initial data fetch
    context.read<SampleBloc>().add(const SampleEvent.getCliDetails());
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Scaffold(
      body: BlocListener<SampleBloc, SampleState>(
        listener: (context, state) {
          if (state.userResponse != null) {
            _showGreetingDialog(context, state.userResponse!);
            context.read<SampleBloc>().add(
              const SampleEvent.clearUserResponse(),
            );
          }
          if (state.userError != null) {
            AppSnackBar.showSnackBar(
              context,
              message: state.userError!,
              isError: true,
            );
          }
          if (state.cliError != null) {
            AppSnackBar.showSnackBar(
              context,
              message: state.cliError!,
              isError: true,
            );
          }
        },
        child: BlocBuilder<SampleBloc, SampleState>(
          builder: (context, state) {
            return Loading(
              isLoading: state.isUserLoading || state.isCliLoading,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    onPressed: () {
                                      ThemeService.toggleTheme();
                                    },
                                    icon: Icon(
                                      context.isDarkTheme
                                          ? Icons.light_mode
                                          : Icons.dark_mode,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 64),
                                const HeaderSection(),
                                const SizedBox(height: 64),
                                CustomTextField(
                                  controller: _textController,
                                  hintText: "Enter Your Name",
                                  label: "Developer Name",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your name";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "This project is initialized with easy_init_cli. This sample feature demonstrates API call flow and UI styling. Once you understand the flow, you can remove this feature and start implementing your own.",
                                  textAlign: TextAlign.center,
                                  style: context.bodySmall(
                                    color: appColors?.subtext ?? Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GenericButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<SampleBloc>().add(
                              SampleEvent.getUser(_textController.text),
                            );
                          }
                        },
                        text: "Get Started",
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'easy_init_cli : v${state.cliDetails?.latestVersion ?? ''}',
                        style: context.bodySmall(color: appColors?.subtext),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else if (hour < 20) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  void _showGreetingDialog(BuildContext context, UserEntity data) {
    final appColors = context.appColors;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: appColors?.surfaceColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            _getGreeting(),
            style: context.headlineSmall(
              color: appColors?.primary ?? Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Message: ${data.message ?? 'No Message'}",
                style: context.bodyMedium(
                  color: appColors?.onSurface ?? Colors.black87,
                ),
              ),
              if (data.serverInfo != null) ...[
                const SizedBox(height: 8),
                Text(
                  "Server: ${data.serverInfo?.platform}",
                  style: context.labelSmall(
                    color: appColors?.subtext ?? Colors.grey,
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "OK",
                style: context.labelLarge(
                  color: appColors?.primary ?? Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
```

### `lib/features/sample/data/data_sources/sample_datasource.dart`
```dart
import 'package:injectable/injectable.dart';
import '../../../../core/api_endpoints/api_endpoints.dart';
import '../../../../core/network/network_client.dart';
import '../models/cli_details_model.dart';
import '../models/user_model.dart';

abstract class SampleDataSource {
  Future<UserModel> getUser(UserRequest request);
  Future<CliDetailsModel> getCliDetails();
}

@LazySingleton(as: SampleDataSource)
@injectable
class SampleDataSourceImpl implements SampleDataSource {
  final NetworkClient client;

  SampleDataSourceImpl(this.client);

  @override
  Future<UserModel> getUser(UserRequest request) async {
    try {
      final response = await client.post(
        path: ApiEndpoints.users,
        data: request.toJson(),
        requiresAuth: false,
      );
      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CliDetailsModel> getCliDetails() async {
    try {
      final response = await client.get(
        path: ApiEndpoints.cliDetails,
        requiresAuth: false,
      );
      return CliDetailsModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
```

### `lib/features/sample/data/models/cli_details_model.dart`
```dart
import '../../domain/entities/cli_details_entity.dart';

class CliDetailsModel extends CliDetailsEntity {
  CliDetailsModel({
    String? name,
    String? latestVersion,
    String? description,
    String? homepage,
    String? fetchedAt,
  }) : super(
         name: name,
         latestVersion: latestVersion,
         description: description,
         homepage: homepage,
         fetchedAt: fetchedAt,
       );

  factory CliDetailsModel.fromJson(Map<String, dynamic> json) {
    return CliDetailsModel(
      name: json['name'],
      latestVersion: json['latestVersion'],
      description: json['description'],
      homepage: json['homepage'],
      fetchedAt: json['fetchedAt'],
    );
  }
}
```

### `lib/features/sample/data/models/user_model.dart`
```dart
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    String? message,
    String? timestamp,
    String? status,
    ServerInfoModel? serverInfo,
  }) : super(
         message: message,
         timestamp: timestamp,
         status: status,
         serverInfo: serverInfo,
       );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      message: json['message'],
      timestamp: json['timestamp'],
      status: json['status'],
      serverInfo: json['serverInfo'] != null
          ? ServerInfoModel.fromJson(json['serverInfo'])
          : null,
    );
  }
}

class ServerInfoModel extends ServerInfoEntity {
  ServerInfoModel({String? platform, double? uptime})
    : super(platform: platform, uptime: uptime);

  factory ServerInfoModel.fromJson(Map<String, dynamic> json) {
    return ServerInfoModel(
      platform: json['platform'],
      uptime: (json['uptime'] as num?)?.toDouble(),
    );
  }
}

class UserRequest {
  final String? username;

  UserRequest({this.username});

  Map<String, dynamic> toJson() {
    return {'userName': username};
  }
}
```


### `lib/features/sample/data/repositories_impl/sample_repository_impl.dart`
```dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../domain/entities/cli_details_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/sample_repository.dart';
import '../data_sources/sample_datasource.dart';
import '../models/user_model.dart';

@LazySingleton(as: SampleRepository)
@injectable
class SampleRepositoryImpl implements SampleRepository {
  final SampleDataSource dataSource;

  SampleRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, UserEntity>> getUser(String username) async {
    try {
      final request = UserRequest(username: username);
      final result = await dataSource.getUser(request);
      return Right(result);
    } on CustomException catch (e) {
      return Left(Failure.apiRequestFailure(e.message));
    } catch (e) {
      return Left(Failure.apiRequestFailure("Something went wrong"));
    }
  }

  @override
  Future<Either<Failure, CliDetailsEntity>> getCliDetails() async {
    try {
      final result = await dataSource.getCliDetails();
      return Right(result);
    } on CustomException catch (e) {
      return Left(Failure.apiRequestFailure(e.message));
    } catch (e) {
      return Left(Failure.apiRequestFailure("Something went wrong"));
    }
  }
}
```

### `lib/features/sample/domain/entities/cli_details_entity.dart`
```dart
class CliDetailsEntity {
  final String? name;
  final String? latestVersion;
  final String? description;
  final String? homepage;
  final String? fetchedAt;

  CliDetailsEntity({
    this.name,
    this.latestVersion,
    this.description,
    this.homepage,
    this.fetchedAt,
  });
}
```

### `lib/features/sample/domain/entities/user_entity.dart`
```dart
class UserEntity {
  final String? message;
  final String? timestamp;
  final String? status;
  final ServerInfoEntity? serverInfo;

  UserEntity({this.message, this.timestamp, this.status, this.serverInfo});
}

class ServerInfoEntity {
  final String? platform;
  final double? uptime;

  ServerInfoEntity({this.platform, this.uptime});
}
```

### `lib/features/sample/domain/repositories/sample_repository.dart`
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../entities/cli_details_entity.dart';
import '../entities/user_entity.dart';

abstract class SampleRepository {
  Future<Either<Failure, UserEntity>> getUser(String username);
  Future<Either<Failure, CliDetailsEntity>> getCliDetails();
}
```

### `lib/features/sample/domain/usecases/get_cli_details_usecase.dart`
```dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base_usecase/base_usecase.dart';
import '../../../../core/failures/failures.dart';
import '../entities/cli_details_entity.dart';
import '../repositories/sample_repository.dart';

@lazySingleton
@injectable
class GetCliDetailsUseCase implements UseCase<CliDetailsEntity, NoParams> {
  final SampleRepository repository;

  GetCliDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, CliDetailsEntity>> call(NoParams params) async {
    return await repository.getCliDetails();
  }
}
```

### `lib/features/sample/domain/usecases/get_user_usecase.dart`
```dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base_usecase/base_usecase.dart';
import '../../../../core/failures/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/sample_repository.dart';

@lazySingleton
@injectable
class GetUserUseCase implements UseCase<UserEntity, String> {
  final SampleRepository repository;

  GetUserUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(String params) async {
    return await repository.getUser(params);
  }
}
```


### `lib/features/sample/presentation/blocs/sample_bloc/sample_bloc.dart`
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base_usecase/base_usecase.dart';
import '../../../../../core/failures/failures.dart';
import '../../../domain/entities/cli_details_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/get_cli_details_usecase.dart';
import '../../../domain/usecases/get_user_usecase.dart';

part 'sample_event.dart';
part 'sample_state.dart';
part 'sample_bloc.freezed.dart';

@injectable
class SampleBloc extends Bloc<SampleEvent, SampleState> {
  final GetUserUseCase getUserUseCase;
  final GetCliDetailsUseCase getCliDetailsUseCase;

  SampleBloc(this.getUserUseCase, this.getCliDetailsUseCase)
    : super(SampleState.initial()) {
    on<_GetUser>((event, emit) async {
      emit(state.copyWith(isUserLoading: true, userError: null));
      final result = await getUserUseCase(event.username);
      result.fold(
        (failure) => emit(
          state.copyWith(
            isUserLoading: false,
            userError: failure.map(apiRequestFailure: (e) => e.error),
          ),
        ),
        (success) =>
            emit(state.copyWith(isUserLoading: false, userResponse: success)),
      );
    });

    on<_GetCliDetails>((event, emit) async {
      emit(state.copyWith(isCliLoading: true, cliError: null));
      final result = await getCliDetailsUseCase(NoParams());
      result.fold(
        (failure) => emit(
          state.copyWith(
            isCliLoading: false,
            cliError: failure.map(apiRequestFailure: (e) => e.error),
          ),
        ),
        (success) =>
            emit(state.copyWith(isCliLoading: false, cliDetails: success)),
      );
    });

    on<_ClearUserResponse>((event, emit) {
      emit(state.copyWith(userResponse: null));
    });
  }
}
```

### `lib/features/sample/presentation/blocs/sample_bloc/sample_event.dart`
```dart
part of 'sample_bloc.dart';

@freezed
class SampleEvent with _$SampleEvent {
  const factory SampleEvent.started() = _Started;
  const factory SampleEvent.getUser(String username) = _GetUser;
  const factory SampleEvent.getCliDetails() = _GetCliDetails;
  const factory SampleEvent.clearUserResponse() = _ClearUserResponse;
}
```

### `lib/features/sample/presentation/blocs/sample_bloc/sample_state.dart`
```dart
part of 'sample_bloc.dart';

@freezed
sealed class SampleState with _$SampleState {
  const factory SampleState({
    @Default(false) bool isUserLoading,
    String? userError,
    UserEntity? userResponse,
    @Default(false) bool isCliLoading,
    String? cliError,
    CliDetailsEntity? cliDetails,
  }) = _Initial;

  factory SampleState.initial() => const SampleState();
}
```

### `lib/features/sample/presentation/widgets/header_section.dart`
```dart
import 'package:flutter/material.dart';
import '../../../../core/extensions/theme_ext.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: appColors?.primary?.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: appColors?.primary?.withValues(alpha: 0.3) ?? Colors.blue,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    appColors?.primary?.withValues(alpha: 0.3) ?? Colors.blue,
                blurRadius: 15,
                spreadRadius: -3,
              ),
            ],
          ),
          child: Icon(Icons.terminal, color: appColors?.primary, size: 32),
        ),
        const SizedBox(height: 16),
        Text(
          "easy_init_cli",
          style: context
              .headlineSmall(fontWeight: FontWeight.bold)
              .copyWith(letterSpacing: -0.5),
        ),
        const SizedBox(height: 4),
        Text(
          "PROJECT INITIALIZATION",
          style: context
              .labelSmall(
                color:
                    appColors?.primary?.withValues(alpha: 0.6) ?? Colors.grey,
                fontWeight: FontWeight.w500,
              )
              .copyWith(letterSpacing: 1.5),
        ),
      ],
    );
  }
}
```


## Deleted Files
- `lib/features/number_trivia/data/data_sources/number_trivia_datasource.dart`
- `lib/features/number_trivia/data/models/trivia_model.dart`
- `lib/features/number_trivia/data/repositories_impl/number_trivia_repo_impl.dart`
- `lib/features/number_trivia/domain/entities/trivia_entity.dart`
- `lib/features/number_trivia/domain/repositories/number_trivia_repository.dart`
- `lib/features/number_trivia/domain/usecases/get_number_trivia_usecase.dart`
- `lib/features/number_trivia/presentation/blocs/.gitkeep`
- `lib/features/number_trivia/presentation/blocs/number_trivia_bloc/number_trivia_bloc.dart`
- `lib/features/number_trivia/presentation/blocs/number_trivia_bloc/number_trivia_bloc.freezed.dart`
- `lib/features/number_trivia/presentation/blocs/number_trivia_bloc/number_trivia_event.dart`
- `lib/features/number_trivia/presentation/blocs/number_trivia_bloc/number_trivia_state.dart`
- `lib/features/number_trivia/presentation/screens/number_trivia_screen.dart`
- `lib/features/number_trivia/presentation/widgets/.gitkeep`

