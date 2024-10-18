import 'package:junglee_news/model/article_list_model.dart';
import 'package:junglee_news/services/database/db_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/article_model.dart';

class ArticleListTable {
  static const String tableName = 'article_list';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
  static const String intType = 'INTEGER NOT NULL';
  static const String id = "_id";
  static const String title = "title";
  static const String url = "url";
  static const String thumbnail = "thumbnail";
  static const String date = "date";
  static const String authors = "authors";

  static void insert(Article data) async {
    Database db = await DBHelper.getInstance.getDb();
    db.insert(tableName, {
      title: data.title,
      url: data.url,
      thumbnail: data.thumbnail,
      date: data.date,
      authors: data.authors != null ? data.authors![0] : null,
    });
  }

  static Future<ArticleList> selectAll() async {
    Database db = await DBHelper.getInstance.getDb();
    final data = await db.rawQuery(
        "SELECT ${ArticleListTable.title}, ${ArticleListTable.url}, ${ArticleListTable.thumbnail}, ${ArticleListTable.date}, ${ArticleListTable.authors} FROM ${ArticleListTable.tableName}");
    List<Article> list = [];
    for(int i =0;i<data.length;i++){
      list.add(Article.fromJson(data[i]));
    }
    // data.forEach((value) {
    //   list.add(Article.fromJson(value));
    // });
    return ArticleList(data: list);
  }

  static void deleteAll() async {
    Database db = await DBHelper.getInstance.getDb();
    await db.rawDelete("DELETE FROM $tableName");
  }
}
