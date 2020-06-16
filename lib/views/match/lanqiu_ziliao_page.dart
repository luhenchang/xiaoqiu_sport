import 'package:flutter/material.dart';
import 'package:xiaoqiu_sport/model/ziliao_lq.dart';
import 'package:xiaoqiu_sport/components/tab_indicator.dart';
import 'package:xiaoqiu_sport/utils/net_utils.dart';
import 'package:xiaoqiu_sport/api/api_service.dart';
import 'package:xiaoqiu_sport/resources/colors.dart';

class LanqiuZiliaoPage extends StatefulWidget {
  @override
  _LanqiuZiliaoPageState createState() => _LanqiuZiliaoPageState();
}

class _LanqiuZiliaoPageState extends State<LanqiuZiliaoPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin  {
  TabController _tabController;
//  # 数据
  List<Group> groups = [];
//  一级List数据(国家列表)
  List<Country> countrys = [];
//  二级List (当前国家的联赛列表)
  List<League> leagues = [];
  int countryIndex = 0;
  int groupby = 0;
//  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: groups.length, vsync: this);
    getHttp();
//    _pageController = PageController();
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void getHttp() async {
    try {
      var response = await NetUtils.get(ApiService.lq_ziliao_url);
//      var group = Group.fromJson(response);
      /// 初始化
      setState(() {
        var grouplist = response['result']['region'];
        for (var groupdata in grouplist) {
          Group group = Group.fromJson(groupdata);
          groups.add(group);
        }
        _tabController = TabController(length: groups.length, vsync: this);
        leagues = groups[0].leagues;
//        countrys = groups[0].countrys;
////        countryIndex =0;
//        leagues = countrys[0].leagues;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: groups.length,
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
                tabs: groups
                    .map((Group group) => Tab(text: group.typeName))
                    .toList(),
                onTap: (index) {
                  setState(() {
                    if (groups[index].groupby == 1) {
                      groupby = 1;
                      countrys = groups[index].countrys;
                      countryIndex = 0;
                      leagues = countrys[countryIndex].leagues;
                    } else {
                      groupby = 0;
                      leagues = groups[index].leagues;
                    }
                  });
                },
              ),
            ),
          ),
        ),
        body: groupBody(),
      ),
    );
  }

  Widget groupBody() {
    if (groupby == 0) {
      return leagueBody();
    } else {
      return regionBody();
    }
  }

  Widget leagueBody() {
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            color: YColors.color_F9F9F9,
            child: getChip(),
          ),
        ],
      ),
    );
  }

  Widget regionBody() {
    return Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: countrys.length,
              itemBuilder: (context, position) {
                return itemCountry(position);
              },
            ),
          ),
          Expanded(
            flex: 6,
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(10),
                  color: YColors.color_F9F9F9,
                  child: getChip(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget itemCountry(i) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
        //Container下的color属性会与decoration下的border属性冲突，所以要用decoration下的color属性
        decoration: BoxDecoration(
          color: countryIndex == i ? YColors.color_F9F9F9 : Colors.white,
          border: Border(
            left: BorderSide(
                width: 5,
                color: countryIndex == i
                    ? Theme.of(context).primaryColor
                    : Colors.white),
          ),
        ),
        child: Text(
          countrys[i].nameCN,
          style: TextStyle(
            color: countryIndex == i ? Colors.black : YColors.color_666,
            fontWeight: countryIndex == i ? FontWeight.w600 : FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
      onTap: () {
        setState(() {
          countryIndex = i;
          leagues = countrys[countryIndex].leagues;
//          textColor = YColors.colorPrimary;
        });
      },
    );
  }

  Widget getChip() {
    //更新对应下标数据
//    _updateLeagues(i);
    return Wrap(
      spacing: 10.0, //两个widget之间横向的间隔
      direction: Axis.horizontal, //方向
      alignment: WrapAlignment.start, //内容排序方式
      children: List<Widget>.generate(
        leagues.length,
        (int index) {
          return ActionChip(
            elevation: 3,
//            backgroundColor: Colors.grey.shade200,
            //标签文字
            label: Text(
              leagues[index].nameSh,
              style: TextStyle(fontSize: 14, color: YColors.color_666),
            ),
            //点击事件
            onPressed: () {},
          );
        },
      ).toList(),
    );
  }
  @override
  bool get wantKeepAlive => true;
}
