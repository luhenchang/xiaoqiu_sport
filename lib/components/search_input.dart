import 'package:flutter/material.dart';
import 'package:xiaoqiu_sport/resources/sports_color.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.0,
      decoration: BoxDecoration(
          color: SportsColor.paper, borderRadius: BorderRadius.circular(12)),
      child: new Row(
        crossAxisAlignment:CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 4, left: 8),
            child: new Icon(Icons.search, size: 24, color: SportsColor.darkGray),
          ),
          Expanded(
            child: new TextField(
              style: TextStyle(fontSize: 14, color: SportsColor.gray),
              decoration: InputDecoration(
                hintStyle: TextStyle(color: SportsColor.gray),
                hintText: '火箭总冠军',
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}