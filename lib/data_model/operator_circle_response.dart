// To parse this JSON data, do
//
//     final circleReponse = circleReponseFromJson(jsonString);

import 'dart:convert';

CircleReponse circleReponseFromJson(String str) =>
    CircleReponse.fromJson(json.decode(str));

String circleReponseToJson(CircleReponse data) => json.encode(data.toJson());

class CircleReponse {
  CircleReponse({
    this.result,
    this.message,
    this.data,
  });

  bool result;
  String message;
  List<Datum> data;

  factory CircleReponse.fromJson(Map<String, dynamic> json) => CircleReponse(
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
    this.circleName,
    this.circleCode,
  });

  String circleName;
  String circleCode;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        circleName: json["circle_name"],
        circleCode: json["circle_code"],
      );

  Map<String, dynamic> toJson() => {
        "circle_name": circleName,
        "circle_code": circleCode,
      };
}
