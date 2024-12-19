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

String spaceContent = '''
import 'package:flutter/material.dart';

class Space {
  static SizedBox x(double width) => SizedBox(
        width: width,
      );
  static SizedBox y(double height) => SizedBox(
        height: height,
      );
}
''';

String loadingContent = '''
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


''';

String responsiveContent = '''
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
''';
String networkExceptionContent = '''
import 'package:dio/dio.dart';

class CustomException implements Exception {
  dynamic message;
  int? statusCode;
  CustomException.otherException(String msg) {
    message = msg;
  }
  CustomException.fromDioException(DioException dioException) {
    if (message == null) {
      switch (dioException.type) {
        case DioExceptionType.cancel:
          message = "Request to API server was cancelled";
          statusCode = dioException.response?.statusCode;
          break;
        case DioExceptionType.connectionTimeout:
          message = "Connection timeout with API server!";
          statusCode = dioException.response?.statusCode;
          break;
        case DioExceptionType.connectionError:
          message = "Connection to API server failed!";
          statusCode = dioException.response?.statusCode;
          break;
        case DioExceptionType.receiveTimeout:
          message = "Receive timeout in connection with API server";
          statusCode = dioException.response?.statusCode;
          break;
        case DioExceptionType.badResponse:
          message = _handleBadResponse(dioException);
          statusCode = dioException.response?.statusCode;
          break;
        case DioExceptionType.sendTimeout:
          message = "Send timeout in connection with API server";
          statusCode = dioException.response?.statusCode;
          break;
        default:
          message = _handleBadResponse(dioException);
          statusCode = dioException.response?.statusCode;
          break;
      }
    }
  }

  String? _handleBadResponse(DioException exception) {
    try {
      final response = exception.response?.data as Map?;
      if (response != null && response['message'] != null) {
        return "\${response["message"]}";
      } else {
        return _handleError(exception.response!.statusCode);
      }
    } catch (_) {
      return _handleError(exception.response?.statusCode);
    }
  }

  String _handleError(statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized request';
      case 404:
        return 'The requested resource was not found';
      case 500:
        return 'Internal server error';
      default:
        return 'Something went wrong';
    }
  }

  @override
  String toString() => message.toString();
}


''';

const String initWarning = '''
Project initialized using easy_init_cli.

ALERT!!! Do not delete this file !!!
if you delete this file then some commands won't work properly


If you wanted to change architecture pattern;
 > Remove all folders and files from lib folder.
 > Remove this file from root folder. 
 > Run 'easy init' command again''';

String apiEndpointContent = '''
class ApiEndpoints {
  /// change the [baseUrl] value as per your api
  static String baseUrl = "http://numbersapi.com";
}

''';
String loginScreenContent = '''
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
''';

String signupScreenContent = '''
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
''';

String forgotPasswordScreenContent = '''
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
''';

String otpScreenContent = '''
import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
''';

String networkClientContent = '''
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../api_endpoints/api_endpoints.dart';
import 'network_exceptions.dart';

/// If you have to pass token with api requests then use,[getWithToken],[postWithToken],
/// [putWithToken],[patchWithToken],[deleteWithToken], methods, if you are not using any token then
/// you can use [getWithoutToken] and [postWithoutToken] methods.
/// You can implement Put,Patch,delete without token  methods as per your needs.
/// You can modify this code as per your needs.

@lazySingleton
@injectable
class NetworkClient {
  final Dio _dio;
  NetworkClient(this._dio);

  final Dio _dioNoToken = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));

  //to get access token from other area like sockets
  Future<String?> get getAccessToken => _getToken();

  //GET request with token
  Future<dynamic> getWithToken(
      {required String path, dynamic data, dynamic queryParameters}) async {
    try {
      final token = await _getToken();
      _dio.options.headers = {
        "Content-Type": "application/json",
        "authorization": "Bearer \$token"
      };
      final response =
          await _dio.get(path, data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw CustomException.fromDioException(e);
    }
  }

  //POST request with token
  Future<dynamic> postWithToken({required String path, dynamic data}) async {
    try {
      final token = await _getToken();
      _dio.options.headers = {
        "Content-Type": "application/json",
        "authorization": "Bearer \$token"
      };
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      throw CustomException.fromDioException(e);
    } catch (e) {
      throw CustomException.otherException(e.toString());
    }
  }

  //PUT request with token
  Future<dynamic> putWithToken({required String path, dynamic data}) async {
    try {
      final token = await _getToken();
      _dio.options.headers = {
        "Content-Type": "application/json",
        "authorization": "Bearer \$token"
      };
      final response = await _dio.put(path, data: data);
      return response;
    } on DioException catch (e) {
      throw CustomException.fromDioException(e);
    } catch (e) {
      throw CustomException.otherException(e.toString());
    }
  }

  //PATCH request with token
  Future<dynamic> patchWithToken({required String path, dynamic data}) async {
    try {
      final token = await _getToken();
      _dio.options.headers = {
        "Content-Type": "application/json",
        "authorization": "Bearer \$token"
      };
      final response = await _dio.patch(path, data: data);
      return response;
    } on DioException catch (e) {
      throw CustomException.fromDioException(e);
    } catch (e) {
      throw CustomException.otherException(e.toString());
    }
  }

  //DELETE request with token
  Future<dynamic> deleteWithToken({required String path, dynamic data}) async {
    try {
      final token = await _getToken();
      _dio.options.headers = {
        "Content-Type": "application/json",
        "authorization": "Bearer \$token"
      };
      final response = await _dio.delete(path, data: data);
      return response;
    } on DioException catch (e) {
      throw CustomException.fromDioException(e);
    } catch (e) {
      throw CustomException.otherException(e.toString());
    }
  }

  //GET request without token
  Future<dynamic> getWithoutToken(
      {required String path, dynamic data, dynamic queryParameters}) async {
    _dioNoToken.options.headers = {
      "Content-Type": "application/json",
    };
    try {
      final response = await _dioNoToken.get(path,
          data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw CustomException.fromDioException(e);
    } catch (e) {
      throw CustomException.otherException(e.toString());
    }
  }

  //POST request without token
  Future<dynamic> postWithoutToken({required String path, dynamic data}) async {
    _dioNoToken.options.headers = {
      "Content-Type": "application/json",
    };
    try {
      final response = await _dioNoToken.post(path, data: data);
      return response;
    } on DioException catch (e) {
      throw CustomException.fromDioException(e);
    } catch (e) {
      throw CustomException.otherException(e.toString());
    }
  }

  //Function to get token
  Future<String?> _getToken() async {
    //TODO: update the following commented code as per your token refresh api request and response

    // DateTime currentTime = DateTime.now();
    // DateTime? accessTokenTime =
    //     SharedPrefsServices.instance.getAccessTokenTime();
    // //finding the time remining time to expiry of access token
    // Duration difference = currentTime.difference(
    //   accessTokenTime!,
    // );
    // //TODO: change the time difference based on the access token expiry time
    // // if access token is near to expiry time
    // if (difference.inMinutes > 55) {
    //   try {
    //     String? refreshToken = SharedPrefsServices.instance.getRefreshToken();

    //     //Accessing new refresh and access token from api using existing refresh token
    //     final Response response = await _dio.post(
    //       ApiEndpoints.tokenRefresh,
    //       data: {"refreshToken": refreshToken},
    //     );

    //     //Retrive new access and refresh token from api response
    //     final newAccessToken = response.data["token"] as String;
    //     final newRefreshToken = response.data["refreshToken"] as String;

    //     //Store new refresh and access token to shared preferences
    //     await SharedPrefsServices.instance.setAccessToken(newAccessToken);
    //     await SharedPrefsServices.instance.setRefreshToken(newRefreshToken);

    //     //return new access token
    //     return newAccessToken;
    //   } catch (e) {
    //     rethrow;
    //   }
    // } else {
    //   return SharedPrefsServices.instance.getAccessToken();
    // }

    return "access token";
  }
}

''';

const navigationExtContent = '''
import 'package:flutter/material.dart';


extension AppNavigationExt on BuildContext {

  void push(Widget nextScreen) {
    Navigator.of(this).push(MaterialPageRoute(
      builder: (context) => nextScreen,
    ));
  }

  void pushReplacement(Widget nextScreen) {
    Navigator.of(this).pushReplacement(MaterialPageRoute(
      builder: (context) => nextScreen,
    ));
  }

  void pushAndRemoveUntil(Widget nextScreen) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ),
      (route) => false,
    );
  }

  void popScreen() {
    Navigator.of(this).pop();
  }
}


''';

const dateExtContent = '''
import 'package:intl/intl.dart';

extension DateExt on DateTime {
  ///[hhMMa] will format DateTime to String in 'hh:mm:a'
  ///
  ///----------
  ///```
  /// //example
  ///final time=DateTime.now().hhMMa;
  ///print(time);//10:20 am
  ///```
  String get hhMMa => DateFormat('hh:mm a').format(this);

  ///[dMMMyOrTY] will convert DateTime to String in '12 May 2024' format
  ///or 'Today' or 'Yesterday' based on the date
  ///
  ///----------
  ///```
  /// //example
  ///final converted=DateTime.now().dMMMyOrTY;
  ///print(converted);//Today
  ///```
  String get dMMMyOrTY {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final compDt = DateTime(year, month, day);
    final difference = today.difference(compDt).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else {
      return DateFormat('d MMM, y').format(this);
    }
  }

  ///[yyyyMmDdWithDash] will convert DateTime to String in "2024-05-05" format
  ///
  ///----------
  ///```
  /// //example
  ///final dateString=DateTime.now().yyyyMmDdWithDash;
  ///print(dateString);//2024-08-05
  ///```
  String get yyyyMmDdWithDash => DateFormat('yyyy-MM-dd').format(this);

  ///[yyyMmDdWithSlash] will convert DateTime to String in "2024/05/05" format
  ///
  ///----------
  ///```
  /// //example
  ///final dateString=DateTime.now().yyyyMmDdWithSlash;
  ///print(dateString);//2024/08/05
  ///```
  String get yyyMmDdWithSlash => DateFormat('yyyy/MM/dd').format(this);

  ///[formatAsDdMMMyyy] will convert DateTime to String in "10 Apr, 2024" format
  ///
  ///----------
  ///```
  /// //example
  ///final dateString=DateTime.now().formatAsDdMMMyyy;
  ///print(dateString);// 10 Apr, 2024
  ///```
  String get formatAsDdMMMyyy => DateFormat('d MMM, yyyy').format(this);
}

''';

const stringExtContent = '''

extension StringExt on String {
  /// [capitalize] will make first letter capital of a string
  /// ```
  ///  //example
  /// final str="hello world"
  /// final strConverted=str.capitalize
  /// print(strConverted);//Hello world
  /// ```
  String get capitalize =>
      isNotEmpty ? "\${this[0].toUpperCase()}\${substring(1)}" : "";
}
''';

const themeExtContent = '''
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// [TextThemeExt] - A custom extension on `BuildContext` to access
/// TextStyle easily with build context
extension TextThemeExt on BuildContext {
  TextTheme textTheme() => Theme.of(this).textTheme;

  TextStyle displayLarge(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .displayLarge!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle displayMedium(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .displayMedium!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle displaySmall(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .displaySmall!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle headlineLarge(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .headlineLarge!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle headlineMedium(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .headlineMedium!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle headlineSmall(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .headlineSmall!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle titleLarge(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .titleLarge!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle titleMedium(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .titleMedium!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle titleSmall(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .titleSmall!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle bodyLarge(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .bodyLarge!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle bodyMedium(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .bodyMedium!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle bodySmall(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .bodySmall!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle labelSmall(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .labelSmall!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle labelMedium(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .labelMedium!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle labelLarge(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .labelLarge!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);
}


extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  ///
  ///[setThemeBasedColor] accepts two colors as parameters [darkThemeColor]
  ///and [lightThemeColor], if current app theme is Dark then [darkThemeColor]
  ///will return else [lightThemeColor] will return.
  ///```
  /// //Example
  /// ----------
  /// Container(
  ///   height:100,
  ///   width:100,
  ///   color:context.setThemeBasedColor(
  ///     darkThemeColor:Colors.white,
  ///     lightThemeColor:Colors.black,
  ///    ),
  ///   ),
  ///  // The color of container will be black if theme is Dark else white.
  /// ```
  Color? setThemeBasedColor(
      {required Color? darkThemeColor, required Color? lightThemeColor}) {
    bool isDarkTheme = Theme.of(this).brightness == Brightness.dark;
    if (isDarkTheme) {
      return darkThemeColor;
    } else {
      return lightThemeColor;
    }
  }

  AppColors? get appColors => Theme.of(this).extension<AppColors>();
}


''';

const numberExtContent = '''
import 'package:flutter/material.dart';

extension SpaceExt on num {
  SizedBox get verticalSpace => SizedBox(
        height: toDouble(),
      );
  SizedBox get horizontalSpace => SizedBox(
        width: toDouble(),
      );
}


''';

const extensionsContent = '''
export './date_ext.dart';
export './string_ext.dart';
export 'theme_ext.dart';
export './app_navigation_ext.dart';
export './number_ext.dart';
''';

const fcmServicesContent = '''
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FcmServices {
  //TODO:complete notification setup
  ///
  ///### init notification:
  /// call initNotifications() method to initialize notifications
  /// ```
  /// Example:
  /// Future<void> main()async{
  ///   await FcmServices.instance.initNotifications();
  ///   runApp(MyApp());
  /// }
  /// ```
  ///
  ///  Warning:
  /// ----------------
  ///  - This code is just basic setup, you may need to add more
  ///    functionalities as per your requirement.
  ///  - FCM needs some setups in platform specific folders. You should do that
  ///    before using this code.
  ///  - The project should be connected with a firebase project and Cloud messaging
  ///    should be enabled in firebase.
  ///

  static FcmServices instance = FcmServices._internal();
  factory FcmServices() {
    return instance;
  }

  final firebaseMessaging = FirebaseMessaging.instance;
  final locaNotification = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();
    await _initFcm();
    await _initLocalNotifications();
  }

  Future<void> _initLocalNotifications() async {
    //Android settings
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings(
            '@mipmap/ic_launcher'); //TODO: change notification icon
    //IOS settings
    DarwinInitializationSettings darwinInitializationSettings =
        const DarwinInitializationSettings();
    //Initialization of local notification settings
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );

    locaNotification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final message = RemoteMessage.fromMap(jsonDecode(details.payload!));
        _handleMessage(message);
      },
    );
  }

  Future<void> _initFcm() async {
    //Sets the presentation options for Apple notifications when received in the foreground.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    //Showing notification when app in forground
    FirebaseMessaging.onMessage.listen(_showForgroundNotification);

    //Handle notification when app is opened from terminated state
    FirebaseMessaging.instance.getInitialMessage().then(_handleMessage);

    //Stream of event when open app from background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  ///To get FCM token for the firebase push notifications
  Future<String?> getFcmToken() async {
    final token = await firebaseMessaging.getToken();
    return token;
  }

  ///Handle messages
  void _handleMessage(RemoteMessage? message) {
    if (message != null) {
      //TODO: write code for handle message - Navigate to specific screen if needed
    }
  }

  ///handle forground message with local notifications
  Future<void> _showForgroundNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    locaNotification.show(
      message.hashCode,
      '\${message.notification?.title}',
      '\${message.notification?.body}',
      notificationDetails,
      payload: jsonEncode(message.toMap()),
    );
  }

  FcmServices._internal();
}

''';

const sharedPrefsServices = '''
import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SharedPrefsServices {
  ///TODO: modify the code as per the need
  ///
  /// ### initialize SharedPreferences
  /// ------------------------
  /// call initialize() method to initialize SharedPreferences instance
  ///
  /// ```
  /// Example:
  /// Future<void> main()async{
  ///   await SharedPrefsServices.instance.initialize();
  ///   runApp(MyApp());
  /// }
  /// ```
  ///

  late SharedPreferences sharedPreferences;
  static SharedPrefsServices instance = SharedPrefsServices._internal();

  factory SharedPrefsServices() {
    return instance;
  }

  Future<void> initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Set methods>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  Future<bool> setAccessToken(String token) async {
    return await sharedPreferences.setString(
          StorageKeys.accessToken,
          token,
        ) &&
        await sharedPreferences.setString(
          StorageKeys.accessTokenTime,
          DateTime.now().toString(),
        );
  }

  Future<bool> setRefreshToken(String token) async {
    return await sharedPreferences.setString(
          StorageKeys.refreshToken,
          token,
        ) &&
        await sharedPreferences.setString(
          StorageKeys.refreshTokenTime,
          DateTime.now().toString(),
        );
  }

  /// Get methods--------------------------------------
  String? getAccessToken() {
    return sharedPreferences.getString(StorageKeys.accessToken);
  }

  String? getRefreshToken() {
    return sharedPreferences.getString(StorageKeys.refreshToken);
  }

  DateTime? getAccessTokenTime() {
    final time = sharedPreferences.getString(StorageKeys.accessTokenTime);
    if (time != null) {
      return DateTime.parse(time);
    } else {
      return null;
    }
  }

  bool isTokenAvailable() {
    final access = getAccessToken();

    return (access != null);
  }

  Future<void> clearAll() async {
    await sharedPreferences.clear();
  }

  SharedPrefsServices._internal();
}

class StorageKeys {
  static const accessToken = "accessToken";
  static const refreshToken = "refreshToken";
  static const accessTokenTime = "accessTokenTime";
  static const refreshTokenTime = "refreshTokenTime";
}


''';
