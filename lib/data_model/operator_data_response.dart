// To parse this JSON data, do
//
//     final operatorData = operatorDataFromJson(jsonString);

import 'dart:convert';

OperatorData operatorDataFromJson(String str) =>
    OperatorData.fromJson(json.decode(str));

String operatorDataToJson(OperatorData data) => json.encode(data.toJson());

class OperatorData {
  OperatorData({
    this.result,
    this.message,
    this.data,
  });

  bool result;
  String message;
  List<Datum> data;

  factory OperatorData.fromJson(Map<String, dynamic> json) => OperatorData(
        result: json["result"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.operatorId,
    this.operatorCode,
    this.operatorName,
    this.operatorCircleCode,
    this.operatorIsMatched,
  });

  int operatorId;
  String operatorCode;
  String operatorName;
  String operatorCircleCode;
  bool operatorIsMatched;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        operatorId: json["operator_id"],
        operatorCode: json["operator_code"],
        operatorName: json["operator_name"],
        operatorCircleCode: json["operator_circle_code"],
        operatorIsMatched: json["operator_is_matched"],
      );

  Map<String, dynamic> toJson() => {
        "operator_id": operatorId,
        "operator_code": operatorCode,
        "operator_name": operatorName,
        "operator_circle_code": operatorCircleCode,
        "operator_is_matched": operatorIsMatched,
      };
}
