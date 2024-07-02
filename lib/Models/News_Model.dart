class News {
  String? id;
  String? type;
  String? created;
  String? updated;
  String? title;
  String? byline;
  String? credit;
  Content? content;
  String? dateline;

  News(
      {this.id,
      this.type,
      this.created,
      this.updated,
      this.title,
      this.byline,
      this.credit,
      this.content,
      this.dateline});

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    created = json['created'];
    updated = json['updated'];
    title = json['title'];
    byline = json['byline'];
    credit = json['credit'];
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
    dateline = json['dateline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['title'] = this.title;
    data['byline'] = this.byline;
    data['credit'] = this.credit;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    data['dateline'] = this.dateline;
    return data;
  }
}

class Content {
  String? long;

  Content({this.long});

  Content.fromJson(Map<String, dynamic> json) {
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['long'] = this.long;
    return data;
  }
}
