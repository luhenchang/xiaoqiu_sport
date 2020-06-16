import 'package:flutter/material.dart';
import 'package:xiaoqiu_sport/components/tab_indicator.dart';
//import 'package:xiaoqiu_sports/api/api_service.dart';
import 'package:xiaoqiu_sport/views/match/lanqiu_list_page.dart';

class LanqiuPage extends StatefulWidget {
  LanqiuPage({Key key}) : super(key: key);

  @override
  _LanqiuPageState createState() => _LanqiuPageState();
}

class _LanqiuPageState extends State<LanqiuPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  PageController _pageController;
  TabController _tabController;
  List tabs = ["即时", "赛程", "赛果", "关注"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
//      appBar: AppBar(
//        title: Text('发现',
//            style: TextStyle(
//                fontSize: 18,
//                color: Colors.black,
//                fontWeight: FontWeight.bold)),
//        brightness: Brightness.light,
//        centerTitle: true,
//        elevation: 0,
//        backgroundColor: Colors.white,
//      ),
      body: Column(children: [
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
              onTap: (index) => _pageController.animateToPage(index,
                  duration: kTabScrollDuration, curve: Curves.ease)),
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            // onPageChanged: (index) => _tabController.index = index,
            children: tabs
                .map((e) => LanqiuListPage(type: 1,))
                .toList(),
          ),
        )
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
