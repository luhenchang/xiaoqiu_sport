import 'package:flutter/material.dart';
// import 'package:xiaoqiu_sports/api/api_service.dart';
import 'package:xiaoqiu_sport/utils/net_utils.dart';
import 'package:xiaoqiu_sport/model/issue_model.dart';
import 'package:xiaoqiu_sport/components/toast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RankListPageModel with ChangeNotifier {
  List<Item> itemList = [];
  bool loading = true;
  String apiUrl;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void init(String apiUrl) {
    this.apiUrl = apiUrl;
  }

  void loadData() {
    NetUtils.getData(apiUrl,
        success: (result) {
          Issue issueModel = Issue.fromJson(result);
          itemList = issueModel.itemList;
          loading = false;
          refreshController.refreshCompleted();
        },
        fail: (e) {
          ToastUtil.showError(e.toString());
          refreshController.refreshFailed();
          loading = false;
        },
        complete: () => notifyListeners());
  }
}
