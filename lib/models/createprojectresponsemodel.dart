// To parse this JSON data, do
//
//     final createProjectResponseModel = createProjectResponseModelFromJson(jsonString);

import 'dart:convert';

List<CreateProjectResponseModel> createProjectResponseModelFromJson(
        String str) =>
    List<CreateProjectResponseModel>.from(
        json.decode(str).map((x) => CreateProjectResponseModel.fromJson(x)));

String createProjectResponseModelToJson(
        List<CreateProjectResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CreateProjectResponseModel {
  CreateProjectResponseModel({
    required this.file,
    required this.status,
    required this.projectid,
  });

  String file;
  String status;
  String projectid;

  factory CreateProjectResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateProjectResponseModel(
        file: json["File"] == null ? null : json["File"],
        status: json["Status"] == null ? null : json["Status"],
        projectid: json["projectid"] == null ? null : json["projectid"],
      );

  Map<String, dynamic> toJson() => {
        "File": file == null ? null : file,
        "Status": status == null ? null : status,
        "projectid": projectid == null ? null : projectid,
      };
}
