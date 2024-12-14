import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';

extension LoggerExtension on Object {
  void logObject() {
    if (kDebugMode) {
      log('****************** Logger *****************\n${toString()}\n*******************************************');
    }
  }
}

class Logger {
  // Log any object with a specific format
  static logObject({required Object object}) {
    if (kDebugMode) {
      log('****************** Logger *****************\n${object.toString()}\n*******************************************');
    }
  }

  // Log class name specifically
  static logClass({required Object className}) {
    if (kDebugMode) {
      log('****************** Class Name *****************\n${className.toString()}\n***********************************************');
    }
  }

  // Log JSON objects with proper indentation
  static logJson({required Object json}) {
    if (kDebugMode) {
      log(const JsonEncoder.withIndent(' ').convert(json));
    }
  }

  // Log API responses, including method name, URL, request, and response
  static logAPIResponse({
    bool isGoApi = false,
    required String methodName,
    required String webLink,
    required Map? request,
    required Object? response,
  }) {
    if (kDebugMode) {
      log('\n\n**************************URL**************************\n\n$webLink\n\n');
      if (methodName == 'Get') {
        log("\n\n**************************RESPONSE**************************\n\n${const JsonEncoder.withIndent('  ').convert(jsonDecode(response.toString()))}\n\n");
      } else {
        log("\n\n**************************REQUESTS**************************\n\n${const JsonEncoder.withIndent(' ').convert(request)}\n\n");
        log("\n\n**************************RESPONSE**************************\n\n${const JsonEncoder.withIndent('  ').convert(jsonDecode(response.toString()))}\n\n");
      }
    }
  }
}