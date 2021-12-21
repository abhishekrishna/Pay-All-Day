// To parse this JSON data, do
//
//     final operatorListResponse = operatorListResponseFromJson(jsonString);

import 'dart:convert';

OperatorListResponse operatorListResponseFromJson(String str) =>
    OperatorListResponse.fromJson(json.decode(str));

String operatorListResponseToJson(OperatorListResponse data) =>
    json.encode(data.toJson());

class OperatorListResponse {
  OperatorListResponse({
    this.result,
    this.message,
    this.data,
  });

  bool result;
  String message;
  List<Datum> data;

  factory OperatorListResponse.fromJson(Map<String, dynamic> json) =>
      OperatorListResponse(
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
    this.operatorName,
    this.operatorCode,
    this.operatorCircleCode,
    this.operatorIcon,
    this.operatorIsMatched,
  });

  int operatorId;
  String operatorName;
  String operatorCode;
  String operatorCircleCode;
  String operatorIcon;
  bool operatorIsMatched;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        operatorId: json["operator_id"],
        operatorName: json["operator_name"],
        operatorCode: json["operator_code"],
        operatorCircleCode: json["operator_circle_code"],
        operatorIcon: json["operator_icon"],
        operatorIsMatched: json["operator_is_matched"],
      );

  Map<String, dynamic> toJson() => {
        "operator_id": operatorId,
        "operator_name": operatorName,
        "operator_code": operatorCode,
        "operator_circle_code": operatorCircleCode,
        "operator_icon": operatorIcon,
        "operator_is_matched": operatorIsMatched,
      };
}
