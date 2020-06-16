import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:xiaoqiu_sport/utils/app_manager.dart';
import 'package:http/http.dart' as http;
import 'Code.dart';
import 'package:connectivity/connectivity.dart';

Map<String, String> optHeader = {
  "version": "1.0.0",
  'Accept': 'application/json, text/plain, */*',
  'Accept-Encoding': 'gzip, deflate, br',
  'Accept-Language': 'zh-CN,zh;q=0.9',
  'Connection': 'keep-alive',
  'Content-Type': 'application/json',
  'User-Agent':
      'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
};

BaseOptions options = BaseOptions(
  //请求基地址,可以包含子路径
//  baseUrl: ApiService.sports_base_url,
  //连接服务器超时时间，单位是毫秒.
  connectTimeout: 10000,
  //响应流上前后两次接受到数据的间隔，单位为毫秒。
  receiveTimeout: 15000,
  //Http请求头.
  headers: optHeader,
  //请求的Content-Type，默认值是[ContentType.json].
  // 也可以用ContentType.parse("application/x-www-form-urlencoded")
  // contentType: ContentType.json,
  //表示期望以那种格式(方式)接受响应数据。接受四种类型
  // `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
  // responseType: ResponseType.json,
);

var dio = Dio(options);

class NetUtils {
  /*
   * get请求
   */
  static Future get(String url, [Map<String, dynamic> params]) async {
    var response;
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    var dir = new Directory("$documentsPath/cookies");
    await dir.create();
    dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));
    dio.interceptors.add(LogInterceptor(responseBody: true));
    try {
      if (params != null) {
        response = await dio.get(url, queryParameters: params);
      } else {
        response = await dio.get(url);
      }
      if (response.data is String){
        Map<String, dynamic> jsonData = {};
        jsonData = json.decode(response.data);
        return jsonData;
      }
      return response.data;
    } on DioError catch (e) {
      formatError(e);
      return {'code': -1, 'message': "网络连接超时，请稍后重试"};
    }
  }

  /*
   * post请求
   */
  static Future post(String url, dynamic params) async {

    // Connectivity connectivity = Connectivity();
    // ConnectivityResult connectivityResult = await connectivity.checkConnectivity();
    // if (connectivityResult == ConnectivityResult.none) {
    //   return {'code': Code.NETWORK_ERROR, 'message': "连接失败，请检查你的网络设置"};
    // }

    // Directory documentsDir = await getApplicationDocumentsDirectory();
    // String documentsPath = documentsDir.path;
    // var dir = new Directory("$documentsPath/cookies");
    // await dir.create();
    // dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));
    dio.interceptors.add(LogInterceptor(responseBody: true));

    try {
      FormData formData = FormData.fromMap(params);
      var response = await dio.post(url, data: formData);
      if (response.data is String){
        print("响应数据类型String");
        Map<String, dynamic> jsonData = {};
        jsonData = json.decode(response.data);
        return jsonData;
      }
      return response.data;
    } on DioError catch (e) {
      formatError(e);
      return {'code': Code.NETWORK_TIMEOUT, 'message': "网络连接超时，请稍后重试"};
    }
  }

  static downloadFile(urlPath, savePath) async {
    Response response;

    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    var dir = new Directory("$documentsPath/cookies");
    await dir.create();
    dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));
    dio.interceptors.add(LogInterceptor(responseBody: true));

    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        //进度
        print("$count $total");
      });
      print('downloadFile success---------${response.data}');
    } on DioError catch (e) {
      print('downloadFile error---------$e');
      formatError(e);
    }
    return response.data;
  }

  static getData(String url,
      {Function success, Function fail, Function complete}) async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return {'code': Code.NETWORK_ERROR, 'message': "连接失败，请检查你的网络设置"};
    }
    try {
      var response = await http.get(url, headers: optHeader);
      if (response.statusCode == 200) {
        var result =
            json.decode(AppManager.utf8decoder.convert(response.bodyBytes));
        success(result);
      } else {
        throw Exception("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
      fail(e);
    } finally {
      if (complete != null) {
        complete();
      }
    }
  }

  static void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      print("连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      print("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      print("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      print("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      print("请求取消");
    } else {
      //DEFAULT Default error type, Some other Error. In this case,
      // you can read the DioError.error if it is not null.
      print("未知错误");
    }
  }

  static addIntercepWrapper() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      print("\n================== 请求数据 ==========================");
      print("url = ${options.uri.toString()}");
      print("headers = ${options.headers}");
      print("params = ${options.data}");
    }, onResponse: (Response response) {
      print("\n================== 响应数据 ==========================");
      print("code = ${response.statusCode}");
      print("data = ${response.data}");
      print("\n");
    }, onError: (DioError e) {
      print("\n================== 错误响应数据 ======================");
      print("type = ${e.type}");
      print("message = ${e.message}");
      print("\n");
    }));
  }
}

//  static Future get(String url, [Map<String, dynamic> params]) async {
//    Response response;
//
//    Directory documentsDir = await getApplicationDocumentsDirectory();
//    String documentsPath = documentsDir.path;
//    var dir = new Directory("$documentsPath/cookies");
//    await dir.create();
//    dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));
//    addIntercepWrapper();
//
//    if (params != null) {
//      response = await dio.get(url, queryParameters: params);
//    } else {
//      response = await dio.get(url);
//    }
//    return response.data;
//  }
//
//  static Future post(String url, Map<String, dynamic> params) async {
//    Response response;
//    Directory documentsDir = await getApplicationDocumentsDirectory();
//    String documentsPath = documentsDir.path;
//    var dir = new Directory("$documentsPath/cookies");
//    await dir.create();
//    dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));
//    addIntercepWrapper();
//    try {
//      response = await dio.post(url, data: params);
//    } on DioError catch (e) {
//      print('get error---------$e');
//      formatError(e);
//    }
//    return response.data;
//  }
//
