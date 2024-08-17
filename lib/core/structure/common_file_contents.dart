String themeContent = '''
import 'package:flutter/material.dart';

import 'theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    //Text theme
    textTheme: uiTextTheme,
    //Color extension
    extensions: const <ThemeExtension<dynamic>>[AppColors.light],
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    //Text theme
    textTheme: uiTextTheme,
    //color extension
    extensions: const <ThemeExtension<dynamic>>[AppColors.light],
  );

  //Text theme
  static final uiTextTheme = TextTheme(
    displayLarge: UITextStyle.headline1,
    displayMedium: UITextStyle.headline2,
    displaySmall: UITextStyle.headline3,
    headlineMedium: UITextStyle.headline4,
    headlineSmall: UITextStyle.headline5,
    titleLarge: UITextStyle.headline6,
    titleMedium: UITextStyle.subtitle1,
    titleSmall: UITextStyle.subtitle2,
    bodyLarge: UITextStyle.bodyText1,
    bodyMedium: UITextStyle.bodyText2,
    labelLarge: UITextStyle.button,
    bodySmall: UITextStyle.caption,
    labelSmall: UITextStyle.overline,
  );
}

''';
String colorsContent = '''
import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color black = Colors.black;
  final Color white = Colors.white;
  final Color? primaryColor;
  final Color? secondaryColor;

  const AppColors({
    this.primaryColor,
    this.secondaryColor,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primaryColor,
    Color? secondaryColor,
  }) {
    return AppColors(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
      covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
    );
  }

  static const AppColors light = AppColors(
    primaryColor: Colors.purple,
  );
  static const AppColors dark = AppColors(
    primaryColor: Colors.green,
  );
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

import 'app_font_weight.dart';

/// UI Text Style Definitions
abstract class UITextStyle {
  static const _baseTextStyle = TextStyle(
    fontWeight: AppFontWeight.regular,
    // fontFamily: 'Poppins',
    decoration: TextDecoration.none,
    textBaseline: TextBaseline.alphabetic,
  );

  /// Display 2 Text Style
  static final TextStyle display2 = _baseTextStyle.copyWith(
    fontSize: 57,
    fontWeight: AppFontWeight.bold,
    height: 1.12,
    letterSpacing: -0.25,
  );

  /// Display 3 Text Style
  static final TextStyle display3 = _baseTextStyle.copyWith(
    fontSize: 45,
    fontWeight: AppFontWeight.bold,
    height: 1.15,
  );

  /// Headline 1 Text Style
  static final TextStyle headline1 = _baseTextStyle.copyWith(
    fontSize: 36,
    fontWeight: AppFontWeight.bold,
    height: 1.22,
  );

  /// Headline 2 Text Style
  static final TextStyle headline2 = _baseTextStyle.copyWith(
    fontSize: 32,
    fontWeight: AppFontWeight.bold,
    height: 1.25,
  );

  /// Headline 3 Text Style
  static final TextStyle headline3 = _baseTextStyle.copyWith(
    fontSize: 28,
    fontWeight: AppFontWeight.semiBold,
    height: 1.28,
  );

  /// Headline 4 Text Style
  static final TextStyle headline4 = _baseTextStyle.copyWith(
    fontSize: 24,
    fontWeight: AppFontWeight.semiBold,
    height: 1.33,
  );

  /// Headline 5 Text Style
  static final TextStyle headline5 = _baseTextStyle.copyWith(
    fontSize: 22,
    fontWeight: AppFontWeight.regular,
    height: 1.27,
  );

  /// Headline 6 Text Style
  static final TextStyle headline6 = _baseTextStyle.copyWith(
    fontSize: 18,
    fontWeight: AppFontWeight.semiBold,
    height: 1.33,
  );

  /// Subtitle 1 Text Style
  static final TextStyle subtitle1 = _baseTextStyle.copyWith(
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.1,
  );

  /// Subtitle 2 Text Style
  static final TextStyle subtitle2 = _baseTextStyle.copyWith(
    fontSize: 14,
    height: 1.42,
    letterSpacing: 0.1,
  );

  /// Body Text 1 Text Style
  static final TextStyle bodyText1 = _baseTextStyle.copyWith(
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.5,
  );

  /// Body Text 2 Text Style (the default)
  static final TextStyle bodyText2 = _baseTextStyle.copyWith(
    fontSize: 14,
    height: 1.42,
    letterSpacing: 0.25,
  );

  /// Caption Text Style
  static final TextStyle caption = _baseTextStyle.copyWith(
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0.4,
  );

  /// Button Text Style
  static final TextStyle button = _baseTextStyle.copyWith(
    fontSize: 16,
    height: 1.42,
    letterSpacing: 0.1,
  );

  /// Overline Text Style
  static final TextStyle overline = _baseTextStyle.copyWith(
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0.5,
  );

  /// Label Small Text Style
  static final TextStyle labelSmall = _baseTextStyle.copyWith(
    fontSize: 11,
    height: 1.45,
    letterSpacing: 0.5,
  );
}

''';

const typography = '''
export 'app_font_weight.dart';
export 'ui_text_style.dart';

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
            color: appColors?.black.withOpacity(0.3),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                height: 70,
                decoration: BoxDecoration(
                  color: context.setThemeBasedColor(
                    darkThemeColor: appColors?.black,
                    lightThemeColor: appColors?.white,
                  ),
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

  ///If you are storing token in SharedPreferences or any other storage,
  ///then write code for retrieving token and assign to [token]
  String? token;
  //GET request with token
  Future<dynamic> getWithToken(
      {required String path, dynamic data, dynamic queryParameters}) async {
    _dio.options.headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer \$token"
    };
    try {
      final response =
          await _dio.get(path, data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw CustomException.fromDioException(e);
    }
  }

  //POST request with token
  Future<dynamic> postWithToken({required String path, dynamic data}) async {
    _dio.options.headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer \$token"
    };
    try {
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
    _dio.options.headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer \$token"
    };
    try {
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
    _dio.options.headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer \$token"
    };
    try {
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
    _dio.options.headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer \$token"
    };
    try {
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
    _dio.options.headers = {
      "Content-Type": "application/json",
    };
    try {
      final response =
          await _dio.get(path, data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw CustomException.fromDioException(e);
    } catch (e) {
      throw CustomException.otherException(e.toString());
    }
  }

  //POST request without token
  Future<dynamic> postWithoutToken({required String path, dynamic data}) async {
    _dio.options.headers = {
      "Content-Type": "application/json",
    };
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      throw CustomException.fromDioException(e);
    } catch (e) {
      throw CustomException.otherException(e.toString());
    }
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

const fcmHelperContent = '''
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FcmHelper {
  //TODO:!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ///  init notification:
  /// call initNotifications() method to initialize notifications
  /// ```
  /// Example:
  /// Future<void> main()async{
  ///   await initNotifications();
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

  static FcmHelper instance = FcmHelper._internal();
  factory FcmHelper() {
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
    final DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
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

  FcmHelper._internal();
}
''';

const sharedPrefsHelper = '''
import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SharedPrefsHelper {
  ///TODO: modify the code as per the need
  ///<<<<<<<<<<<<<<<<TODO>>>>>>>>>>>>>>>>>>>>>>
  /// //init notification
  /// call initialize() method to initialize SharedPreferences instance
  /// ```
  /// Example:
  /// Future<void> main()async{
  ///   await SharedPrefsHelper.instance.initialize();
  ///   runApp(MyApp());
  /// }
  /// ```
  /// 
  

  late SharedPreferences sharedPreferences;
  static SharedPrefsHelper instance = SharedPrefsHelper._internal();

  factory SharedPrefsHelper() {
    return instance;
  }

  Future<void> initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> setAccessToken(String token) async {
    return await sharedPreferences.setString(StorageKeys.accessToken, token);
  }

  String? getAccessToken() {
    return sharedPreferences.getString(StorageKeys.accessToken);
  }

  bool isTokenAvailable() {
    final access = getAccessToken();

    return (access != null);
  }

  Future<void> clearAll() async {
    await sharedPreferences.clear();
  }

  SharedPrefsHelper._internal();
}

class StorageKeys {
  static const accessToken = "accessToken";
}


''';
