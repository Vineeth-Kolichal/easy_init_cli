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
        return 'An error occured';
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

String apiEndpointContent = '''
class ApiEndpoints {
  /// change the [baseUrl] value as per your api
  static String baseUrl = "http://numbersapi.com";
}

''';

String networkClientContent = '''
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'network_exceptions.dart';

@lazySingleton
@injectable
class NetworkClient {
  final Dio _dio;
  NetworkClient(this._dio) {
    final authInterceptor = AuthInterceptor(_getToken);
    _dio.interceptors.add(authInterceptor);
  }

  //to get access token from other area like sockets
  Future<String?> get getAccessToken => _getToken();

  /// GET request with authoruzation by default.
  /// If you want to make an api call without token pass [requiresAuth] value as false
  Future<Response<T>> get<T>({
    required String path,
    dynamic data,
    dynamic queryParameters,
    Function(int, int)? onReceiveProgress,
    bool requiresAuth = true,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(extra: {'requiresAuth': requiresAuth}),
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      throw CustomException.fromDioException(e);
    } catch (e) {
      throw CustomException.otherException(e.toString());
    }
  }

  ///POST request with authoruzation by default.
  /// Ff you want to make an api call without token pass [requiresAuth] value as false
  Future<Response<T>> post<T>({
    required String path,
    dynamic data,
    Function(int, int)? onSendProgress,
    bool requiresAuth = true,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        options: Options(extra: {'requiresAuth': requiresAuth}),
        onSendProgress: onSendProgress,
      );
      return response;
    } on DioException catch (e) {
      throw CustomException.fromDioException(e);
    } catch (e) {
      throw CustomException.otherException(e.toString());
    }
  }

  /// PUT request with authoruzation by default.
  /// If you want to make an api call without token pass [requiresAuth] value as false
  Future<Response<T>> put<T>({
    required String path,
    dynamic data,
    dynamic queryParameters,
    bool requiresAuth = true,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(extra: {'requiresAuth': requiresAuth}),
      );
      return response;
    } on DioException catch (e) {
      throw CustomException.fromDioException(e);
    } catch (e) {
      throw CustomException.otherException(e.toString());
    }
  }

  /// PATCH request with authoruzation by default.
  /// If you want to make an api call without token pass [requiresAuth] value as false
  Future<Response<T>> patch<T>({
    required String path,
    dynamic data,
    bool requiresAuth = true,
  }) async {
    try {
      final response = await _dio.patch<T>(
        path,
        data: data,
        options: Options(extra: {'requiresAuth': requiresAuth}),
      );
      return response;
    } on DioException catch (e) {
      throw CustomException.fromDioException(e);
    } catch (e) {
      throw CustomException.otherException(e.toString());
    }
  }

  /// DELETE request with authoruzation by default.
  /// If you want to make an api call without token pass [requiresAuth] value as false
  Future<Response<T>> delete<T>({
    required String path,
    dynamic data,
    bool requiresAuth = true,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        options: Options(extra: {'requiresAuth': requiresAuth}),
      );
      return response;
    } on DioException catch (e) {
      throw CustomException.fromDioException(e);
    } catch (e) {
      throw CustomException.otherException(e.toString());
    }
  }

  Future<Response<dynamic>> download({
    required String url,
    required targetPath,
    bool requiresAuth = false,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      return await _dio.download(
        url,
        targetPath,
        options: Options(extra: {'requiresAuth': requiresAuth}),
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw CustomException.fromDioException(e);
    } catch (e) {
      throw CustomException.otherException(e.toString());
    }
  }

  //Function to get token and token refresh
  Future<String?> _getToken() async {
    //Example token refresh logic
    //----------------------------------------------
    // final tokens = tokenManager.currentTokens;

    // // if access token is near to expiry time
    // if (tokens?.isAccessTokenExpired == true) {
    //   try {
    //     String? refreshToken = tokens?.refreshToken;

    //     //Accessing new refresh and access token from api using existing refresh token
    //     final Response response = await post(
    //       requiresAuth: false,
    //       path: ApiEndpoints.tokenRefresh,
    //       data: {"refreshToken": refreshToken},
    //     );

    //     //Retrive new access and refresh token from api response
    //     final newAccessToken = response.data["token"] as String;
    //     final newRefreshToken = response.data["refreshToken"] as String;
    //     final expiryTime = DateTime.now().toUtc().add(Duration(minutes: 55));// 55 minute is a sample duration. Change it based on your token expiry time

    //     final newTokens = AuthTokens(
    //         accessToken: newAccessToken,
    //         refreshToken: newRefreshToken,
    //         expiryTime: expiryTime);
    //     await tokenManager.saveTokens(newTokens);
    //     //return new access token
    //     return newAccessToken;
    //   } catch (e) {
    //     return null;
    //   }
    // } else {
    //   return tokens?.accessToken;
    // }
    //--------------------------------------------

    //The above given example code is using token manager
    //If you want to generate token manager run the command 'easy create services' and select Token Manager from the list
    //To inject token manager to network client using dependency injection modify NetworkClient like following

    //class NetworkClient {
    // final Dio _dio;
    // final TokenManager tokenManager;
    // NetworkClient(this._dio, this.tokenManager) {
    //   final authInterceptor = AuthInterceptor(_getToken);
    //   _dio.interceptors.add(authInterceptor);
    // }

    String? accesToken;

    return accesToken;
  }
}

class AuthInterceptor extends Interceptor {
  final Future<String?> Function() _getToken;

  AuthInterceptor(this._getToken);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Check if the request explicitly needs a token or if it's generally required
    // You might add a custom `extra` option to `RequestOptions` to control this.
    // For simplicity, let's say all requests need a token unless specified otherwise.

    if (options.extra['requiresAuth'] ?? true) {
      // Default to true if not specified
      final token = await _getToken();
      if (token != null && token.isNotEmpty) {
        options.headers["authorization"] = "Bearer \$token";
      }
    }
    super.onRequest(options, handler);
  }

  // You can also add onResponse and onError methods if needed
}

''';
