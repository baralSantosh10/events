List<CategoryModel> categoriesFromJson(List<dynamic> categoriesModel) =>
    List<CategoryModel>.from(categoriesModel
        .map((categoryModel) => CategoryModel.fromJson(categoryModel)));

class CategoryModel {
  int? id;
  String? title;

  CategoryModel({this.id, this.title});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
