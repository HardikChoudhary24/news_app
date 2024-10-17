class CategoryList {
  bool? success;
  List<Category>? categories;

  CategoryList({this.success, this.categories});

  CategoryList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      categories = <Category>[];
      json['data'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
  }
}

class Category {
  String? name;
  List<String>? subtopics;

  Category({this.name, this.subtopics});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subtopics = json['subtopics'].cast<String>();
  }
}
