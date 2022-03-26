// To parse required this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel singlenotificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String singlenotificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());
List<NotificationModel> notificationModelFromJson(String str) =>
    List<NotificationModel>.from(
        json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.content,
    required this.date,
    required this.recieverId,
  });

  int id;
  String title;
  String description;
  String type;
  String content;
  DateTime date;
  int recieverId;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        type: json["type"],
        content: json["content"],
        date: DateTime.parse(json["date"]),
        recieverId: json["reciever_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "type": type,
        "content": content,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "reciever_id": recieverId,
      };
}
