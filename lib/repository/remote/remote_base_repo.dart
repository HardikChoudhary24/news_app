import '../../services/network/base_api_service.dart';
import '../../services/network/network_api_service.dart';

abstract class RemoteBaseRepo<T> {
  BaseApiService get apiService;

  Future<T> fetch();
  Future<T> fetchByCategory(String category);
  Future<T> fetchByQuery(String query);
}
