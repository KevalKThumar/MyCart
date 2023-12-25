// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) =>

//json.decode use bcz str is a type of String and at function we catch as list there for we convert into lis type
    CategoriesModel.fromJson(json.decode(str));

class CategoriesModel {
  CategoriesModel({
    required this.categories,
  });

  List<Category> categories;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );
}

class Category {
  Category({
    required this.name,
    required this.subcatagory,
  });

  String name;
  List<String> subcatagory;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        subcatagory: List<String>.from(json["subcatagory"].map((x) => x)),
      );
}
