class News {
  String nid;
  String title;
  String img;
  String detailUrl;
  String link;
  String lights;
  String replies; 

//  News(this.title, this.imageUrl, [this.nid, this.jumpUrl= jumpUrl??'']);
  News(String title, String img, [String nid, String detailUrl,String link, String lights,
  String replies ]){
    this.title = title;
    this.img= img;
    this.nid =nid;
    this.detailUrl = detailUrl??'';
    this.link = link??'';
    this.lights = lights??'';
    this.replies = replies??'';
  }
  News.fromJson(Map json) {
    nid = json['nid'];
    title = json['title'];
    img = json['img'];
    detailUrl = json['detailUrl']??'';
    link = json['link'];
    lights = json['lights'];
    replies = json['replies'];
    
  }

  Map<String, dynamic> toJson() {
    return {
      'nid': nid,
      'title': title,
      'img': img,
      'detailUrl':detailUrl,
      'link':link,
      'lights':lights,
      'replies':replies
    };
  }
}
