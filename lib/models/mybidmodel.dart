// To parse required this JSON data, do
//
//     final myBidModel = myBidModelFromJson(jsonString);

import 'dart:convert';

MyBidModel singlemyBidModelFromJson(String str) =>
    MyBidModel.fromJson(json.decode(str));

String singemyBidModelToJson(MyBidModel data) => json.encode(data.toJson());
List<MyBidModel> myBidModelFromJson(String str) =>
    List<MyBidModel>.from(json.decode(str).map((x) => MyBidModel.fromJson(x)));

String myBidModelToJson(List<MyBidModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyBidModel {
  MyBidModel({
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
    required this.clientRating,
    required this.clientEmail,
    required this.status,
    required this.bidPrice,
    required this.userId,
    required this.bidAppliedDate,
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
  String clientRating;
  String clientEmail;
  String status;
  String bidPrice;
  String userId;
  DateTime bidAppliedDate;

  factory MyBidModel.fromJson(Map<String, dynamic> json) => MyBidModel(
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
        clientUsername: json["clientUsername"],
        clientRating: json["clientRating"],
        clientEmail: json["clientEmail"],
        status: json["status"] ?? " ",
        bidPrice: json["bidPrice"],
        userId: json["userId"],
        bidAppliedDate: DateTime.parse(json["bidAppliedDate"]),
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
        "clientUsername": clientUsername,
        "clientRating": clientRating,
        "clientEmail": clientEmail,
        "status": status,
        "bidPrice": bidPrice,
        "userId": userId,
        "bidAppliedDate":
            "${bidAppliedDate.year.toString().padLeft(4, '0')}-${bidAppliedDate.month.toString().padLeft(2, '0')}-${bidAppliedDate.day.toString().padLeft(2, '0')}",
      };
}
