import 'package:flutter/material.dart';
import 'package:xiaoqiu_sport/views/guess/guess_lqmatchs_page.dart';
import 'package:xiaoqiu_sport/components/tab_rect_indicator.dart';
import 'package:flutter/services.dart';

class GuessPage extends StatefulWidget {
  GuessPage({Key key}) : super(key: key);

  @override
  _GuessPageState createState() => _GuessPageState();
}

class _GuessPageState extends State<GuessPage>
    with SingleTickerProviderStateMixin {
  SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);

  TabController _tabController;
  List tabs = ["滚球盘", "赛前盘"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
    //     .copyWith(statusBarBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black87,
          elevation: 0,
          brightness: Brightness.dark,
          leading: IconButton(
              icon: Image.asset("assets/images/ic_settings2.png",
                  width: 22, height: 22),
              onPressed: () {}),
          // title: Text('你好'),
          title: Container(
            width: MediaQuery.of(context).size.width * 0.42,
            height: 26,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: TabBar(
              indicator: RectTabIndicator(color: Colors.white, radius: 0),
              labelStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              labelColor: Colors.black,
              controller: _tabController,
              // labelStyle: TextStyle(fontSize: 20),
              unselectedLabelColor: Colors.white,
              unselectedLabelStyle: TextStyle(fontSize: 14),
              tabs: tabs.map((e) => Tab(text: e)).toList(),
            ),
          ),
        ),
      ),
      // body: LanqiuPage(),
      body: TabBarView(
          controller: _tabController,
          children: tabs.map((e) => GuessLqMatchsPage()).toList()),
    );
  }
}
