class Article {
  String? id;
  String? title;
  String? url;
  String? excerpt;
  String? thumbnail;
  String? language;
  String? content;
  bool? paywall;
  int? contentLength;
  String? date;
  List<String>? authors;
  Publisher? publisher;

  Article(
      {this.id,
      this.title,
      this.url,
      this.excerpt,
      this.thumbnail,
      this.language,
      this.paywall,
      this.content,
      this.contentLength,
      this.date,
      this.authors,
      this.publisher});

  Article.fromJson(Map<String, dynamic> json) {
    id = json['_id']?.toString();
    title = json['title'];
    url = json['url'];
    excerpt = json['excerpt'];
    thumbnail = json['thumbnail'];
    language = json['language'];
    content = json['content'];
    paywall = json['paywall'];
    contentLength = json['contentLength'];
    date = json['date'];
    if (json['authors'] != null) {
      authors = [];
      if (json['authors'] is String) {
        authors!.add(json['authors']);
      } else {
        json['authors'].forEach((value) {
          authors!.add(value);
        });
      }
    }
    publisher = json['publisher'] != null
        ? new Publisher.fromJson(json['publisher'])
        : null;
  }
}

class Publisher {
  String? name;
  String? url;
  String? favicon;

  Publisher({this.name, this.url, this.favicon});

  Publisher.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    favicon = json['favicon'];
  }
}
