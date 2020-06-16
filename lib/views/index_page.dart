import 'package:flutter/material.dart';
// import 'package:xiaoqiu_sports/views/news/news_page.dart';
// import 'package:xiaoqiu_sports/views/match/match_page.dart';
// import 'package:xiaoqiu_sports/views/user/user_page.dart';
// import 'package:xiaoqiu_sports/views/video/rank_page.dart';
// import 'package:xiaoqiu_sports/views/match/lanqiu_ziliao_page.dart';
import 'package:xiaoqiu_sport/views/guess/guess_page.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with SingleTickerProviderStateMixin {
  PageController _pageController = PageController(initialPage: 0);
  // TabController _tabController;

  int _naviIndex = 2;
  // void _onTapHandler(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[GuessPage(), GuessPage(), GuessPage(), GuessPage(), GuessPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _naviIndex,
          onTap: (index) {
            _pageController.jumpToPage(index); //跳转到指定页面
            setState(() {
              _naviIndex = index;
              print(_naviIndex);
            });
          },
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.red,
          items: [
            _bottomItem('赛事', 'assets/images/ic_match_normal.png',
                'assets/images/ic_match_selected.png', 0),
            _bottomItem('新闻', 'assets/images/ic_discovery_normal.png',
                'assets/images/ic_discovery_selected.png', 1),
            _bottomItem('模拟', 'assets/images/ic_match_normal.png',
                'assets/images/ic_match_selected.png', 2),
            _bottomItem('视频', 'assets/images/ic_hot_normal.png',
                'assets/images/ic_hot_selected.png', 3),
            _bottomItem('我的', 'assets/images/ic_mine_normal.png',
                'assets/images/ic_mine_selected.png', 4)
          ]),
    );
  }

  _bottomItem(String title, String normalIcon, String selectIcon, int index) {
    return BottomNavigationBarItem(
      icon: Image.asset(normalIcon, width: 24, height: 24),
      activeIcon: Image.asset(selectIcon, width: 24, height: 24),
      title: Padding(
          padding: EdgeInsets.only(top: 2),
          child: Text(title,
              style: TextStyle(
                  color:
                  Color(_naviIndex == index ? 0xff000000 : 0xff9a9a9a),
                  fontSize: 14))),
    );
  }
}
