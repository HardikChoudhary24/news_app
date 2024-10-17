import 'package:junglee_news/model/category_list_model.dart';
import 'package:junglee_news/services/network/base_api_service.dart';
import 'package:junglee_news/services/network/network_api_service.dart';
import 'package:junglee_news/repository/remote/remote_base_repo.dart';

import '../../config/api_url.dart';

class CategoryListRepo extends RemoteBaseRepo<CategoryList> {
  @override
  BaseApiService get apiService => NetworkApiService();

  @override
  Future<CategoryList> fetch() async {
    try {
      dynamic response =
          await apiService.getApiResponse(ApiUrl.getSupportedTopicsUrl());
      return CategoryList.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
