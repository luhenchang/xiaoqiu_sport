import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class RequestHupu {
  static Digest _getSign(Map<String, dynamic> query) {
    var keys = query.keys.toList();
    keys.sort();
    var result = '';
    for (int i = 0; i < keys.length; i++) {
      var key = keys[i];
      if (result != '') {
        result += '&';
      }
      result += '${key}=${query[key]}';
      // String keyvalue = key + "=" + query[key];
      // result += keyvalue;
    }
    result += 'HUPU_SALT_AKJfoiwer394Jeiow4u309';
    print(result);
    final sign = md5.convert(utf8.encode(result));
    return sign;
  }

  static Future<dynamic> getNews() async {
    try {
      final now = new DateTime.now();
      final time = now.millisecondsSinceEpoch;
      var query = {
        'clientId': 40834464,
        'crt': time,
        'night': 0,
        'channel': 'miui',
        'lastTid': 0,
        'stamp': 0,
        '_ssid': 'PHVua25vd24gc3NpZD4=',
        'isHome': 1,
        '_imei': 'c515b866695fe8c3',
        'time_zone': 'Asia/Shanghai',
        'bddid': 55045776183,
        'additionTid': -1,
        'client': 'c515b866695fe8c3',
        'android_id': 'c515b866695fe8c3',
        'unfollowTid': ''
      };

      var sign = _getSign(query);
      query['sign'] = sign;

      Response response = await Dio().get(
          "https://bbs.mobileapi.hupu.com/1/7.3.2/recommend/getThreadsList",
          queryParameters: query);
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> getNewsList({int nid = 0}) async {
    try {
      final now = new DateTime.now();
      final time = now.millisecondsSinceEpoch;
      var query = {
        'news_first_navi': '',
        'pre_count': 0,
        'advId': '9122E442-3C96-41E5-B5D3-EF9CD4EEE67C',
        'clientId': '83008540',
        'nid': nid,
        'first_navi_numbers': 1,
        'preload': 0,
        'direc': 'next',
        'num': 30,
        '_ssid': 'REVTS1RPUC1KNjFGRDJWIDM4MzQ',
        'night': 0,
        'crt': time,
        'time_zone': 'Asia/Shanghai',
        'client': '11A123C6-F88B-4599-825F-1CD606A4D7D8',
        'bddid': '70621959329'
      };

      var sign = _getSign(query);
      query['sign'] = sign;

      Response response = await Dio().get(
          "https://games.mobileapi.hupu.com/3/7.3.33/basketballapi/news/v1/getNewsList",
          queryParameters: query);
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> getNewsDetail({String id = '0'}) async {
    try {
      final now = new DateTime.now();
      final time = now.millisecondsSinceEpoch;
      var query = {
        'ft': '18',
        'pid': 0,
        'clientId': '83008540',
        'bddid': '70621959329',
        'advId': '9122E442-3C96-41E5-B5D3-EF9CD4EEE67C',
        'fid': 130,
        'entrance': 6,
        'isScheme': '1',
        'nopic': 0,
        '_ssid': 'REVTS1RPUC1KNjFGRDJWIDM4MzQ',
        'night': 0,
        'crt': time,
        'time_zone': 'Asia/Shanghai',
        'client': '11A123C6-F88B-4599-825F-1CD606A4D7D8',
        'page': '0'
      };

      var sign = _getSign(query);
      query['sign'] = sign;

      Response response = await Dio().get(
          "http://bbs.mobileapi.hupu.com/3/7.3.33/threads/" + id,
          queryParameters: query);
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future getLightCommentList({String tid = '0'}) async {
    try {
      final now = new DateTime.now();
      final time = now.millisecondsSinceEpoch;
      var query = {
        'tid': tid,
        'clientId': '83008540',
        'advId': '9122E442-3C96-41E5-B5D3-EF9CD4EEE67C',
        'fid': 4860,
        'offline': 'json',
        'order': 'asc',
        '_ssid': 'REVTS1RPUC1KNjFGRDJWIDM4MzQ',
        'night': 0,
        'crt': time,
        'client': '11A123C6-F88B-4599-825F-1CD606A4D7D8',
        'time_zone': 'Asia/Shanghai',
        'bddid': '70621959329',
      };

      var sign = _getSign(query);
      query['sign'] = sign;

      Response response = await Dio().get(
          "http://bbs.mobileapi.hupu.com/3/7.3.33/threads/getsThreadLightReplyList",
          queryParameters: query);
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future getAllCommentList({String tid = '0', String page = '1'}) async {
    try {
      final now = new DateTime.now();
      final time = now.millisecondsSinceEpoch;
      var query = {
        'page': page,
        'tid': tid,
        'clientId': '83008540',
        'advId': '9122E442-3C96-41E5-B5D3-EF9CD4EEE67C',
        'fid': 4860,
        'bddid': '70621959329',
        'offline': 'json',
        'order': 'asc',
        '_ssid': 'REVTS1RPUC1KNjFGRDJWIDM4MzQ',
        'night': 0,
        'crt': time,
        'client': '11A123C6-F88B-4599-825F-1CD606A4D7D8',
        'time_zone': 'Asia/Shanghai',
        'sort': 0
      };

      var sign = _getSign(query);
      query['sign'] = sign;

      Response response = await Dio().get(
          "http://bbs.mobileapi.hupu.com/3/7.3.33/threads/getsThreadPostList",
          queryParameters: query);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
