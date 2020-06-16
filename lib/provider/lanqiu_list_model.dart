import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xiaoqiu_sport/model/match_lq.dart';
import 'package:xiaoqiu_sport/utils/net_utils.dart';
import 'package:xiaoqiu_sport/components/toast.dart';
import 'package:xiaoqiu_sport/api/api_service.dart';
class LanqiuListModel with ChangeNotifier {
  List<MatchLq> itemList = [];
  bool loading = true;
  // int sportType;// 运动类型
  int type;//比赛分类
//  String apiUrl;
  int pageTotal = 0;
  int pageIndex = 0;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void init(int type) {
    // this.sportType = sportType;
    this.type = type;
//    this.apiUrl = apiUrl;
  }

  Future loadData() async {
    final _param = {'type':type,'page': 0, 'pageSize': 20};
    var itemdata = [];
    try {
      // print("初次加载：${_param}");
      var sportsResponse = await NetUtils.get(ApiService.lq_matchs_url, _param);
      itemdata = sportsResponse['result']['list'];
      pageTotal = sportsResponse['result']['total'];
//      print(pageTotal);
    } catch (e) {
      ToastUtil.showError(e.toString());
      refreshController.refreshFailed();
      loading = false;
    }
    pageIndex = 1;
    itemList = [];
    itemList.addAll(itemdata.map((e) => MatchLq.fromJson(e)).toList());
    loading = false;
    refreshController.refreshCompleted();
    notifyListeners();
  }

  Future loadMore() async {
    if (pageIndex == pageTotal) {
      refreshController.loadNoData();
      return;
    }
    var itemdata = [];
    final _param = {'type':type, 'page': pageIndex, 'pageSize': 20};
    try {
      // print("分页加载：${_param}");
      var sportsResponse = await NetUtils.get(ApiService.lq_matchs_url, _param);
      //从json中提取数组比赛数据
      itemdata = sportsResponse['result']['list'];
      pageTotal = sportsResponse['result']['total'];
    } catch (e) {
      ToastUtil.showError(e.toString());
      refreshController.loadFailed();
    }
    print("数据请求完成");
    pageIndex = pageIndex + 1;
    itemList.addAll(itemdata.map((e) => MatchLq.fromJson(e)).toList());
    loading = false;
    refreshController.loadComplete();
    notifyListeners();
  }

//  Future<void> refresh() async {
//    itemList.clear();
//    nextPageUrl = ApiService.lq_match_url;
////    refreshController.footerMode.value = LoadStatus.canLoading;
//    await loadMore();
//  }
//  Future loadMore() async {
//    if (nextPageUrl == null) {
//      refreshController.loadNoData();
//      return;
//    }
//    try {
//      var sportsResponse = await NetUtils.get(nextPageUrl);
////      print("model 获取结果");
////      print(sportsResponse);
////      print(type(sportsResponse));
//      List itemdata = sportsResponse['result']['data'];
////      print("比赛数量");
////      print(itemdata.length);
//      List<MatchLq> list = [];
//      list.addAll(itemdata.map((e) => MatchLq.fromJson(e)).toList());
//      itemList.addAll(list);
//      print("item比赛数量");
//      print(itemList.length);
//      // nextPageUrl = sportsResponse.nextPageUrl;
//      refreshController.loadComplete();
//      notifyListeners();
//      print("数据采集成功");
//      // nid = int.parse(articleResponse[articleResponse.length - 1]['nid']);
//    } catch (e) {
//      print("提取数据异常");
//      ToastUtil.showError(e.toString());
//      refreshController.refreshFailed();
//      loading = false;
//    }
//  }
}
