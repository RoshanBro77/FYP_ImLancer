// To parse required this JSON data, do
//
//     final projectReadingModel = projectReadingModelFromJson(jsonString);

import 'dart:convert';

ProjectReadingModel singleprojectReadingModelFromJson(String str) =>
    ProjectReadingModel.fromJson(json.decode(str));

String singleprojectReadingModelToJson(ProjectReadingModel data) =>
    json.encode(data.toJson());
List<ProjectReadingModel> projectReadingModelFromJson(String str) =>
    List<ProjectReadingModel>.from(
        json.decode(str).map((x) => ProjectReadingModel.fromJson(x)));

String projectReadingModelToJson(List<ProjectReadingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectReadingModel {
  ProjectReadingModel({
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
    required this.clientUsername,
    required this.clientEmail,
    required this.clientRating,
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
  String clientUsername;
  String clientEmail;
  String clientRating;

  factory ProjectReadingModel.fromJson(Map<String, dynamic> json) =>
      ProjectReadingModel(
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
        clientUsername: json["client_username"],
        clientEmail: json["client_email"],
        clientRating: json["client_rating"] ?? 0,
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
        "client_username": clientUsername,
        "client_email": clientEmail,
        "client_rating": clientRating,
      };
}
