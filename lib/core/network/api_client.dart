import 'package:dio/dio.dart';

import '../constants/network_constants.dart';
import '../errors/app_exception.dart';

class ApiClient {
  ApiClient({Dio? dio, String baseUrl = ''}) : _dio = dio ?? _createDio(baseUrl);

  final Dio _dio;

  static Dio _createDio(String baseUrl) {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: NetworkConstants.connectTimeout,
        sendTimeout: NetworkConstants.sendTimeout,
        receiveTimeout: NetworkConstants.receiveTimeout,
        headers: {Headers.acceptHeader: Headers.jsonContentType},
      ),
    );
  }

  Future<Map<String, dynamic>> getJson(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _send(
      () => _dio.get<Object?>(path, queryParameters: queryParameters),
    );
  }

  Future<Map<String, dynamic>> postJson(
    String path, {
    Map<String, dynamic>? data,
  }) {
    return _send(() => _dio.post<Object?>(path, data: data));
  }

  Future<Map<String, dynamic>> _send(
    Future<Response<Object?>> Function() request,
  ) async {
    try {
      final response = await request();
      final body = response.data;

      if (body is Map<String, dynamic>) {
        return body;
      }

      throw ApiException(
        message: 'The server sent an unexpected response.',
        statusCode: response.statusCode,
      );
    } on DioException catch (error) {
      throw _mapDioException(error);
    }
  }

     static AppException _mapDioException(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.connectionError =>
        NetworkException(cause: error),
      DioExceptionType.badResponse => ApiException(
          statusCode: error.response?.statusCode,
          cause: error,
        ),
      DioExceptionType.badCertificate ||
      DioExceptionType.cancel ||
      DioExceptionType.transformTimeout ||
      DioExceptionType.unknown =>
        UnknownException(cause: error),
    };
  }
}