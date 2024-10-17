import 'package:sqflite/sqflite.dart';

import '../../../model/article_list_model.dart';
import '../../../model/article_model.dart';
import 'article_list_table.dart';
import '../db_helper.dart';

class SavedArticlesTable {
  static const String tableName = 'saved_articles_table';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
  static const String intType = 'INTEGER NOT NULL';
  static const String id = "_id";
  static const String title = "title";
  static const String url = "url";
  static const String thumbnail = "thumbnail";
  static const String date = "date";
  static const String excerpt = "excerpt";
  static const String language = "language";
  static const String content = "content";
  static const String authors = "authors";

  static void insert(Article data) async {
    Database db = await DBHelper.getInstance.getDb();
    db.insert(tableName, {
      title: data.title,
      url: data.url,
      thumbnail: data.thumbnail,
      date: data.date,
      excerpt: data.excerpt,
      language: data.language,
      content: data.content,
      authors: data.authors != null ? data.authors![0] : null,
    });
  }

  static Future<ArticleList> selectAll() async {
    Database db = await DBHelper.getInstance.getDb();
    final data = await db.rawQuery(
        "SELECT ${SavedArticlesTable.id}, ${SavedArticlesTable.thumbnail}, ${SavedArticlesTable.title}, ${SavedArticlesTable.date}, ${SavedArticlesTable.authors} FROM ${SavedArticlesTable.tableName}");
    List<Article> list = [];
    data.forEach((value) {
      list.add(Article.fromJson(value));
    });
    return ArticleList(data: list);
  }

  static Future<Article?> selectArticle(String articleId) async {
    Database db = await DBHelper.getInstance.getDb();
    try {
      final data = await db.rawQuery(
          "SELECT * FROM ${SavedArticlesTable.tableName} WHERE _id = $articleId");
      if (data.length > 0) {
        return Article.fromJson(data[0]);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static void deleteAll() async {
    Database db = await DBHelper.getInstance.getDb();
    final data = await db.rawDelete("DELETE FROM $tableName");
  }

  static void delete(String id) async {
    Database db = await DBHelper.getInstance.getDb();
    await db.rawDelete("Delete from $tableName where _id = $id");
  }
}
