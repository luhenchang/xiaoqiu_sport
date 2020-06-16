import 'package:flutter/material.dart';
import 'package:xiaoqiu_sport/model/news.dart';
// import 'package:flutter_demo/views/web_page/WebViewPage.dart';
import 'package:xiaoqiu_sport/resources/sports_color.dart';
import 'news_detail.dart';

class NewsItem extends StatelessWidget {
  // final News news;
  // const NewsItem(this.news);
  final News news;
  NewsItem({Key key, this.news}) : super(key: key);

  _jumpToNews(BuildContext context, String id) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewsDetail(id: id)));
  }

  @override
  Widget build(BuildContext context) {
    // child: GestureDetector(
//        onTap: () {
//          Navigator.push(
//            context,
//            MaterialPageRoute(
//                builder: (context) => WebViewPage(news.jumpUrl, news.title)),
//          );
//        },
    return GestureDetector(
        onTap: () => _jumpToNews(context, news.link.substring(19, 27)),
        child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              children: <Widget>[
                Expanded(
                  // flex: 1,
                  child: Column(
                    children: <Widget>[
                      Text(
                        news.title,
                        style: TextStyle(fontSize: 16),
                        maxLines: 2,
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: <Widget>[
                          Icon(Icons.comment, size: 16.0, color: SportsColor.gray),
                          SizedBox(width: 5),
                          Text(news.replies,
                              style: TextStyle(color: SportsColor.gray)),
                          SizedBox(width: 20),
                          Icon(Icons.thumb_up, size: 16.0, color: SportsColor.gray),
                          SizedBox(width: 5),
                          Text(news.lights,
                              style: TextStyle(color: SportsColor.gray))
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(width: 6),
                Image.network(
                  news.img,
                  width: 95,
                  height: 76,
                  fit: BoxFit.cover,
                )
              ],
            )));
  }
}
