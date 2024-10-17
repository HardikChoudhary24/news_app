import 'package:junglee_news/features/dashboard/providers/saved_articles_provider.dart';
import 'package:junglee_news/model/article_list_model.dart';
import 'package:junglee_news/model/article_model.dart';
import 'package:junglee_news/services/response/response.dart';

import '../../../repository/local/local_base_repo.dart';

class SavedArticlesViewModel {
  final LocalBaseRepo _savedArticlesRepo;
  final SavedArticlesProvider _savedArticlesProvider;

  SavedArticlesViewModel(this._savedArticlesRepo, this._savedArticlesProvider);

  Future<void> fetchSavedArticleList() async {
    try {
      _savedArticlesProvider.setSavedArticles(Response.loading());
      ArticleList articles = await _savedArticlesRepo.fetchAll();
      _savedArticlesProvider.setSavedArticles(Response.success(articles));
    } catch (e) {
      _savedArticlesProvider.setSavedArticles(Response.error(e.toString()));
      print(e.toString());
    }
  }

  void saveArticle(Article data) async {
    _savedArticlesRepo.insertData(data);
  }

  void unSaveArticle(String id) async {
    _savedArticlesRepo.deleteData(id);
  }
}
