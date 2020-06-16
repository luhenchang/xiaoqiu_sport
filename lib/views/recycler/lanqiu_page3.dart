import 'package:flutter/material.dart';
import 'package:xiaoqiu_sport/api/request_sports.dart';
import 'package:xiaoqiu_sport/model/match_lq.dart';
import 'package:xiaoqiu_sport/components/toast.dart';
import 'package:xiaoqiu_sport/components/lanqiu_match_item.dart';
// import 'dart:convert';
import 'package:xiaoqiu_sport/components/tab_indicator.dart';
// import 'package:xiaoqiu_sports/components/loading_container.dart';
// import 'package:xiaoqiu_sports/components/loading_container.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';

class LanqiuPage extends StatefulWidget {
  LanqiuPage({Key key}) : super(key: key);

  @override
  _LanqiuPageState createState() => _LanqiuPageState();
}

class _LanqiuPageState extends State<LanqiuPage>
    with SingleTickerProviderStateMixin {
  List<MatchLq> matchList = new List();
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;
  var count = 0;

  TabController _tabController;
  List tabs = ["即时", "赛程", "赛果", "关注"];
  // List pages = <Widget>[]
  // int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getDataLanqiu();
    _scrollController.addListener(listener);
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _tabController.dispose();
  }

  listener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _getMore();
    }
  }

  //sports data
  Future getDataLanqiu() async {
    try {
      var sportsResponse = await RequestSports.getMatchList(1);
      List matchResponse = sportsResponse['result']['data'];
      count = count + matchResponse.length;
      // nid = int.parse(articleResponse[articleResponse.length - 1]['nid']);
      if (!mounted) return;
      setState(() {
        matchList = [];
        matchList
            .addAll(matchResponse.map((e) => new MatchLq.fromJson(e)).toList());
      });
    } catch (e) {
      print(e);
      ToastUtil.showError(e.toString());
    }
  }

//  hupu加载更多
  Future _getMore() async {
    try {
      if (!isLoading) {
        isLoading = true;
        var result = await RequestSports.getMatchList(1, count: count);
        List matchResponse = result['result']['data'];
        count = count + matchResponse.length;
        setState(() {
          matchList
              .addAll(matchResponse.map((e) => MatchLq.fromJson(e)).toList());
        });
        isLoading = false;
      }
    } catch (e) {
      ToastUtil.showError(e.toString());
    }
  }

  Widget _getLoadMoreWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Row(
        children: <Widget>[
          Container(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(strokeWidth: 2)),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Widget _renderRow(context, index) {
    if (index < matchList.length) {
      // if(index == 0) {
      //   return _getTopWidget();
      // }
      return Container(
        // child: Text("比赛"),
        child: MatchLqItem(match: matchList[index]),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
      );
    } else if (index > 0) {
      return _getLoadMoreWidget();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return getPageLanqiu();
  }

  Widget getPageLanqiu() {
    return Column(children: [
      Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black87,
        child: TabBar(
          indicator: CircleTabIndicator(color: Colors.white, radius: 3),
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          labelColor: Colors.white,
          controller: _tabController,
          unselectedLabelStyle: TextStyle(fontSize: 16),
          tabs: tabs.map((e) => Tab(text: e)).toList(),
          // onTap: (index) => _pageController.animateToPage(index,duration: kTabScrollDuration, curve: Curves.ease)
        ),
      ),
      Expanded(
        child: TabBarView(
          controller: _tabController,
          // onPageChanged: (index) => _tabController.index = index,
          children: tabs.map((e) => getMatchList()).toList(),
        ),
      )
    ]);
  }

  Widget getPageLanqiu2() {
    return Column(children: [
      Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black87,
        child: TabBar(
          indicator: CircleTabIndicator(color: Colors.white, radius: 3),
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          labelColor: Colors.white,
          controller: _tabController,
          unselectedLabelStyle: TextStyle(fontSize: 16),
          tabs: tabs.map((e) => Tab(text: e)).toList(),
          // onTap: (index) => _pageController.animateToPage(index,duration: kTabScrollDuration, curve: Curves.ease)
        ),
      ),
      Expanded(
        child: TabBarView(
          controller: _tabController,
          // onPageChanged: (index) => _tabController.index = index,
          children: tabs.map((e) => getMatchList()).toList(),
        ),
      )
    ]);
  }

  Widget getMatchList() {
    return RefreshIndicator(
        onRefresh: getDataLanqiu,
        backgroundColor: Colors.grey[100],
        // child: Text("你好"),
        child: ListView.builder(
          itemCount: matchList.length + 1,
          itemBuilder: _renderRow,
          controller: _scrollController,
        ));
  }

  Widget getMatchList2() {
    return RefreshIndicator(
        onRefresh: getDataLanqiu,
        backgroundColor: Colors.grey[100],
        // child: Text("你好"),
        child: ListView.builder(
          itemCount: matchList.length + 1,
          itemBuilder: _renderRow,
          controller: _scrollController,
        ));
  }
}
