import 'package:flutter/cupertino.dart';
import 'package:junglee_news/services/response/response.dart';
import '../../../model/article_list_model.dart';

class ArticlesListProvider extends ChangeNotifier {
  Response<ArticleList> _articleList = Response.loading();

  setArticleList(Response<ArticleList> response) {
    _articleList = response;
    notifyListeners();
  }

  Response<ArticleList> get getArticleList => _articleList;
}
