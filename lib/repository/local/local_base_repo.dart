import 'package:junglee_news/model/article_model.dart';
import 'package:junglee_news/services/database/db_helper.dart';

import '../../model/article_list_model.dart';

abstract class LocalBaseRepo<T> {
  DBHelper get dbHelper;

  Future<T> fetchAll();
  Future fetchSingle(String id);
  insertData(Article data);
  deleteData(String id);
  void cache(T list);
}
