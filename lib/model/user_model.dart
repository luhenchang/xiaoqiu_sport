class User {
  String id;
  String mobile;
  String nick;
  String headUrl;
  String desc;
  String gender;
  String followCount;
  String fansCount;


  User(
      {this.id,
        this.mobile,
        this.nick,
        this.headUrl,
        this.desc,
        this.gender,
        this.followCount,
        this.fansCount
        });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobile = json['mobile'];
    nick = json['nick'];
    headUrl = json['headurl'];
    desc = json['desc'];
    gender = json['gender'];
    followCount = json['followCount'];
    fansCount = json['fansCount'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mobile'] = this.mobile;
    data['nick'] = this.nick;
    data['headUrl'] = this.headUrl;
    data['desc'] = this.desc;
    data['gender'] = this.gender;
    data['followCount'] = this.followCount;
    data['fansCount'] = this.fansCount;

    return data;
  }
}