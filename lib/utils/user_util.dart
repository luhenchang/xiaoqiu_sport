import 'package:xiaoqiu_sport/public.dart';

class UserUtil {
  static const String SP_USER_TOKEN = "sp_user_token";
  static const String SP_USER_ID = "sp_user_id";
  static const String SP_USER_MOBILE = "sp_user_mobile";
  static const String SP_USER_NICK = "sp_user_nick";
  static const String SP_USER_HEADURL = "sp_user_headurl";
  static const String SP_USER_DESC = "sp_user_desc";
  static const String SP_USER_URL = "sp_user_url";
  static const String SP_USER_GENDER = "sp_user_gender";
  static const String SP_USER_FANS = "sp_user_fans";
  static const String SP_USER_FOLLOW = "sp_user_follow";
  // static const String SP_USER_ISMEMBER = "sp_user_ismember";
  // static const String SP_USER_ISVERTIFY = "sp_user_isvertify";

  static const String SP_IS_ALLOGIN = "sp_is_allogin";

  // 保存用户Token
  static saveUserToken(String token) async {
    SpUtil.putString(SP_USER_TOKEN, token);
  }

  // 获取用户Token
  static getUserToken() {
    String token = SpUtil.getString(SP_USER_TOKEN);
    return token;
  }

  // 保存用户个人信息
  static User saveUserInfo(Map data) {
    if (data != null) {
      String id = data['id'].toString();
      String mobile = data['mobile'];
      String nick = data['nick'];
      String headUrl = data['headUrl'];
      String desc = data['decs'];
      String gender = data['gender'].toString();
      String followCount = data['followCount'].toString();
      String fansCount = data['fansCount'].toString();
      // int ismember = data['ismember'];
      // int isvertify = data['isvertify'];

      SpUtil.putString(SP_USER_ID, id);
      SpUtil.putString(SP_USER_MOBILE, mobile);
      SpUtil.putString(SP_USER_NICK, nick);
      SpUtil.putString(SP_USER_HEADURL, headUrl);
      SpUtil.putString(SP_USER_DESC, desc);
      SpUtil.putString(SP_USER_GENDER, gender);
      SpUtil.putString(SP_USER_FOLLOW, followCount);
      SpUtil.putString(SP_USER_FANS, fansCount);
      SpUtil.putBool(SP_IS_ALLOGIN, true);

      // SpUtil.putInt(SP_USER_ISMEMBER, ismember);
      // SpUtil.putInt(SP_USER_ISVERTIFY, isvertify);

      User userInfo = User(
          id: id,
          mobile: mobile,
          nick: nick,
          headUrl: headUrl,
          gender: gender,
          desc: desc,
          fansCount: fansCount,
          followCount: followCount);
      return userInfo;
    }
    return null;
  }

  // 获取用户信息
  static User getUserInfo() {
    bool isLogin = SpUtil.getBool(SP_IS_ALLOGIN);
    if (isLogin == null || !isLogin) {
      return User();
    }
    User userInfo = User();
    userInfo.id = SpUtil.getString(SP_USER_ID);
    userInfo.mobile = SpUtil.getString(SP_USER_MOBILE);
    userInfo.nick = SpUtil.getString(SP_USER_NICK);
    userInfo.headUrl = SpUtil.getString(SP_USER_HEADURL);
    userInfo.desc = SpUtil.getString(SP_USER_DESC);
    userInfo.gender = SpUtil.getString(SP_USER_GENDER);
    userInfo.followCount = SpUtil.getString(SP_USER_FOLLOW);
    userInfo.fansCount = SpUtil.getString(SP_USER_FANS);
    // userInfo.ismember = SpUtil.getInt(SP_USER_ISMEMBER);
    // userInfo.isvertify = SpUtil.getInt(SP_USER_ISVERTIFY);

    return userInfo;
  }

  // 判断用户是否登录
  static bool isLogin() {
    bool b = SpUtil.getBool(SP_IS_ALLOGIN);
    return b != null && b;
  }

  // 保存用户头像
  static saveUserHeadUrl(String mUrl) async {
    await SpUtil.putString(SP_USER_HEADURL, mUrl);
  }

  static saveUserNick(String mUrl) async {
    await SpUtil.putString(SP_USER_NICK, mUrl);
  }

  static saveUserDesc(String mUrl) async {
    await SpUtil.putString(SP_USER_DESC, mUrl);
  }

  static loginout() {
    SpUtil.putBool(SP_IS_ALLOGIN, false);
    SpUtil.putObject(SP_USER_ID, "");
    SpUtil.putString(SP_USER_MOBILE, "");
    SpUtil.putString(SP_USER_NICK, "");
    SpUtil.putString(SP_USER_HEADURL, "");
    SpUtil.putObject(SP_USER_DESC, "");
    SpUtil.putObject(SP_USER_GENDER, "");
    SpUtil.putObject(SP_USER_FOLLOW, "");
    SpUtil.putObject(SP_USER_FANS, "");
    // SpUtil.putObject(SP_USER_ISMEMBER, "");
    // SpUtil.putObject(SP_USER_ISVERTIFY, "");
  }
}
