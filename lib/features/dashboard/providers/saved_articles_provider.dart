import 'package:flutter/cupertino.dart';
import '../../../model/article_list_model.dart';
import '../../../model/article_model.dart';
import '../../../services/response/response.dart';

class SavedArticlesProvider extends ChangeNotifier {
  late Response<ArticleList> _savedArticleList;

  setSavedArticles(Response<ArticleList> articles) {
    _savedArticleList = articles;
    notifyListeners();
  }

  Response<ArticleList> get getSavedArticles => _savedArticleList;
}
