class Group {
  int infoType;
  String typeName;
  int groupby;
  List<Country> countrys;
  List<League> leagues;
  Group(this.countrys);
  Group.fromJson(Map json) {
    infoType = json['infoType'];
    typeName = json['typeName'];
    groupby = json['groupby'];
    if (groupby == 1) {
      countrys = new List<Country>();
      (json['countrys'] as List).forEach((v) {
        countrys.add(new Country.fromJson(v));
      });
    }
    if (groupby == 0){
      leagues = new List<League>();
      (json['leagues'] as List).forEach((v) {
        leagues.add(new League.fromJson(v));
      });
    }

//    if (json['result']['list'] != null) {
//      countrys = new List<Country>();
//      (json['result']['list']['countrys'] as List).forEach((v) {
//        countrys.add(new Country.fromJson(v));
//      });
  }
}

class Country {
  int infoID;
  int infoType;
  String nameCN;
  String regionName;
  List<League> leagues;
//  # 2 美洲 3 亚洲 1 欧洲 6 国际赛事
  static Map<int, String> region = {1: '欧洲', 2: '美洲', 3: '亚洲', 6: '国际'};
  Country(
      {this.infoID, this.infoType, this.nameCN, this.regionName, this.leagues});

  Country.fromJson(Map json) {
    this.infoID = json['infoID'];
    this.infoType = json['infoType'];
    this.nameCN = json['nameCN'];
    this.regionName = region[this.infoType];
    if (json['leagues'] != null) {
      leagues = new List<League>();
      (json['leagues'] as List).forEach((v) {
        leagues.add(new League.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['infoID'] = this.infoID;
    data['infoType'] = this.infoType;
    data['nameCN'] = this.nameCN;
    if (this.leagues != null) {
      data['articles'] = this.leagues.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class League {
  int sclassID;
  String nameSh;
  League({this.sclassID, this.nameSh});

  League.fromJson(Map json) {
    this.sclassID = json['sclassID'];
    this.nameSh = json['name_sh'];
  }
  Map<String, dynamic> toJson() {
    return {'sclassID': this.sclassID, 'name_sh': this.nameSh};
  }
}
