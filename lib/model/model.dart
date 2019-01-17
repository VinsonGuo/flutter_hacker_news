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


class ArticleDetail {
  String title;
  String content;
  String datePublished;
  String leadImageUrl;
  String dek;
  String url;
  String domain;
  String excerpt;
  int wordCount;
  String direction;
  int totalPages;
  int renderedPages;
  String nextPageUrl;

  ArticleDetail(
      {this.title,
        this.content,
        this.datePublished,
        this.leadImageUrl,
        this.dek,
        this.url,
        this.domain,
        this.excerpt,
        this.wordCount,
        this.direction,
        this.totalPages,
        this.renderedPages,
        this.nextPageUrl});

  ArticleDetail.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    datePublished = json['date_published'];
    leadImageUrl = json['lead_image_url'];
    dek = json['dek'];
    url = json['url'];
    domain = json['domain'];
    excerpt = json['excerpt'];
    wordCount = json['word_count'];
    direction = json['direction'];
    totalPages = json['total_pages'];
    renderedPages = json['rendered_pages'];
    nextPageUrl = json['next_page_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['date_published'] = this.datePublished;
    data['lead_image_url'] = this.leadImageUrl;
    data['dek'] = this.dek;
    data['url'] = this.url;
    data['domain'] = this.domain;
    data['excerpt'] = this.excerpt;
    data['word_count'] = this.wordCount;
    data['direction'] = this.direction;
    data['total_pages'] = this.totalPages;
    data['rendered_pages'] = this.renderedPages;
    data['next_page_url'] = this.nextPageUrl;
    return data;
  }

  @override
  String toString() {
    return 'ArticleDetail{title: $title, content: $content, datePublished: $datePublished, leadImageUrl: $leadImageUrl, dek: $dek, url: $url, domain: $domain, excerpt: $excerpt, wordCount: $wordCount, direction: $direction, totalPages: $totalPages, renderedPages: $renderedPages, nextPageUrl: $nextPageUrl}';
  }


}

