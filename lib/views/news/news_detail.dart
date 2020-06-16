// import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:hupu/views/home/commentList.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xiaoqiu_sport/api/request_hupu.dart';
// import '../../utils/LogUtil.dart';

class NewsDetail extends StatefulWidget {
  NewsDetail({Key key, this.id}) : super(key: key);
  final String id;

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  var requestHupu = RequestHupu();
  var title = '';
  var content = '';
  var videohtml ='''
  <!DOCTYPE html>
<html lang="zh-CN">
 <head> 
  <meta charset="gb2312" /> 
  <title>【莫斯科中央陸軍U21VSMBA莫斯科U21】篮球赛事直播_VTB青年聯合賽联赛 - 咪播体育</title> 
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" /> 
  <link rel="stylesheet" href="https://v1.res.qqb0217.com/static/layui/css/layui.css?v=20200217-1" /> 
  <link rel="stylesheet" href="https://v1.res.qqb0217.com/static/web/css/live.css?v=20200217-1" /> 
 </head> 
 <body> 
  <div class="web_content"> 
<!--    <div class="web_body"> 
          <div class="boxouter"> 
           <div class="box"> --> 
      <div class="sub_box"> 
       <video id="myplayer" class="sub_player" src="" webkit-playsinline="" playsinline="" x5-playsinline="" x-webkit-airplay="allow" controls="" preload="" autoplay=""></video> 
       <input type="hidden" id="play_url" value="aHR0cHM6Ly9qZHkueHlnanguY29tL2xpdmUvcDQ2c3RyZWFtMzU1MDg2OS5tM3U4P3R4U2VjcmV0PTAyZDQ1OGMzMDc4NDFmNTFjMGUxNDJjYzUxYWI5OWNlJnR4VGltZT01ZTVmOWYwZA==" /> 
      </div> 
      </div> 
    <!--</div> 
   </div> 
  </div>  --> 
  <script src="https://v1.res.qqb0217.com/static/web/js/jquery.min.js?v=20200217-1"></script> 
<!--   <script src="https://v1.res.qqb0217.com/static/layui/layui.all.js?v=20200217-1"></script> --> 
  <script src="https://v1.res.qqb0217.com/static/web/js/jsdelivr.net_npm_hls.js?v=20200217-1"></script> 
<!-- <script src="https://v1.res.qqb0217.com/static/web/js/jianfan.js?v=20200217-1"></script>  -->
  <script src="https://v1.res.qqb0217.com/static/web/js/common.js?v=20200217-1"></script>
 </body>
</html>
  ''';

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future _getData() async {
    var result = await RequestHupu.getNewsDetail(id: widget.id);
    var _title = result['title'];
    var _content = result['offline_data']['data']['content'];
    var index = _content.indexOf('来源');
    if (index != -1) {
      _content = _content.substring(0, index);
    }
    _content = _content.replaceAll("data-origin", "src");
    _content = _content.replaceAll("data-gif", "src");
    // LogUtil.e(_content);
    setState(() {
      title = _title;
      content = _content;
      // content= videohtml;
      // print(content);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            // color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
          actions: <Widget>[
            IconButton(
              // color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.more_horiz),
            ),
          ],
          elevation: 0.0,
          // title: Text(title),
          // brightness: Brightness.light,
        ),
        body: Container(
            color: Colors.white,
            child: ListView(children: <Widget>[
              Container(
                child: Text(title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify),
                padding: EdgeInsets.all(10),
              ),
              Html(
                data: content,
                // padding: EdgeInsets.all(10),
                // defaultTextStyle: TextStyle(fontSize: 18, height: 1.5),
                onLinkTap: (url) async {
                  url = url.substring(10);
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    print(url);
                  }
                },
              ),
              // CommentList(id: widget.id)
            ])));
  }
}
