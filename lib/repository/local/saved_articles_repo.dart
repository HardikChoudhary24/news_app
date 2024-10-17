import 'package:junglee_news/model/article_list_model.dart';
import 'package:junglee_news/repository/local/local_base_repo.dart';
import 'package:junglee_news/services/database/db_helper.dart';
import 'package:junglee_news/services/database/schema/saved_articles_table.dart';

import '../../model/article_model.dart';

class SavedArticlesRepo implements LocalBaseRepo<ArticleList> {
  @override
  DBHelper get dbHelper => DBHelper.getInstance;

  @override
  Future<ArticleList> fetchAll() async {
    ArticleList data = await SavedArticlesTable.selectAll();
    print("this is in local repo");
    print(data.data![0].url);
    return data;
  }

  @override
  void insertData(Article data) async {
    SavedArticlesTable.insert(data);
  }

  @override
  Future<Article?> fetchSingle(String id) async {
    Article? data = await SavedArticlesTable.selectArticle(id);
    return data;
  }

  @override
  void deleteData(String id) async {
    SavedArticlesTable.delete(id);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
