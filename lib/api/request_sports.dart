import 'package:dio/dio.dart';
class RequestSports{
  static Future<dynamic> getMatchList(int sid, {int count=0}) async {
    try {
      // final now = new DateTime.now();
      // final time = now.millisecondsSinceEpoch;
      var query = {
        'count':count,
        'sid':sid
      };
      Response response = await Dio().get(
        "http://192.168.1.103:5000/lq/match",
        queryParameters: query);
      // print(response.data);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}