String themeContent = '''
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

''';
String colorsContent = '''
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

''';
const appFontWeight = '''
import 'package:flutter/widgets.dart';

/// Namespace for Default App Font Weights
abstract class AppFontWeight {
  static const FontWeight black = FontWeight.w900;

  static const FontWeight extraBold = FontWeight.w800;

  static const FontWeight bold = FontWeight.w700;

  static const FontWeight semiBold = FontWeight.w600;

  static const FontWeight medium = FontWeight.w500;

  static const FontWeight regular = FontWeight.w400;

  static const FontWeight light = FontWeight.w300;

  static const FontWeight extraLight = FontWeight.w200;

  static const FontWeight thin = FontWeight.w100;
}

''';

const textStyles = '''
import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static TextTheme getTextTheme() {

    //Base text style 
    TextStyle baseTextStyle = const TextStyle(
      decoration: TextDecoration.none,
    );
    return TextTheme(
      //Display
      displayLarge: baseTextStyle.copyWith(
        fontSize: 57,
      ),
      displayMedium: baseTextStyle.copyWith(
        fontSize: 45,
      ),
      displaySmall: baseTextStyle.copyWith(
        fontSize: 36,
      ),

      //Headline
      headlineLarge: baseTextStyle.copyWith(
        fontSize: 32,
      ),
      headlineMedium: baseTextStyle.copyWith(
        fontSize: 28,
      ),
      headlineSmall: baseTextStyle.copyWith(
        fontSize: 24,
      ),

      //Title
      titleLarge: baseTextStyle.copyWith(
        fontSize: 22,
      ),
      titleMedium: baseTextStyle.copyWith(
        fontSize: 16,
      ),
      titleSmall: baseTextStyle.copyWith(
        fontSize: 14,
      ),

      //Label
      labelLarge: baseTextStyle.copyWith(
        fontSize: 14,
      ),
      labelMedium: baseTextStyle.copyWith(
        fontSize: 12,
      ),
      labelSmall: baseTextStyle.copyWith(
        fontSize: 11,
      ),

      //Body
      bodyLarge: baseTextStyle.copyWith(
        fontSize: 16,
      ),
      bodyMedium: baseTextStyle.copyWith(
        fontSize: 14,
      ),
      bodySmall: baseTextStyle.copyWith(
        fontSize: 12,
      ),
    );
  }
}

''';

const typography = '''
export 'app_font_weight.dart';
export 'app_text_styles.dart';

''';

const theme = '''
export './app_colors.dart';
export './typography/typography.dart';
export './app_theme.dart';
''';
