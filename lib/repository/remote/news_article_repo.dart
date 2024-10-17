import 'package:junglee_news/config/api_url.dart';
import 'package:junglee_news/model/article_model.dart';
import 'package:junglee_news/services/network/base_api_service.dart';
import 'package:junglee_news/services/network/network_api_service.dart';
import 'package:junglee_news/repository/remote/remote_base_repo.dart';

class NewsArticleRepo implements RemoteBaseRepo<Article> {
  String articleUrl;

  NewsArticleRepo({this.articleUrl = ""});
  @override
  BaseApiService get apiService => NetworkApiService();

  @override
  Future<Article> fetch() async {
    try {
      dynamic response = await apiService
          .getApiResponse(ApiUrl.getHeadlineContentUrl(articleUrl: articleUrl));
      return Article.fromJson(response['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
