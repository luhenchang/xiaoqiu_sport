import 'package:flutter/material.dart';
import 'package:xiaoqiu_sport/model/match_lq.dart';
import 'package:xiaoqiu_sport/resources/sports_color.dart';
import 'package:common_utils/common_utils.dart';

class MatchLqItem extends StatelessWidget {
  final MatchLq match;
//  final Item item;
  MatchLqItem({Key key, this.match}) : super(key: key);

  // _jumpToNews(BuildContext context, String id) {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => NewsDetail(id: id)));
  // }

  @override
  Widget build(BuildContext context) {
    String matchTime = DateUtil.formatDateMs(match.matchTime * 1000,
        format: DateFormats.mo_d_h_m);
    String leagueTime = match.sclassName ?? '';
    String stateName = match.stateName;
    String homeTeam = match.homeTeam;
    String homeOne = match.homeOne != null ? match.homeOne.toString():'';
    String homeTwo = match.homeTwo != null ? match.homeTwo.toString():'';
    String homeThree = match.homeThree != null ? match.homeThree.toString():'';
    String homeFour = match.homeFour != null ? match.homeFour.toString():'';
    String homeOt = match.homeOt != null ? match.homeOt.toString():'';
    String homeScore = match.homeScore != null ? match.homeScore.toString():'0';
    String guestTeam = match.guestTeam.toString();
    String guestOne = match.guestOne != null ? match.guestOne.toString():'';
    String guestTwo = match.guestTwo != null ? match.guestTwo.toString():'';
    String guestThree = match.guestThree != null ? match.guestThree.toString():'';
    String guestFour = match.guestFour != null ? match.guestFour.toString():'';
    String guestOt = match.guestOt != null ? match.guestOt.toString():'';
    String guestScore = match.guestScore != null ? match.guestScore.toString():'0';
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 8, 8, 12),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 0),
              height: 15,
              // color: Colors.black38,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 80,
                    child: Text(matchTime,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ),
                  // SizedBox(width: 12,),
                  Container(
                      width: 70,
                      child: Text(leagueTime,
                        style: TextStyle(fontSize: 12),
                      )),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(stateName,
                        style: TextStyle(fontSize: 12, color: Colors.black54)),
                  )
                ],
              ),
            ),
            Divider(
              // height:3.0,
              thickness: 1,
              color: SportsColor.lightGray,
              indent: 0.0,
            ),
            Row(children: <Widget>[
              Container(
                  width: 150,
                  child: Text(
                    homeTeam,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: SportsColor.darkGray),
                  )),
              SizedBox(width: 4),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  //交叉轴的布局方式，对于column来说就是水平方向的布局方式
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //就是字child的垂直布局方向，向上还是向下
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Container(
                      width: 24,
                      alignment: Alignment.center,
                      child: Text(homeOne,
                          style: TextStyle(color: Colors.black54)),
                    ),
                    Container(
                      width: 24,
                      alignment: Alignment.center,
                      child: Text(homeTwo,
                          style: TextStyle(color: Colors.black54)),
                    ),
                    Container(
                      width: 24,
                      alignment: Alignment.center,
                      child: Text(homeThree,
                          style: TextStyle(color: Colors.black54)),
                    ),
                    Container(
                      width: 24,
                      alignment: Alignment.center,
                      child: Text(homeFour,
                          style: TextStyle(color: Colors.black54)),
                    ),
                    Container(
                      width: 24,
                      alignment: Alignment.center,
                      child: Text(homeOt,
                          style: TextStyle(color: Colors.black54)),
                    ),
                    // Container(
                    //   child: SizedBox(width: 4,),
                    // ),
                    Container(
                        width: 26,
                        alignment: Alignment.center,
                        child: Text(
                          homeScore,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: SportsColor.secondary),
                        )),
                  ],
                ),
              )
            ]),
            SizedBox(height: 6),
            Row(
              children: <Widget>[
                Container(
                    width: 150,
                    child: Text(
                      guestTeam,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: SportsColor.darkGray),
                    )),
                SizedBox(width: 4),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  //交叉轴的布局方式，对于column来说就是水平方向的布局方式
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //就是字child的垂直布局方向，向上还是向下
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Container(
                      width: 24,
                      alignment: Alignment.center,
                      child: Text(guestOne,
                          style: TextStyle(color: Colors.black54)),
                    ),
                    Container(
                      width: 24,
                      alignment: Alignment.center,
                      child: Text(guestTwo,
                          style: TextStyle(color: Colors.black54)),
                    ),
                    Container(
                      width: 24,
                      alignment: Alignment.center,
                      child: Text(guestThree,
                          style: TextStyle(color: Colors.black54)),
                    ),
                    Container(
                      width: 24,
                      alignment: Alignment.center,
                      child: Text(guestFour,
                          style: TextStyle(color: Colors.black54)),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 24,
                      child: Text(guestOt,
                          style: TextStyle(color: Colors.black54)),
                    ),
                    // Container(
                    //   child: SizedBox(width: 4,),
                    // ),
                    Container(
                        width: 26,
                        alignment: Alignment.center,
                        child: Text(guestScore,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: SportsColor.secondary)))
                  ],
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
