import 'package:flutter/cupertino.dart';

import '../../../model/article_model.dart';
import '../../../services/response/response.dart';

class NewsArticleProvider extends ChangeNotifier {
  Response<Article> _newsArticle = Response.loading();

  setNewsArticle(Response<Article> response) {
    _newsArticle = response;
    notifyListeners();
  }

  Response<Article> getNewsArticle() => _newsArticle;
}
