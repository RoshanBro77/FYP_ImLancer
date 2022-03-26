// To parse required this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';
CategoryModel singlecategoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String singlecategoryModelToJson(CategoryModel data) => json.encode(data.toJson());

List<CategoryModel> categoryModelFromJson(String str) => List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
    CategoryModel({
        required this.id,
        required this.categoryImage,
        required this.categoryName,
        required this.date,
    });

    int id;
    String categoryImage;
    String categoryName;
    String date;

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        categoryImage: json["category_image"],
        categoryName: json["category_name"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category_image": categoryImage,
        "category_name": categoryName,
        "date": date,
    };
}
