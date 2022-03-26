// To parse required required this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel singleprofileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String singleprofileModelToJson(ProfileModel data) =>
    json.encode(data.toJson());
List<ProfileModel> profileModelFromJson(String str) => List<ProfileModel>.from(
    json.decode(str).map((x) => ProfileModel.fromJson(x)));

String profileModelToJson(List<ProfileModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfileModel {
  ProfileModel({
    required this.id,
    required this.userName,
    required this.password,
    required this.emailId,
    required this.address,
    required this.phone,
    required this.date,
    required this.rating,
    required this.skillId,
    required this.profileimageId,
    required this.mydescription,
    required this.myspeciality,
    required this.document,
    required this.socialmedia,
    required this.gender,
    required this.notificationId,
  });

  int id;
  String userName;
  String password;
  String emailId;
  String address;
  String phone;
  String date;
  String rating;
  String skillId;
  String profileimageId;
  String mydescription;
  String myspeciality;
  String document;
  String socialmedia;
  String gender;
  String notificationId;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        userName: json["user_name"],
        password: json["password"],
        emailId: json["email_id"],
        address: json["address"],
        phone: json["phone"],
        date: json["date"],
        rating: json["rating"],
        skillId: json["skill_id"],
        profileimageId: json["profileimage_id"],
        mydescription: json["mydescription"],
        myspeciality: json["myspeciality"],
        document: json["document"],
        socialmedia: json["socialmedia"],
        gender: json["gender"],
        notificationId: json["notification_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "password": password,
        "email_id": emailId,
        "address": address,
        "phone": phone,
        "date": date,
        "rating": rating,
        "skill_id": skillId,
        "profileimage_id": profileimageId,
        "mydescription": mydescription,
        "myspeciality": myspeciality,
        "document": document,
        "socialmedia": socialmedia,
        "gender": gender,
        "notification_id": notificationId,
      };
}
