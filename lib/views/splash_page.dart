import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xiaoqiu_sport/utils/constant.dart';
import 'package:xiaoqiu_sport/routers/routers.dart';
import 'package:xiaoqiu_sport/utils/sp_util.dart';
// import 'package:xiaoqiu_sports/utils/user_util.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  SplashPageState createState() {
    return new SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    SpUtil.getInstance();
    Future.delayed(new Duration(seconds: 1), () {
      if (SpUtil.getBool("sp_is_allogin") != null && SpUtil.getBool("sp_is_allogin")){
        Navigator.pop(context);
        Routes.navigateTo(context, Routes.indexPage, clearStack: true);
      }else{
        Navigator.pop(context);
        Routes.navigateTo(context, Routes.loginPage, clearStack: true);
      }
      // print("登录状态:");
      // print(UserUtil.isLogin());
      // print("用户token:");
      // print(UserUtil.getUserToken());
      // if (!UserUtil.isLogin()) {
      //   Navigator.pop(context);
      //   Routes.navigateTo(context, Routes.loginPage, clearStack: true);
      // } else {
      //   Navigator.pop(context);
      //   Routes.navigateTo(context, Routes.indexPage, clearStack: true);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 100),
                    child: Image.asset(
                      Constant.ASSETS_IMG + 'welcome_android_slogan.png',
                      width: 200.0,
                      height: 100.0,
                    ),
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ],
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      Constant.ASSETS_IMG + 'ic_logo.png',
                      width: 100.0,
                      height: 100.0,
                    ),
                    color: Color(0xFFFFFFFF),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
