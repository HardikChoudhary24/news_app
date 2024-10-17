import 'package:junglee_news/model/article_list_model.dart';
import 'package:junglee_news/config/api_url.dart';
import 'package:junglee_news/services/network/base_api_service.dart';
import 'package:junglee_news/services/network/network_api_service.dart';
import 'package:junglee_news/repository/remote/remote_base_repo.dart';

class NewsArticlesListRepo extends RemoteBaseRepo<ArticleList> {
  @override
  BaseApiService get apiService => NetworkApiService();

  @override
  Future<ArticleList> fetch() async {
    return await fetchByCategory("General");
  }

  @override
  Future<ArticleList> fetchByCategory(String category) async {
    try {
      dynamic response = await apiService
          .getApiResponse(ApiUrl.getTopHeadlinesUrl(topic: category));
      return ArticleList.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ArticleList> fetchByQuery(String query) async {
    try {
      dynamic response = await apiService
          .getApiResponse(ApiUrl.getSearchArticlesUrl(query: query));
      return ArticleList.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
