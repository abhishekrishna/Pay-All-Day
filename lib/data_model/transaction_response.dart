// To parse this JSON data, do
//
//     final transactionResponse = transactionResponseFromJson(jsonString);

import 'dart:convert';

TransactionResponse transactionResponseFromJson(String str) =>
    TransactionResponse.fromJson(json.decode(str));

String transactionResponseToJson(TransactionResponse data) =>
    json.encode(data.toJson());

class TransactionResponse {
  TransactionResponse({
    this.result,
    this.message,
    this.data,
  });

  int result;
  String message;
  Data data;

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      TransactionResponse(
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.payAmount,
    this.payTitle,
    this.payDescription,
    this.payStatus,
    this.payCreatedAt,
  });

  int id;
  dynamic payAmount;
  dynamic payTitle;
  dynamic payDescription;
  String payStatus;
  DateTime payCreatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        payAmount: json["pay_amount"],
        payTitle: json["pay_title"],
        payDescription: json["pay_description"],
        payStatus: json["pay_status"],
        payCreatedAt: DateTime.parse(json["pay_created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pay_amount": payAmount,
        "pay_title": payTitle,
        "pay_description": payDescription,
        "pay_status": payStatus,
        "pay_created_at": payCreatedAt.toIso8601String(),
      };
}
