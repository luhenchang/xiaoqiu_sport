import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;

class RequestMock {
  static const String baseUrl = 'http://www.hupu.com';
  static Future<dynamic> get({String action, Map params}) async {
    return RequestMock.mock(action: action, params: params);
  }

  static Future<dynamic> post({String action, Map params}) async {
    return RequestMock.mock(action: action, params: params);
  }

  static Future<dynamic> mock({String action, Map params}) async {
    var responseStr = await rootBundle.loadString('mock/$action.json');
    var responseJson = json.decode(responseStr);
    return responseJson['data'];
  }

  static Dio createDio() {
    var options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 100000,
//      contentType: ContentType.json,
    );
    return Dio(options);
  }
}
