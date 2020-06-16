class ApiService {
  static const user_base_url = "http://192.168.1.103:8004/user/";
  static const match_base_url = "http://127.0.0.1:8001/sports/";
  static const login_sendCode_URL = "${user_base_url}login/sendVerifyCode";
  static const login_verifyCode_URL = "${user_base_url}login/verifyCode";

//  static const lq_match_url = "${sports_base_url}lq/match";
  static const lq_ziliao_url = "${match_base_url}lq/ziliao";
  static const lq_matchs_url = "${match_base_url}lq/matchs";
  static const base_url = 'http://baobab.kaiyanapp.com/';
  static const feed_url = '${base_url}api/v2/feed?num=1';
  static const follow_url = '${base_url}api/v4/tabs/follow';
  static const community_url = '${base_url}api/v7/community/tab/rec';
  static const rank_url = '${base_url}api/v4/rankList';
  static const category_url = '${base_url}api/v4/categories';
  static const video_related_url = '${base_url}api/v4/video/related?id=';
  static const keyword_url = '${base_url}api/v3/queries/hot';
  static const search_url = "${base_url}api/v1/search?&num=10&start=10&query=";
  static const category_video_url = '${base_url}api/v4/categories/videoList?';

//  static getData(String url,
//      {Function success, Function fail, Function complete}) async {
//    try {
//      var response = await http.get(url, headers: HttpConstant.httpHeader);
//      print(response);
//      if (response.statusCode == 200) {
//        var result =
//            json.decode(AppManager.utf8decoder.convert(response.bodyBytes));
//        success(result);
//      } else {
//        throw Exception('"Request failed with status: ${response.statusCode}"');
//      }
//    } catch (e) {
//      fail(e);
//    } finally {
//      if (complete != null) {
//        complete();
//      }
//    }
//  }
}
