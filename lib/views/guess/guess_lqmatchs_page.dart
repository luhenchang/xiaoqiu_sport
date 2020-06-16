import 'package:flutter/material.dart';
// import 'package:xiaoqiu_sports/provider/guess_lqmatchs_model.dart';
// import 'package:xiaoqiu_sports/components/loading_container.dart';
// import 'package:xiaoqiu_sports/components/provider_widget.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:xiaoqiu_sports/components/lanqiu_match_item.dart';
import 'package:xiaoqiu_sport/utils/sp_util.dart';

class GuessLqMatchsPage extends StatefulWidget {
  final int type;
//  final String apiUrl;

  const GuessLqMatchsPage({Key key,this.type}) : super(key: key);

  @override
  _GuessLqMatchsPageState createState() => _GuessLqMatchsPageState();
}

class _GuessLqMatchsPageState extends State<GuessLqMatchsPage> {
  @override
  Widget build(BuildContext context) {
    print("登录状态:");
    print(SpUtil.getBool("sp_is_allogin"));
    print("用户token:");
    print(SpUtil.getString("sp_token"));
    String token = SpUtil.getString("sp_token");
    return Center(
      child:Text("${token}")
    );
  }

}
