import 'package:flutter/cupertino.dart';
import 'package:junglee_news/features/dashboard/providers/category_list_provider.dart';
import 'package:junglee_news/model/category_list_model.dart';
import 'package:junglee_news/services/response/response.dart';

import '../../../repository/remote/remote_base_repo.dart';

class CategoryListViewModel {
  final RemoteBaseRepo _categoryListRepo;
  final CategoryListProvider _categoryListProvider;

  CategoryListViewModel(this._categoryListRepo, this._categoryListProvider);

  Future<void> fetchCategoryList() async {
    try {
      _categoryListProvider.setCategoryList(Response.loading());
      CategoryList response = await _categoryListRepo.fetch();
      _categoryListProvider.setCategoryList(Response.success(response));
    } catch (e) {
      _categoryListProvider.setCategoryList(Response.error(e.toString()));
    }
  }
}
