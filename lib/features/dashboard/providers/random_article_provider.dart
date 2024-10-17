import 'package:flutter/cupertino.dart';

import '../../../model/article_model.dart';
import '../../../services/response/response.dart';

class RandomArticleProvider extends ChangeNotifier {
  Response<Article> _newsArticle = Response.loading();

  Response<Article> getNewsArticle() => _newsArticle;

  setNewsArticle(Response<Article> response) {
    _newsArticle = response;
    notifyListeners();
  }
}
