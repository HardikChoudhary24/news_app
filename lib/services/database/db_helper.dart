import 'dart:io';

import 'package:junglee_news/services/database/schema/article_list_table.dart';
import 'package:junglee_news/services/database/schema/saved_articles_table.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Database? _myDb;
  final int _dbVersion = 1;

  DBHelper._();

  static final DBHelper getInstance = DBHelper._();

  Future<Database> openDb() async {
    Directory appDir = await getApplicationDocumentsDirectory();

    String dbPath = join(appDir.path, "jungleeNewsDb.db");

    _myDb = await openDatabase(dbPath, onCreate: (db, version) {
      db.execute(
        "Create table ${ArticleListTable.tableName} (${ArticleListTable.id} INTEGER PRIMARY KEY AUTOINCREMENT, ${ArticleListTable.url} TEXT, ${ArticleListTable.title} TEXT, ${ArticleListTable.thumbnail} TEXT, ${ArticleListTable.date} Text, ${ArticleListTable.authors} TEXT)",
      );
      print("Table created  ${ArticleListTable.tableName}");
      db.execute(
        "Create table ${SavedArticlesTable.tableName} (${SavedArticlesTable.id} INTEGER PRIMARY KEY AUTOINCREMENT, ${SavedArticlesTable.url} TEXT , ${SavedArticlesTable.title} TEXT, ${SavedArticlesTable.content} TEXT, ${SavedArticlesTable.authors} TEXT, ${SavedArticlesTable.excerpt} Text, ${SavedArticlesTable.thumbnail} Text, ${SavedArticlesTable.date} Text, ${SavedArticlesTable.language} VARCHAR(4))",
      );
    }, version: _dbVersion);
    return _myDb!;
  }

  Future<Database> getDb() async {
    _myDb ??= await openDb();
    return _myDb!;
  }
}
