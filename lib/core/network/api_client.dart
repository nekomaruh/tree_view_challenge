import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'api_exception.dart';

class ApiClient<T> {
  final Dio _dio;

  ApiClient(String baseUrl) : _dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint("DIO REQUEST: ${options.uri}");
          // Handle equest
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint("DIO RESPONSE: ${response.data}");
          // Handle response
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          debugPrint("DIO ERROR: ${e.message}");
          // Handle errors
          String errorMessage = e.message ?? "Unknown Error";
          final int? statusCode = e.response?.statusCode;

          if (e.response != null) {
            // Errores de respuesta
            errorMessage = 'Error $statusCode: ${e.response?.statusMessage}';
          } else if (e.type == DioExceptionType.connectionTimeout) {
            errorMessage = 'Connection Timeout';
          } else if (e.type == DioExceptionType.receiveTimeout) {
            // Receive Timeout
            errorMessage = 'Receive Timeout';
          } else if (e.type == DioExceptionType.sendTimeout) {
            // Send Timeout
            errorMessage = 'SendTimeout';
          }

          // Launch ApiException
          return handler.reject(
            DioException(
              response: e.response,
              type: DioExceptionType.unknown,
              error: ApiException(errorMessage, statusCode: statusCode),
              requestOptions: e.requestOptions,
            ),
          );
        },
      ),
    );
  }

  Future<T> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response.data;
    } catch (e) {
      throw ApiException('Error calling GET: ${e.toString()}');
    }
  }
}
