// To parse this JSON data, do
//
//     final findMobileOperator = findMobileOperatorFromJson(jsonString);

import 'dart:convert';

FindMobileOperator findMobileOperatorFromJson(String str) =>
    FindMobileOperator.fromJson(json.decode(str));

String findMobileOperatorToJson(FindMobileOperator data) =>
    json.encode(data.toJson());

class FindMobileOperator {
  FindMobileOperator({
    this.result,
    this.message,
    this.operatorIsMatched,
    this.operatorIcon,
    this.operatorMatchedData,
    this.data,
  });

  bool result;
  String message;
  bool operatorIsMatched;
  String operatorIcon;
  OperatorMatchedData operatorMatchedData;
  List<OperatorMatchedData> data;

  factory FindMobileOperator.fromJson(Map<String, dynamic> json) =>
      FindMobileOperator(
        result: json["result"],
        message: json["message"],
        operatorIsMatched: json["operator_is_matched"],
        operatorIcon: json["operator_icon"],
        operatorMatchedData:
            OperatorMatchedData.fromJson(json["operator_matched_data"]),
        data: List<OperatorMatchedData>.from(
            json["data"].map((x) => OperatorMatchedData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "operator_is_matched": operatorIsMatched,
        "operator_icon": operatorIcon,
        "operator_matched_data": operatorMatchedData.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OperatorMatchedData {
  OperatorMatchedData({
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

  factory OperatorMatchedData.fromJson(Map<String, dynamic> json) =>
      OperatorMatchedData(
        operatorId: json["operator_id"],
        operatorName: json["operator_name"],
        operatorCode: json["operator_code"],
        operatorCircleCode: json["operator_circle_code"],
        operatorIcon: json["operator_icon"],
        operatorIsMatched: json["operator_is_matched"] == null
            ? null
            : json["operator_is_matched"],
      );

  Map<String, dynamic> toJson() => {
        "operator_id": operatorId,
        "operator_name": operatorName,
        "operator_code": operatorCode,
        "operator_circle_code": operatorCircleCode,
        "operator_icon": operatorIcon,
        "operator_is_matched":
            operatorIsMatched == null ? null : operatorIsMatched,
      };
}
