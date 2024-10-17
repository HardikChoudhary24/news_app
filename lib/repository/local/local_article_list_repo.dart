import 'package:junglee_news/model/article_list_model.dart';
import 'package:junglee_news/repository/local/local_base_repo.dart';
import 'package:junglee_news/services/database/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/database/schema/article_list_table.dart';

class LocalArticleListRepo implements LocalBaseRepo<ArticleList> {
  @override
  DBHelper get dbHelper => DBHelper.getInstance;

  @override
  void cache(ArticleList list) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? lastUsedTimestamp = pref.getString('last_used_timestamp');

    if (lastUsedTimestamp != null) {
      DateTime lastUsedTime = DateTime.parse(lastUsedTimestamp);
      DateTime now = DateTime.now();

      Duration difference = now.difference(lastUsedTime);

      if (difference.inSeconds >= 15) {
        ArticleListTable.deleteAll();
        for (int i = 0; i < (list.data != null ? list.data!.length : 0); i++) {
          ArticleListTable.insert(list.data![i]);
        }
      }
    } else {
      ArticleListTable.deleteAll();
      for (int i = 0; i < (list.data != null ? list.data!.length : 0); i++) {
        ArticleListTable.insert(list.data![i]);
      }
    }
  }

  Future<ArticleList> fetchAll() async {
    ArticleList list = await ArticleListTable.selectAll();
    return list;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
