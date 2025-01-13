import 'dart:developer';

import 'package:cure_near/services/logger_service.dart';
import 'package:cure_near/services/shared_preferences.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.baseUrl = 'https://cure-near-backend.vercel.app/api/';
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  // GET request
  Future<Response?> get(String url, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? data, bool? auth}) async {
    try {
      var startTime = DateTime.now().millisecondsSinceEpoch;
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        data: data,
        options: (auth == true)
            ? Options(
                headers: {
                  'Authorization': SharedPrefsHelper().getString('authToken') ?? '',
                },
              )
            : null,
      );
      var endTime = DateTime.now().millisecondsSinceEpoch;
      Logger.logAPIResponse(methodName: 'Get', webLink: url, request: queryParameters, response: response, duration: endTime - startTime);
      return response;
    } on DioException catch (e) {
      Logger.logAPIResponse(methodName: 'Get', webLink: url, request: queryParameters, response: e.error, duration: 'null');
      // Handle errors here
      log('GET request error: ${e.message}');
      return e.response;
    }
  }

  // POST request
  Future<Response?> post(String url, {Map<String, dynamic>? data, bool? auth}) async {
    try {
      var startTime = DateTime.now().millisecondsSinceEpoch;
      final response = await _dio.post(
        url,
        data: data,
        options: (auth == true)
            ? Options(
                headers: {
                  'Authorization': SharedPrefsHelper().getString('authToken') ?? '',
                },
              )
            : null,
      );
      var endTime = DateTime.now().millisecondsSinceEpoch;
      Logger.logAPIResponse(methodName: 'Post', webLink: url, request: data, response: response, duration: endTime - startTime);
      return response;
    } on DioException catch (e) {
      Logger.logAPIResponse(methodName: 'Post', webLink: url, request: data, response: e.error, duration: 'null');
      // Handle errors here
      log('POST request error: ${e.message}');
      return e.response;
    }
  }
}
