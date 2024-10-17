import 'package:flutter/widgets.dart';
import 'package:junglee_news/model/article_model.dart';
import 'package:junglee_news/repository/local/saved_articles_repo.dart';
import 'package:junglee_news/resources/app_state_provider.dart';
import 'package:junglee_news/services/response/response.dart';
import 'package:junglee_news/repository/remote/remote_base_repo.dart';

import '../../../config/utils.dart';
import '../providers/news_article_provider.dart';

class NewsArticleViewModel {
  final RemoteBaseRepo _newsArticleRepo;
  final SavedArticlesRepo _savedArticlesRepo;
  final NewsArticleProvider _newsArticleProvider;

  NewsArticleViewModel(this._newsArticleRepo, this._newsArticleProvider,
      this._savedArticlesRepo);

  Future<void> fetchNewsArticle(String? id) async {
    try {
      bool isDeviceConnected = await Utils.deviceConnectedToInternet();

      if (id == null) {
        _newsArticleProvider.setNewsArticle(Response.loading());
        Article response = await _newsArticleRepo.fetch();
        _newsArticleProvider.setNewsArticle(Response.success(response));
      } else {
        _newsArticleProvider.setNewsArticle(Response.loading());
        Article? response = await _savedArticlesRepo.fetchSingle(id!);
        if (response != null) {
          _newsArticleProvider.setNewsArticle(Response.success(response));
        } else {
          print("here");
          _newsArticleProvider
              .setNewsArticle(Response.error("Something went wrong!"));
        }
      }
    } catch (e) {
      _newsArticleProvider.setNewsArticle(Response.error(e.toString()));
    }
  }
}

// if (isDeviceConnected && id == null) {
//   _newsArticleProvider.setNewsArticle(Response.loading());
//   Article response = await _newsArticleRepo.fetch();
//   _newsArticleProvider.setNewsArticle(Response.success(response));
// } else {
//   _newsArticleProvider.setNewsArticle(Response.loading());
//   Article? response = await _savedArticlesRepo.fetchSingle(id!);
//   if (response != null) {
//     _newsArticleProvider.setNewsArticle(Response.success(response));
//   } else {
//     print("here");
//     _newsArticleProvider
//         .setNewsArticle(Response.error("Something went wrong!"));
//   }
// }
