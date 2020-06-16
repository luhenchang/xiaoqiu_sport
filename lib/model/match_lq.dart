class MatchLq {
  static Map<int, String> state = {
    0: '未开',
    1: '第1节',
    2: '第2节',
    3: '第3节',
    4: '第4节',
    5: '1OT',
    6: '2OT',
    7: '3OT',
    -1: '完场',
    50: '中场',
    -2: '待定',
    -3: '中断',
    -4: '取消',
    -5: '推迟',
    -6: '异常',
    -10: '错误'
  };
  int matchID;
  int id;
  int sclassID;
  String sclassName;
  String matchSeason;
  int matchTime;
  int matchState;
  String stateName;
  int matchKind;
  String remainTime;
  int homeTeamID;
  int guestTeamID;
  String homeTeam;
  String guestTeam;
  int homeScore;
  int guestScore;
  int homeHalf;
  int guestHalf;
  int homeOne;
  int homeTwo;
  int homeThree;
  int homeFour;
  int guestOne;
  int guestTwo;
  int guestThree;
  int guestFour;
  int homeAddTime1;
  int homeAddTime2;
  int homeAddTime3;
  int homeAddTime4;
  int homeAddTime5;
  int guestAddTime1;
  int guestAddTime2;
  int guestAddTime3;
  int guestAddTime4;
  int guestAddTime5;
  int homeOt;
  int guestOt;

//  News(this.title, this.imageUrl, [this.nid, this.jumpUrl= jumpUrl??'']);
  MatchLq(
      int matchID,
      int id,
      int sclassID,
      String sclassName,
      String matchSeason,
      int matchTime,
      int matchState,
      String stateName,
      int matchKind,
      String remainTime,
      int homeTeamID,
      int guestTeamID,
      String homeTeam,
      String guestTeam,
      int homeScore,
      int guestScore,
      int homeHalf,
      int guestHalf,
      int homeOne,
      int homeTwo,
      int homeThree,
      int homeFour,
      int guestOne,
      int guestTwo,
      int guestThree,
      int guestFour,
      int homeAddTime1,
      int homeAddTime2,
      int homeAddTime3,
      int homeAddTime4,
      int homeAddTime5,
      int guestAddTime1,
      int guestAddTime2,
      int guestAddTime3,
      int guestAddTime4,
      int guestAddTime5,
      int homeOt,
      int guestOt) {
    this.matchID = matchID;
    this.id = id;
    this.sclassID = sclassID;
    this.sclassName = sclassName;
    this.matchSeason = matchSeason;
    this.matchTime = matchTime;
    this.matchState = matchState;
    this.stateName = stateName;
    this.matchKind = matchKind;
    this.remainTime = remainTime;
    this.homeTeamID = homeTeamID;
    this.guestTeamID = guestTeamID;
    this.homeTeam = homeTeam;
    this.guestTeam = guestTeam;
    this.homeScore = homeScore;
    this.guestScore = guestScore;
    this.homeHalf = homeHalf;
    this.guestHalf = guestHalf;
    this.homeOne = homeOne;
    this.homeTwo = homeTwo;
    this.homeThree = homeThree;
    this.homeFour = homeFour;
    this.guestOne = guestOne;
    this.guestTwo = guestTwo;
    this.guestThree = guestThree;
    this.guestFour = guestFour;
    this.homeAddTime1 = homeAddTime1;
    this.homeAddTime2 = homeAddTime2;
    this.homeAddTime3 = homeAddTime3;
    this.homeAddTime4 = homeAddTime4;
    this.homeAddTime5 = homeAddTime5;
    this.guestAddTime1 = guestAddTime1;
    this.guestAddTime2 = guestAddTime2;
    this.guestAddTime3 = guestAddTime3;
    this.guestAddTime4 = guestAddTime4;
    this.guestAddTime5 = guestAddTime5;
    this.homeOt = homeOt;
    this.guestOt = guestOt;
  }

  MatchLq.fromJson(Map json) {
    this.matchID = json['matchID'];
    this.id = json['id'];
    this.sclassID = json['sclassID'];
    this.sclassName = json['sclassName'];
    this.matchSeason = json['matchSeason'];
    this.matchTime = json['matchTime'];
    this.matchState = json['matchState'];
    this.stateName = state[json['matchState']];
    this.matchKind = json['matchKind'];
    this.remainTime = json['remainTime'];
    this.homeTeamID = json['homeTeamID'];
    this.guestTeamID = json['guestTeamID'];
    this.homeTeam = json['homeTeam'];
    this.guestTeam = json['guestTeam'];
    this.homeScore = json['homeScore'];
    this.guestScore = json['guestScore'];
    this.homeHalf = json['homeHalf'];
    this.guestHalf = json['guestHalf'];
    this.homeOne = json['homeOne'];
    this.homeTwo = json['homeTwo'];
    this.homeThree = json['homeThree'];
    this.homeFour = json['homeFour'];
    this.guestOne = json['guestOne'];
    this.guestTwo = json['guestTwo'];
    this.guestThree = json['guestThree'];
    this.guestFour = json['guestFour'];

//    this.homeAddTime1 = json['homeAddTime1'];
//    this.homeAddTime2 = json['homeAddTime2'];
//    this.homeAddTime3 = json['homeAddTime3'];
//    this.homeAddTime4 = json['homeAddTime4'];
//    this.homeAddTime5 = json['homeAddTime5'];
//    this.guestAddTime1 = json['guestAddTime1'];
//    this.guestAddTime2 = json['guestAddTime2'];
//    this.guestAddTime3 = json['guestAddTime3'];
//    this.guestAddTime4 = json['guestAddTime4'];
//    this.guestAddTime5 = json['guestAddTime5'];

    this.homeAddTime1 = json['homeAddTime1'] ?? 0;
    this.homeAddTime2 = json['homeAddTime2'] ?? 0;
    this.homeAddTime3 = json['homeAddTime3'] ?? 0;
    this.homeAddTime4 = json['homeAddTime4'] ?? 0;
    this.homeAddTime5 = json['homeAddTime5'] ?? 0;
    this.guestAddTime1 = json['guestAddTime1'] ?? 0;
    this.guestAddTime2 = json['guestAddTime2'] ?? 0;
    this.guestAddTime3 = json['guestAddTime3'] ?? 0;
    this.guestAddTime4 = json['guestAddTime4'] ?? 0;
    this.guestAddTime5 = json['guestAddTime5'] ?? 0;

    if ((json['homeAddTime1'] != null) || (json['guestAddTime1'] != null)) {
      this.homeOt = this.homeAddTime1 +
          this.homeAddTime2 +
          this.homeAddTime3 +
          this.homeAddTime4 +
          this.homeAddTime5;
      this.guestOt = this.guestAddTime1 +
          this.guestAddTime2 +
          this.guestAddTime3 +
          this.homeAddTime4 +
          this.guestAddTime5;
    }
//     this.homeOt = (json['homeAddTime1']??0) + (json['homeAddTime2']??0) + (json['homeAddTime3']??0 )
//     +(json['homeAddTime4']) + (json['homeAddTime5']??0);
//     this.guestOt = (json['guestAddTime1']??0) + (json['guestAddTime2']??0) + (json['guestAddTime3']??0 )
//     +(json['guestAddTime4']) + (json['guestAddTime5']??0);
  }

  Map<String, dynamic> toJson() {
    return {
      'matchID': matchID,
      'id': id,
      'sclassID': sclassID,
      'sclassName': sclassName,
      'matchSeason': matchSeason,
      'matchTime': matchTime,
      'matchState': matchState,
      'stateName': stateName,
      'remainTime': remainTime,
      'matchKind': matchKind,
      'homeTeamID': homeTeamID,
      'guestTeamID': guestTeamID,
      'homeTeam': homeTeam,
      'iguestTeamd': guestTeam,
      'homeScore': homeScore,
      'guestScore': guestScore,
      'homeHalf': homeHalf,
      'guestHalf': guestHalf,
      'homeOne': homeOne,
      'homeTwo': homeTwo,
      'homeThree': homeThree,
      'homeFour': homeFour,
      'guestOne': guestOne,
      'guestTwo': guestTwo,
      'guestThree': guestThree,
      'guestFour': guestFour,
      'homeAddTime1': homeAddTime1,
      'homeAddTime2': homeAddTime2,
      'homeAddTime3': homeAddTime3,
      'homeAddTime4': homeAddTime4,
      'homeAddTime5': homeAddTime5,
      'guestAddTime1': guestAddTime1,
      'guestAddTime2': guestAddTime2,
      'guestAddTime3': guestAddTime3,
      'guestAddTime4': guestAddTime4,
      'guestAddTime5': guestAddTime5,
      'homeOt': homeOt,
      'guestOt': guestOt
    };
  }
}
