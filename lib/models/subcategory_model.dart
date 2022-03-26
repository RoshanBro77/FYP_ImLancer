// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);

import 'dart:convert';

List<SubCategoryModel> subCategoryModelFromJson(String str) =>
    List<SubCategoryModel>.from(
        json.decode(str).map((x) => SubCategoryModel.fromJson(x)));

String subCategoryModelToJson(List<SubCategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategoryModel {
  SubCategoryModel({
    required this.id,
    required this.categoryId,
    required this.subcategoryName,
    required this.date,
    required this.subcategoryImage,
  });

  int id;
  String categoryId;
  String subcategoryName;
  DateTime date;
  String subcategoryImage;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
        id: json["id"],
        categoryId: json["category_id"],
        subcategoryName: json["subcategory_name"],
        date: DateTime.parse(json["date"]),
        subcategoryImage: json["subcategory_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "subcategory_name": subcategoryName,
         "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "subcategory_image": subcategoryImage,
      };
}
