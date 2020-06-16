import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    Future.delayed(new Duration(seconds:0), () async {
      var loginStatuShared=await SharedPreferences.getInstance();
      bool loginStatu= loginStatuShared.getBool("sp_is_allogin");
      if (loginStatu!= null && loginStatu){
        Navigator.pop(context);
        Routes.navigateTo(context, Routes.indexPage, clearStack: true);
      }else{
        Navigator.pop(context);
        Routes.navigateTo(context, Routes.loginPage, clearStack: true);
      }
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
