import 'package:flutter/material.dart';
import 'package:xiaoqiu_sport/components/tab_indicator.dart';
import 'package:xiaoqiu_sport/views/match/lanqiu_list_page.dart';

class LanqiuPage extends StatefulWidget {
  LanqiuPage({Key key}) : super(key: key);

  @override
  _LanqiuPageState createState() => _LanqiuPageState();
}

class _LanqiuPageState extends State<LanqiuPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
//  List<MatchLq> matchList = new List();
//  bool isLoading = false;
//  var count = 0;
  PageController _pageController;
  TabController _tabController;
  List tabs = [["即时",1], ["赛程",2], ["赛果",3], ["关注",4]];
  // List pages = <Widget>[]
  // int _currentIndex = 0;

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
            tabs: tabs.map((tab) => Tab(text: tab[0])).toList(),
            onTap: (index) => _pageController.animateToPage(index,
                duration: kTabScrollDuration, curve: Curves.ease)),
      ),
      Expanded(
        child: PageView(
          controller: _pageController,
          // onPageChanged: (index) => _tabController.index = index,
          children: tabs
              .map((tab) => LanqiuListPage(type:tab[1]))
              .toList(),
        ),
      )
    ]);
  }

  @override
  bool get wantKeepAlive => true;
  //sports data
  // Widget _getLoadMoreWidget() {
  //   return Container(
  //     padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
  //     child: Row(
  //       children: <Widget>[
  //         Container(
  //             height: 15,
  //             width: 15,
  //             child: CircularProgressIndicator(strokeWidth: 2)),
  //       ],
  //       mainAxisAlignment: MainAxisAlignment.center,
  //     ),
  //   );
  // }
}
