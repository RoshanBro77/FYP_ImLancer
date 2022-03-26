import 'dart:convert';

MyProjectBidModel singlemyProjectBidModelFromJson(String str) =>
    MyProjectBidModel.fromJson(json.decode(str));

String singlemyProjectBidModelToJson(MyProjectBidModel data) =>
    json.encode(data.toJson());

List<MyProjectBidModel> myProjectBidModelFromJson(String str) =>
    List<MyProjectBidModel>.from(
        json.decode(str).map((x) => MyProjectBidModel.fromJson(x)));

String myProjectBidModelToJson(List<MyProjectBidModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyProjectBidModel {
  MyProjectBidModel({
    required this.id,
    required this.projectId,
    required this.date,
    required this.userId,
    required this.bidPrice,
    required this.status,
    required this.freelancerUsername,
    required this.freelancerEmail,
    required this.freelancerAddress,
    required this.freelancerPhone,
    required this.freelancerRating,
    required this.freelancerSkills,
    required this.freelancerSpeciality,
    required this.freelancerDescription,
    required this.freelancerSocialmedia,
    required this.freelanderGender,
    required this.notificationId,
    required this.projectDocument,
    required this.projectName,
    required this.projectStatus,
    required this.budget,
    required this.description,
    required this.deadline,
    required this.freelancerId,
    required this.review,
  });

  int id;
  String projectId;
  DateTime date;
  String userId;
  String bidPrice;
  String status;
  String freelancerUsername;
  String freelancerEmail;
  String freelancerAddress;
  String freelancerPhone;
  String freelancerRating;
  String freelancerSkills;
  String freelancerSpeciality;
  String freelancerDescription;
  String freelancerSocialmedia;
  String freelanderGender;
  String notificationId;
  String projectDocument;
  String projectName;
  String projectStatus;
  String budget;
  String description;
  DateTime deadline;
  String freelancerId;
  String review;

  factory MyProjectBidModel.fromJson(Map<String, dynamic> json) =>
      MyProjectBidModel(
        id: json["id"],
        projectId: json["project_id"],
        date: DateTime.parse(json["date"]),
        userId: json["user_id"],
        bidPrice: json["bid_price"],
        status: json["status"],
        freelancerUsername: json["freelancerUsername"],
        freelancerEmail: json["freelancerEmail"],
        freelancerAddress: json["freelancerAddress"],
        freelancerPhone: json["freelancerPhone"],
        freelancerRating: json["freelancerRating"],
        freelancerSkills: json["freelancerSkills"],
        freelancerSpeciality: json["freelancerSpeciality"],
        freelancerDescription: json["freelancerDescription"],
        freelancerSocialmedia: json["freelancerSocialmedia"],
        freelanderGender: json["freelanderGender"],
        notificationId: json["notificationId"],
        projectDocument: json["projectDocument"],
        projectName: json["projectName"],
        projectStatus: json["projectStatus"],
        budget: json["budget"],
        description: json["description"],
        deadline: DateTime.parse(json["deadline"]),
        freelancerId: json["freelancer_id"],
        review: json["review"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "project_id": projectId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "user_id": userId,
        "bid_price": bidPrice,
        "status": status,
        "freelancerUsername": freelancerUsername,
        "freelancerEmail": freelancerEmail,
        "freelancerAddress": freelancerAddress,
        "freelancerPhone": freelancerPhone,
        "freelancerRating": freelancerRating,
        "freelancerSkills": freelancerSkills,
        "freelancerSpeciality": freelancerSpeciality,
        "freelancerDescription": freelancerDescription,
        "freelancerSocialmedia": freelancerSocialmedia,
        "freelanderGender": freelanderGender,
        "notificationId": notificationId,
        "projectDocument": projectDocument,
        "projectName": projectName,
        "projectStatus": projectStatus,
        "budget": budget,
        "description": description,
        "deadline":
            "${deadline.year.toString().padLeft(4, '0')}-${deadline.month.toString().padLeft(2, '0')}-${deadline.day.toString().padLeft(2, '0')}",
        "freelancer_id": freelancerId,
        "review": review,
      };
}
