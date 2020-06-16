import 'package:flutter/material.dart';
import 'package:xiaoqiu_sport/api/api_service.dart';
import 'package:xiaoqiu_sport/utils/net_utils.dart';
import 'package:xiaoqiu_sport/model/tab_info_model.dart';
import 'package:xiaoqiu_sport/views/video/rank_list_page.dart';
import 'package:xiaoqiu_sport/components/toast.dart';
import 'package:xiaoqiu_sport/components/tab_indicator.dart';

class RankPage extends StatefulWidget {
  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  PageController _pageController;
  List<TabInfoItem> _tabList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabList.length, vsync: this);
    _pageController = PageController();
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
              centerTitle: true,
              backgroundColor: Colors.grey[100],
              elevation: 0.0,
              brightness: Brightness.light,
              // leading: Icon(Icons.menu,color:Colors.black),
              title: Container(
                width: MediaQuery.of(context).size.width * 0.70,
                child: TabBar(
                    indicator:
                        CircleTabIndicator(color: Colors.black, radius: 3),
                    controller: _tabController,
                    labelColor: Colors.black,
                    unselectedLabelColor: Color(0xff9a9a9a),
                    labelStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelStyle: TextStyle(fontSize: 15),
                    tabs: _tabList.map((TabInfoItem tabInfoItem) {
                      return Tab(text: tabInfoItem.name);
                    }).toList(),
                    onTap: (index) => _pageController.animateToPage(index,
                        duration: kTabScrollDuration, curve: Curves.ease)
                ),
              )),
        ),
        body: PageView(
            controller: _pageController,
            onPageChanged: (index) => _tabController.index = index,
            children: _tabList.map((TabInfoItem tabInfoItem) {
              return RankListPage(apiUrl: tabInfoItem.apiUrl);
            }).toList()));
  }

  void _loadData() async {
    await NetUtils.getData(ApiService.rank_url, success: (result) {
      print(result.toString());
      TabInfoModel tabInfoModel = TabInfoModel.fromJson(result);
      if (mounted) {
        //判断是否渲染完成，防止数据还没有获取到，此时setState触发的控件渲染就会报错
        setState(() {
          _tabList = tabInfoModel.tabInfo.tabList;
          _tabController = TabController(length: _tabList.length, vsync: this);
        });
      }
    }, fail: (e) {
      ToastUtil.showError(e.toString());
    });
  }

  @override
  bool get wantKeepAlive => true;
}
