import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xiaoqiu_sport/utils/net_utils.dart';
import 'package:xiaoqiu_sport/api/api_service.dart';
import 'package:xiaoqiu_sport/utils/constant.dart';
import 'package:xiaoqiu_sport/public.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with AutomaticKeepAliveClientMixin {
  // PageController _pageController;
  TextEditingController schoolController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController codeController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  // String _name; // 用户名
  // String _pwd; // 密码
  String _phone; // 手机号
  String _number; // 验证码
  Timer _timer;
  int totalTime = 60; // 获取下一次验证码倒计时
// 获取验证码的状态
  bool isGetChenckNum = false; // 是否正在获取验证码

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.close,
              size: 30,
              color: Colors.black87,
            ),
            onPressed: () {
//              _checkSub(context);
            }),
        backgroundColor: Colors.white,
      ),
      body: loginBody(context),
      backgroundColor: Colors.white,
    );
  }

  Widget loginBody(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Container(
        height: _media.height,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: _media.height * 0.04, left: 20),
              alignment: Alignment.topLeft,
              child: Text(
                'Hi，欢迎使用球街~',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26.0,
                ),
              ),
            ),
            Expanded(
              child: loginCodeBody(_media),
            ),
            buildOtherLoginWay(),
          ],
        ));
  }

  // 验证码登录
  Widget loginCodeBody(Size media) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(20.0, media.height * 0.05, 20.0, 0.0),
          height: 44,
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                width: 52,
                child: Text(
                  "+86 >",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              Expanded(
                child: Container(
                  child: TextField(
                    textAlign: TextAlign.start,
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "请输入手机号",
                      hintStyle:
                          TextStyle(fontSize: 18, color: Color(0xff999999)),
                    ),
                    onChanged: (value) {
                      _phone = value;
                    },
                  ),
                ),
              ),
              IconButton(
                  padding: EdgeInsets.only(right: 0),
                  // iconSize: 50,
                  icon: Image.asset(
                    'assets/images/icon_et_delete.png',
                    width: 16.0,
                    height: 16.0,
                  ),
                  onPressed: () {
                    mobileController.clear();
                  })
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
          child: Divider(
              height: 1.0,
              color: Color(0xff999999)),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          height: 44,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: TextField(
                    textAlign: TextAlign.start,
                    controller: codeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "请输入验证码",
                      hintStyle:
                          TextStyle(fontSize: 18, color: Color(0xff999999)),
                    ),
                    onChanged: (value) {
                      _number = value;
                    },
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: 120,
                child: Container(
                    child: GestureDetector(
                        child: _codeWidget(),
                        onTap: () {
                          if (isGetChenckNum == true) {
                            return;
                          }
                          if (_phone == null || _phone.isEmpty) {
                            ToastUtil.showError('请输入手机号码');
                            return;
                          }
                          setState(() {
                            totalTime = 60;
                            isGetChenckNum = true;
                          });
                          // 先用正则检验手机号是否正确
                          if (checkPhoneRule(_phone) == false) {
                            ToastUtil.showError('请输入正确的手机号码');
                            setState(() {
                              isGetChenckNum = false;
                            });
                            return;
                          }
                          _startTimer();
                          isGetChenckNum = true;
                          // 获取验证码
                          getCheckNum();
                        })),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
          child: Divider(
              height: 1.0,
              color: Color(0xff999999)),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "未注册的手机号验证后自动创建球街账户",
            style: TextStyle(fontSize: 14, color: Color(0xff999999)),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          width: media.width,
          height: 48,
          margin: EdgeInsets.only(
              left: 20,
              top: media.height * 0.05,
              right: 20,
              bottom: media.height * 0.1),
          child: FlatButton(
            color: Color(0xff999999),
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Color(0xff999999),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "登录",
                style: TextStyle(
                  fontFamily: 'HanaleiFill',
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
            onPressed: () {
              doLogin();
            },
          ),
        )
      ],
    );
  }

  //其他登录方式
  Widget buildOtherLoginWay() {
    return Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 30, top: 10),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    Constant.ASSETS_IMG + 'login_weixin.png',
                    width: 40.0,
                    height: 40.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      '微信',
                      style: TextStyle(fontSize: 12, color: Color(0xff999999)),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, top: 10),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    Constant.ASSETS_IMG + 'login_qq.png',
                    width: 40.0,
                    height: 40.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      'QQ',
                      style: TextStyle(fontSize: 12, color: Color(0xff999999)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget _codeWidget() {
    if (isGetChenckNum == false) {
      return Text(
        '获取验证码',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, color: Color(0xff999999)),
      );
    } else {
      return Text(
        '$totalTime秒后重新发送',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, color: Colors.black),
      );
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      //一分钟后可再次获取验证码
      if (totalTime == 0) {
        print('时间到了');
        _timer.cancel();
        setState(() {
          isGetChenckNum = false;
        });
        return;
      }
      setState(() {
        totalTime--;
      });
    });
  }

  // 正则判断手机号
  bool checkPhoneRule(phoneNum) {
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    bool matched = exp.hasMatch(phoneNum);
    return matched;
  }

  Future getCheckNum() async {
    var _param = {'mobile': _phone};
    var response = await NetUtils.post(ApiService.login_sendCode_URL, _param);
    if (response['code'] != 200) {
      ToastUtil.showError(response['message']);
    }
  }

  Future doLogin() async {
    var loginStatuShared=await SharedPreferences.getInstance();
    Future<bool> loginStatu= loginStatuShared.setBool("sp_is_allogin",true);
    print('开始登录');
    if (null == _phone || _phone.isEmpty) {
      ToastUtil.showError("请输入手机号");
      return;
    }
    if (null == _number || _number.isEmpty) {
      ToastUtil.showError('请输入验证码');
      return;
    }
    // 开始登录
    var _param = {'mobile': _phone, 'verifyCode': _number};
    var response = await NetUtils.post(ApiService.login_verifyCode_URL, _param);
    print(response);
    if (response['code'] != 200) {

      print("登录失败");
      ToastUtil.showError(response['message']);
    } else {
      print("登录成功");

      // UserUtil.saveUserInfo(response['data']['userInfo']);
      // UserUtil.saveUserToken(response['data']['token']);
      /*SpUtil.putBool("sp_is_allogin", true);
      SpUtil.putString("sp_token", response['data']['token']);
      print("本地保存成功");
      print(SpUtil.getBool("sp_is_allogin"));
      print(SpUtil.getString("sp_token"));*/
      Navigator.pop(context);
      Routes.navigateTo(context, Routes.indexPage);
    }
  }

  @override
  bool get wantKeepAlive => true;
}

//  Widget _codeWidget() {
//    if (isGetChenckNum == 0) {
//      return Text(
//        '获取验证码',
//        textAlign: TextAlign.center,
//        style: TextStyle(fontSize: 12, color: Colors.grey),
//      );
//    } else if (isGetChenckNum == 1) {
//      return Text(
//        '获取验证码',
//        textAlign: TextAlign.center,
//        style: TextStyle(fontSize: 12, color: Colors.black),
//      );
//    } else {
//      return Text(
//        '$totalTime秒后重新发送',
//        textAlign: TextAlign.center,
//        style: TextStyle(fontSize: 12, color: Colors.grey),
//      );
//    }
//  }
