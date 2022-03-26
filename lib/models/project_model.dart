// To parse required this JSON data, do
//
//     final projectModel = projectModelFromJson(jsonString);

import 'dart:convert';

ProjectModel singleprojectModelFromJson(String str) =>
    ProjectModel.fromJson(json.decode(str));

String singleprojectModelToJson(ProjectModel data) =>
    json.encode(data.toJson());
List<ProjectModel> projectModelFromJson(String str) => List<ProjectModel>.from(
    json.decode(str).map((x) => ProjectModel.fromJson(x)));

String projectModelToJson(List<ProjectModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectModel {
  ProjectModel({
    required this.id,
    required this.budget,
    required this.projectCategory,
    required this.projectSubcategory,
    required this.projectName,
    required this.duration,
    required this.date,
    required this.deadline,
    required this.clientId,
    required this.freelancerId,
    required this.projectStatus,
    required this.file,
    required this.description,
    required this.skillId,
    required this.review,
  });

  int id;
  String budget;
  String projectCategory;
  String projectSubcategory;
  String projectName;
  String duration;
  DateTime date;
  DateTime deadline;
  String clientId;
  String freelancerId;
  String projectStatus;
  String file;
  String description;
  String skillId;
  String review;
  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json["id"],
        budget: json["budget"],
        projectCategory: json["project_category"],
        projectSubcategory: json["project_subcategory"],
        projectName: json["project_name"],
        duration: json["duration"],
        date: DateTime.parse(json["date"]),
        deadline: DateTime.parse(json["deadline"]),
        clientId: json["client_id"],
        freelancerId: json["freelancer_id"],
        projectStatus: json["project_status"],
        file: json["file"],
        description: json["description"],
        skillId: json["skill_id"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "budget": budget,
        "project_category": projectCategory,
        "project_subcategory": projectSubcategory,
        "project_name": projectName,
        "duration": duration,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "deadline":
            "${deadline.year.toString().padLeft(4, '0')}-${deadline.month.toString().padLeft(2, '0')}-${deadline.day.toString().padLeft(2, '0')}",
        "client_id": clientId,
        "freelancer_id": freelancerId,
        "project_status": projectStatus,
        "file": file,
        "description": description,
        "skill_id": skillId,
        "review": review,
      };
}
