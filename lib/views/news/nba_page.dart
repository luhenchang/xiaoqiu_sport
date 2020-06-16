import 'package:flutter/material.dart';
import 'package:xiaoqiu_sport/api/request_hupu.dart';
import 'package:xiaoqiu_sport/model/news.dart';
import 'package:xiaoqiu_sport/components/toast.dart';
// import 'dart:convert'
import 'package:xiaoqiu_sport/views/news/news_item.dart';

class NbaPage extends StatefulWidget {
  NbaPage({Key key}) : super(key: key);

  @override
  _NbaPageState createState() => _NbaPageState();
}

class _NbaPageState extends State<NbaPage> {
  // List<Competition> competitions = new List();
  // List<Video> videos = new List();
  List<News> newsList = new List();
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;
  var nid = 0;

  //hupu data
  Future getDataHupu() async {
    try {
      var hupuResponse = await RequestHupu.getNewsList();
      List articleResponse = hupuResponse['result']['data'];
      // print(json.encode(hupuResponse));
      // nid = int.parse(articleResponse[articleResponse.length - 1]['nid']);
      if (!mounted) return;
      setState(() {
        newsList = [];
        newsList
            .addAll(articleResponse.map((e) => new News.fromJson(e)).toList());
      });
    } catch (e) {
      ToastUtil.showError(e.toString());
    }
  }

//  hupu加载更多
  Future _getMoreHupu() async {
    try {
      if (!isLoading) {
        isLoading = true;
        var result = await RequestHupu.getNewsList(nid: nid);
        List articleResponse = result['result']['data'];
        nid = int.parse(articleResponse[articleResponse.length - 1]['nid']);
        setState(() {
          newsList
              .addAll(articleResponse.map((e) => News.fromJson(e)).toList());
        });
        isLoading = false;
      }
    } catch (e) {
      ToastUtil.showError(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
//    getDataMock();
    getDataHupu();
    _scrollController.addListener(listener);
  }

  listener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _getMoreHupu();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Widget _getLoadMoreWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Row(
        children: <Widget>[
          Container(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(strokeWidth: 2)),
          // Container(
          //   padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          //   child: Text('加载更多'),
          // )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Widget _renderRow(context, index) {
    if (index < newsList.length) {
      // if(index == 0) {
      //   return _getTopWidget();
      // }
      return Container(
        child: NewsItem(news: newsList[index]),
//        padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
        // padding: EdgeInsets.fromLTRB(16, 4, 6, 10),
      );
    } else if (index > 0) {
      return _getLoadMoreWidget();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        // child: ListView(
        //   controller: _scrollController,
        //   children: newsList.map((e) => NewsItem(news: e)).toList(),
        // )
        onRefresh: getDataHupu,
        child: ListView.separated(
          controller: _scrollController,
          itemCount: newsList.length + 1,
          itemBuilder: _renderRow,
          separatorBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Divider(height: 0.5));
          },
        )
//      ListView.builder(
//      itemCount: newsList.length + 1,
//      itemBuilder: _renderRow,
//      controller: _scrollController,
//    )
        );
  }
}

//mock data
// getDataMock() async {
//   try {
//     List articleResponse =
//         await RequestMock.post(action: 'article', params: {});
//     setState(() {
//       newsList
//           .addAll(articleResponse.map((e) => new News.fromJson(e)).toList());
//     });
//   } catch (e) {
//     Toast.show(e.toString());
//   }
// }
//mock
// _getMore() async {
//   try {
//     if (newsList.length < 20) {
//       List articleResponse =
//           await RequestMock.post(action: 'more', params: {});
//       setState(() {
//         newsList.addAll(
//             articleResponse.map((e) => new News.fromJson(e)).toList());
//       });
//     } else {
//       setState(() {
//         isLoading = true;
//       });
//     }
//   } catch (e) {
//     Toast.show(e.toString());
//   }
// }
