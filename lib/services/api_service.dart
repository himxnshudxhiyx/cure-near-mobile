import 'dart:developer';

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
  Future<Response?> get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      log('*************** URL-> ***************\n$url');
      log('*************** Request-> ***************\n$queryParameters');
      final response = await _dio.get(url, queryParameters: queryParameters);
      log('*************** Response-> ***************\n$response');
      return response;
    } on DioException catch (e) {
      // Handle errors here
      log('GET request error: ${e.message}');
      return e.response;
    }
  }

  // POST request
  Future<Response?> post(String url, {Map<String, dynamic>? data}) async {
    try {
      log('*************** URL-> ***************\n$url');
      log('*************** Request-> ***************\n$data');
      final response = await _dio.post(url, data: data);
      log('*************** Response-> ***************\n$response');
      return response;
    } on DioException catch (e) {
      // Handle errors here
      log('POST request error: ${e.message}');
      return e.response;
    }
  }
}
