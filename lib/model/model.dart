class Item {
  int id;
  String title;
  int points;
  String user;
  int time;
  String timeAgo;
  int commentsCount;
  String type;
  String url;
  String domain;

  Item(
      {this.id,
        this.title,
        this.points,
        this.user,
        this.time,
        this.timeAgo,
        this.commentsCount,
        this.type,
        this.url,
        this.domain});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    points = json['points'];
    user = json['user'];
    time = json['time'];
    timeAgo = json['time_ago'];
    commentsCount = json['comments_count'];
    type = json['type'];
    url = json['url'];
    domain = json['domain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['points'] = this.points;
    data['user'] = this.user;
    data['time'] = this.time;
    data['time_ago'] = this.timeAgo;
    data['comments_count'] = this.commentsCount;
    data['type'] = this.type;
    data['url'] = this.url;
    data['domain'] = this.domain;
    return data;
  }
}
