import 'package:junglee_news/model/article_model.dart';

class ArticleList {
  bool? success;
  List<Article>? data;
  int? size;
  int? totalHits;
  int? hitsPerPage;
  int? page;
  int? totalPages;
  int? timeMs;

  ArticleList(
      {this.success,
      this.data,
      this.size,
      this.totalHits,
      this.hitsPerPage,
      this.page,
      this.totalPages,
      this.timeMs});

  ArticleList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Article>[];
      json['data'].forEach((v) {
        data!.add(new Article.fromJson(v));
      });
    }
    size = json['size'];
    totalHits = json['totalHits'];
    hitsPerPage = json['hitsPerPage'];
    page = json['page'];
    totalPages = json['totalPages'];
    timeMs = json['timeMs'];
  }
}
