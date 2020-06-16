import 'package:flutter/material.dart';
import 'package:xiaoqiu_sport/provider/lanqiu_list_model.dart';
import 'package:xiaoqiu_sport/components/loading_container.dart';
import 'package:xiaoqiu_sport/components/provider_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xiaoqiu_sport/components/lanqiu_match_item.dart';

class LanqiuListPage extends StatefulWidget {
  final int type;
//  final String apiUrl;

  const LanqiuListPage({Key key,this.type}) : super(key: key);

  @override
  _LanqiuListPageState createState() => _LanqiuListPageState();
}

class _LanqiuListPageState extends State<LanqiuListPage> {
  @override
  Widget build(BuildContext context) {
//    super.build(context);
    return ProviderWidget<LanqiuListModel>(
        model: LanqiuListModel(),
        onModelInit: (model) {
          model.init(widget.type);
          model.loadData();
        },
        builder: (context, model, child) {
          return LoadingContainer(
            loading: model.loading,
            child: SmartRefresher(
                controller: model.refreshController,
                enablePullDown: true,
                onRefresh: model.loadData,
                onLoading: model.loadMore,
                enablePullUp: true,
                child: ListView.separated(
                  itemCount: model.itemList.length,
                  itemBuilder: (context, index) {
                    print("创建比赛单元");
                    return MatchLqItem(match: model.itemList[index]);
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                        // padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                        child: Divider(height: 0.5));
                  },
                )),
          );
        });
  }
//  @override
//  bool get wantKeepAlive => true; //设置页面缓存

}
