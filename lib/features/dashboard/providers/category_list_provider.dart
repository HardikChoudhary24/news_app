import 'package:flutter/cupertino.dart';

import '../../../model/category_list_model.dart';
import '../../../services/response/response.dart';

class CategoryListProvider extends ChangeNotifier {
  Category _selectedCategory = Category(name: "General");
  Category getSelectedCategory() => _selectedCategory;

  setSelectedCategory(Category category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Response<CategoryList> _categoryList = Response.loading();

  Response<CategoryList> getCategoryList() => _categoryList;

  setCategoryList(Response<CategoryList> response) {
    _categoryList = response;
    notifyListeners();
  }
}
