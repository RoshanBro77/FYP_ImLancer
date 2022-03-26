// To parse required this JSON data, do
//
//     final bidModel = bidModelFromJson(jsonString);

import 'dart:convert';


BidModel singlebidModelFromJson(String str) => BidModel.fromJson(json.decode(str));

String singlebidModelToJson(BidModel data) => json.encode(data.toJson());

List<BidModel> bidModelFromJson(String str) => List<BidModel>.from(json.decode(str).map((x) => BidModel.fromJson(x)));

String bidModelToJson(List<BidModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BidModel {
    BidModel({
        required this.id,
        required this.projectId,
        required this.date,
        required this.userId,
        required this.bidPrice,
        required this.status,
    });

    int id;
    String projectId;
    DateTime date;
    String userId;
    String bidPrice;
    String status;

    factory BidModel.fromJson(Map<String, dynamic> json) => BidModel(
        id: json["id"],
        projectId: json["project_id"],
        date: DateTime.parse(json["date"]),
        userId: json["user_id"],
        bidPrice: json["bid_price"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "project_id": projectId,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "user_id": userId,
        "bid_price": bidPrice,
        "status": status,
    };
}
