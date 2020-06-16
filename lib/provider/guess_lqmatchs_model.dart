import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xiaoqiu_sport/model/match_lq.dart';
import 'package:xiaoqiu_sport/utils/net_utils.dart';
import 'package:xiaoqiu_sport/components/toast.dart';
import 'package:xiaoqiu_sport/api/api_service.dart';

class GuessLqMatchsModel with ChangeNotifier {
  List<MatchLq> itemList = [];
  bool loading = true;
  int leagueID;//比赛分类
  int type;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void init(int type) {
    this.type = type;
  }

  Future loadData() async {
    final _param = {'leagueID':1};
    var itemdata = [];
    try {
      // print("初次加载：${_param}");
      var sportsResponse = await NetUtils.get(ApiService.lq_matchs_url, _param);
      itemdata = sportsResponse['result']['list'];
    } catch (e) {
      ToastUtil.showError(e.toString());
      refreshController.refreshFailed();
      loading = false;
    }
    itemList = [];
    itemList.addAll(itemdata.map((e) => MatchLq.fromJson(e)).toList());
    loading = false;
    refreshController.refreshCompleted();
    notifyListeners();
  }
}
