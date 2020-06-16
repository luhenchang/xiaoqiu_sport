import 'package:flutter/material.dart';
// import 'package:xiaoqiu_sports/api/api_service.dart';
// import 'package:xiaoqiu_sports/utils/net_utils.dart';
// import 'package:xiaoqiu_sports/utils/toast_util.dart';
import 'package:xiaoqiu_sport/model/ziliao_lq.dart';

class LanqiuGroupModel with ChangeNotifier {
//  List<Country> countrys = [];
//  List<League> leagues = [];
//  int index =0;
  Group group;

  void init(Group group) {
    this.group = group;
  }
}
