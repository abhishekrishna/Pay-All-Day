// To parse this JSON data, do
//
//     final plansData = plansDataFromJson(jsonString);

import 'dart:convert';

PlansData plansDataFromJson(String str) => PlansData.fromJson(json.decode(str));

String plansDataToJson(PlansData data) => json.encode(data.toJson());

class PlansData {
  PlansData({
    this.result,
    this.message,
    this.data,
  });

  bool result;
  String message;
  List<Datum> data;

  factory PlansData.fromJson(Map<String, dynamic> json) => PlansData(
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
    this.id,
    this.operatorId,
    this.circleId,
    this.rechargeAmount,
    this.rechargeTalktime,
    this.rechargeValidity,
    this.rechargeShortDesc,
    this.rechargeLongDesc,
    this.rechargeType,
  });

  String id;
  String operatorId;
  String circleId;
  String rechargeAmount;
  String rechargeTalktime;
  String rechargeValidity;
  String rechargeShortDesc;
  String rechargeLongDesc;
  String rechargeType;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        operatorId: json["operator_id"],
        circleId: json["circle_id"],
        rechargeAmount: json["recharge_amount"],
        rechargeTalktime: json["recharge_talktime"],
        rechargeValidity: json["recharge_validity"],
        rechargeShortDesc: json["recharge_short_desc"],
        rechargeLongDesc: json["recharge_long_desc"],
        rechargeType: json["recharge_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "operator_id": operatorId,
        "circle_id": circleId,
        "recharge_amount": rechargeAmount,
        "recharge_talktime": rechargeTalktime,
        "recharge_validity": rechargeValidity,
        "recharge_short_desc": rechargeShortDesc,
        "recharge_long_desc": rechargeLongDesc,
        "recharge_type": rechargeType,
      };
}
