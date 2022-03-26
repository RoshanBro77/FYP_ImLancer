import 'dart:convert';

PaymentModel singlepaymentModelFromJson(String str) =>
    PaymentModel.fromJson(json.decode(str));

String singlepaymentModelToJson(PaymentModel data) =>
    json.encode(data.toJson());

List<PaymentModel> paymentModelFromJson(String str) => List<PaymentModel>.from(
    json.decode(str).map((x) => PaymentModel.fromJson(x)));

String paymentModelToJson(List<PaymentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentModel {
  PaymentModel({
    required this.id,
    required this.clientId,
    required this.amount,
    required this.status,
    required this.date,
    required this.account,
    required this.projectId,
  });

  int id;
  int clientId;
  int amount;
  String status;
  DateTime date;
  String account;
  int projectId;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json["id"],
        clientId: json["client_id"],
        amount: json["amount"],
        status: json["status"],
        date: DateTime.parse(json["date"]),
        account: json["account"],
        projectId: json["project_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "amount": amount,
        "status": status,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "account": account,
        "project_id": projectId,
      };
}
