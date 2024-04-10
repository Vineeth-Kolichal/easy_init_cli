String themeContent = '''
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    textTheme: getTextTheme(isDark: false),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    textTheme: getTextTheme(isDark: true),
  );
}

TextTheme getTextTheme({required bool isDark}) {
  TextTheme lightTextTheme = const TextTheme();
  TextTheme darkTextTheme = const TextTheme();

  if (isDark) {
    return darkTextTheme;
  } else {
    return lightTextTheme;
  }
}

''';
String colorsContent = '''
import 'package:flutter/material.dart';

class AppColors {
  static const blackColor = Colors.black;
  static const whiteColor = Colors.white;
}

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
  CustomException.otherException(String msg) {
    message = msg;
  }
  CustomException.fromDioError(DioException dioError) {
    if (message == null) {
      switch (dioError.type) {
        case DioException.requestCancelled:
          message = "Request to API server was cancelled";
          break;
        case DioException.connectionTimeout:
          message = "Connection timeout with API server";
          break;
        case DioException.connectionError:
          message =
              "Connection to API server failed due to internet connection";
          break;
        case DioException.receiveTimeout:
          message = "Receive timeout in connection with API server";
          break;
        case DioException.badResponse:
          message = _handleError(dioError.response!.statusCode);
          break;
        case DioException.sendTimeout:
          message = "Send timeout in connection with API server";
          break;
        default:
          message = _handleDefaultError(dioError);
          break;
      }
    }
  }

  dynamic message;

  String? _handleDefaultError(DioException error) {
    try {
      final response = error.response?.data as Map?;
      if (response != null) {
        return "\${response["message"]}";
      }
      return error.message;
    } catch (_) {
      return error.message;
    }
  }

  Object _handleError(statusCode) {
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
 > Remove this file form root folder. 
 > Run 'easy init' command again''';

String apiEndpointContent = '''
class ApiEndpoints {
  /// change the [baseUrl] value as per your api
  static String baseUrl = "http://numbersapi.com/";
}

''';
