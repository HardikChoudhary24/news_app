import 'package:flutter/foundation.dart';
import 'package:junglee_news/features/dashboard/providers/random_article_provider.dart';
import 'package:junglee_news/repository/remote/remote_base_repo.dart';
import '../../../model/article_model.dart';
import '../../../services/response/response.dart';

class RandomArticleViewModel {
  final RemoteBaseRepo _randomArticleGenerator;
  final RandomArticleProvider _randomArticleProvider;
  RandomArticleViewModel(
      this._randomArticleGenerator, this._randomArticleProvider);

  void fetchRandomArticle() async {
    try {
      _randomArticleProvider.setNewsArticle(Response.loading());
      Article response = await _randomArticleGenerator.fetch();
      _randomArticleProvider.setNewsArticle(Response.success(response));
    } catch (e) {
      _randomArticleProvider.setNewsArticle(Response.error(e.toString()));
    }
  }
}
