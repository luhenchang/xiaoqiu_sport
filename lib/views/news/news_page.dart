import 'package:flutter/material.dart';
import './nba_page.dart';
// import 'package:xiaoqiu_sports/resources/sports_color.dart';
// import 'package:xiaoqiu_sports/components/search_input.dart';
import 'package:xiaoqiu_sport/components/tab_indicator.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tabs = ["关注", "NBA", "中国篮球", "国际篮球"];
  // int _currentIndex = 0;

  // void _onTapHandler(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            centerTitle: true,
            backgroundColor: Colors.grey[100],
            elevation: 0.0,
            brightness: Brightness.light,
            // leading: Icon(Icons.menu,color:Colors.black),
            title: Container(
              width: MediaQuery.of(context).size.width,
              child: TabBar(
                // unselectedLabelColor: Colors.black38,
                indicator: CircleTabIndicator(color: Colors.black, radius: 3),
                isScrollable: true,
                labelStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                labelColor: Colors.black,
                controller: _tabController,
                // labelStyle: TextStyle(fontSize: 20),
                unselectedLabelColor: Color(0xff9a9a9a),
                unselectedLabelStyle: TextStyle(fontSize: 15),
                tabs: tabs.map((e) => Tab(text: e)).toList(),
              ),
            ),
            // actions: <Widget>[
            //   Container(
            //     margin:EdgeInsets.only(right:18),
            //     child:Icon(Icons.add_a_photo,color: Colors.black,)
            //   )
            // ],
          ),
        ),
        body: TabBarView(
            controller: _tabController,
            children: tabs.map((e) => NbaPage()).toList()),
      ),
    );
  }
}
