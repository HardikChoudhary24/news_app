import 'package:junglee_news/features/dashboard/providers/article_list_provider.dart';
import 'package:junglee_news/model/article_list_model.dart';
import 'package:junglee_news/repository/local/local_base_repo.dart';
import 'package:junglee_news/services/database/schema/article_list_table.dart';
import 'package:junglee_news/services/response/response.dart';
import 'package:junglee_news/repository/remote/remote_base_repo.dart';

import '../../../config/config.dart';
import '../../../config/utils.dart';

class ArticlesListViewModel {
  final RemoteBaseRepo _articleListRepo;
  final ArticlesListProvider _articlesListProvider;
  final LocalBaseRepo _localArticleListRepo;

  ArticlesListViewModel(this._articleListRepo, this._articlesListProvider,
      this._localArticleListRepo);

  Future<void> fetchArticleListByCategory(
      {String? category = "General"}) async {
    try {
      if (!(await Utils.deviceConnectedToInternet())) {
        ArticleList list = await _localArticleListRepo.fetchAll();
        _articlesListProvider.setArticleList(Response.success(list));
      } else {
        _articlesListProvider.setArticleList(Response.loading());

        ArticleList response =
            await _articleListRepo.fetchByCategory(category ?? "General");

        _articlesListProvider.setArticleList(Response.success(response));
        _localArticleListRepo.cache(response);
      }
    } catch (e) {
      _articlesListProvider.setArticleList(Response.error(e.toString()));
    }
  }

  Future<void> fetchArticleListByQuery({required String query}) async {
    try {
      _articlesListProvider.setArticleList(Response.loading());
      ArticleList response = await _articleListRepo.fetchByQuery(query);
      _articlesListProvider.setArticleList(Response.success(response));
    } catch (e) {
      _articlesListProvider.setArticleList(Response.error(e.toString()));
    }
  }
}
