import 'package:flutter/material.dart';
import 'package:xiaoqiu_sport/model/ziliao_lq.dart';
//import 'package:xiaoqiu_spots/model/league.dart';
import 'package:xiaoqiu_sport/resources/colors.dart';
import 'package:xiaoqiu_sport/utils/net_utils.dart';
import 'package:xiaoqiu_sport/api/api_service.dart';


class LanqiuZiliaoPage extends StatefulWidget {
  @override
  _LanqiuZiliaoPageState createState() => _LanqiuZiliaoPageState();
}

class _LanqiuZiliaoPageState extends State<LanqiuZiliaoPage> {
  List<Group> groups = List<Group>();
  List<Country> countrys = List<Country>();
  List<League> leagues = List<League>();
  int countryIndex;
  int groupIndex;

  @override
  void initState() {
    super.initState();
    getHttp();
  }

  void getHttp() async {
    try {
      var response = await NetUtils.get(ApiService.lq_ziliao_url);
//      var group = Group.fromJson(response);
      /// 初始化
      setState(() {
        var grouplist = response['result']['list'];
        for (var groupdata in grouplist) {
          Group group = Group.fromJson(groupdata);
          groups.add(group);
        }
        groupIndex = 0;
        countryIndex = 0;
        countrys = groups[0].countrys;
        leagues = countrys[0].leagues;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YColors.color_fff,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          title: Text('资料库'),
          backgroundColor: Colors.grey[100],
        ),
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: groups.length,
              itemBuilder: (context, position) {
                return itemGroup(position);
              },
            ),
          ),
          Expanded(
            flex: 3,
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
                  child: getChip(countryIndex),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget itemGroup(int i) {
//    Color textColor = Theme.of(context).primaryColor; //
    Color textColor = Colors.black;
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
        //Container下的color属性会与decoration下的border属性冲突，所以要用decoration下的color属性
        decoration: BoxDecoration(
          color: groupIndex == i ? YColors.color_F9F9F9 : Colors.white,
          border: Border(
            left: BorderSide(
                width: 5,
                color: groupIndex == i
                    ? Theme.of(context).primaryColor
                    : Colors.white),
          ),
        ),
        child: Text(
          groups[i].typeName,
          style: TextStyle(
            color: groupIndex == i ? textColor : YColors.color_666,
            fontWeight: groupIndex == i ? FontWeight.w600 : FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
      onTap: () {
        setState(() {
          groupIndex = i; //记录选中的下标
          countryIndex = 0;
          countrys = groups[groupIndex].countrys;
          leagues = countrys[0].leagues;
          textColor = YColors.colorPrimary;
        });
      },
    );
  }

  Widget itemCountry(int i) {
    // Color textColor = Theme.of(context).primaryColor; 
//    _updateCountrys(i);
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
          // print("groupIndex ${groupIndex}");
          countryIndex = i; //记录选中的下标
          leagues = countrys[countryIndex].leagues;
          // textColor = YColors.colorPrimary;
        });
      },
    );
  }

  Widget getChip(int i) {
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
            backgroundColor: Colors.grey.shade200,
            //标签文字
            label: Text(
              leagues[index].nameSh,
              style: TextStyle(fontSize: 14, color: YColors.color_666),
            ),
            //点击事件
            onPressed: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => ArticleDetail(
//                      title: articles[index].title, url: articles[index].link),
//                ),
//              );
            },
          );
        },
      ).toList(),
    );
  }

  // List<League> _updateLeagues(int i) {
  //   setState(() {
  //     if (countrys.length != 0) {
  //       leagues = countrys[i].leagues;
  //     }
  //   });
  //   return leagues;
  // }

  // List<Country> _updateCountrys(int i) {
  //   setState(() {
  //     if (groups.length != 0) {
  //       countrys = groups[i].countrys;
  //     }
  //   });
  //   return countrys;
  // }
}
