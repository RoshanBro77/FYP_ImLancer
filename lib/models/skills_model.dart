// To parse required this JSON data, do
//
//     final skillModel = skillModelFromJson(jsonString);

import 'dart:convert';

SkillModel singleskillModelFromJson(String str) => SkillModel.fromJson(json.decode(str));

String singleskillModelToJson(SkillModel data) => json.encode(data.toJson());
List<SkillModel> skillModelFromJson(String str) => List<SkillModel>.from(json.decode(str).map((x) => SkillModel.fromJson(x)));

String skillModelToJson(List<SkillModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SkillModel {
    SkillModel({
        required this.id,
        required this.skillName,
        required this.subcategoryId,
        required this.date,
    });

    int id;
    String skillName;
    String subcategoryId;
    DateTime date;

    factory SkillModel.fromJson(Map<String, dynamic> json) => SkillModel(
        id: json["id"],
        skillName: json["skill_name"],
        subcategoryId: json["subcategory_id"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "skill_name": skillName,
        "subcategory_id": subcategoryId,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    };
}
