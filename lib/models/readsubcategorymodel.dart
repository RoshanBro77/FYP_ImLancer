// To parse required this JSON data, do
//
//     final readSubCategoryModel = readSubCategoryModelFromJson(jsonString);

import 'dart:convert';

ReadSubCategoryModel singlereadSubCategoryModelFromJson(String str) => ReadSubCategoryModel.fromJson(json.decode(str));

String singlereadSubCategoryModelToJson(ReadSubCategoryModel data) => json.encode(data.toJson());
List<ReadSubCategoryModel> readSubCategoryModelFromJson(String str) => List<ReadSubCategoryModel>.from(json.decode(str).map((x) => ReadSubCategoryModel.fromJson(x)));

String readSubCategoryModelToJson(List<ReadSubCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReadSubCategoryModel {
    ReadSubCategoryModel({
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

    factory ReadSubCategoryModel.fromJson(Map<String, dynamic> json) => ReadSubCategoryModel(
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
