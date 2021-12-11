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
  RechargeTalktime rechargeTalktime;
  String rechargeValidity;
  String rechargeShortDesc;
  String rechargeLongDesc;
  String rechargeType;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        operatorId: json["operator_id"],
        circleId: json["circle_id"],
        rechargeAmount: json["recharge_amount"],
        rechargeTalktime: rechargeTalktimeValues.map[json["recharge_talktime"]],
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
        "recharge_talktime": rechargeTalktimeValues.reverse[rechargeTalktime],
        "recharge_validity": rechargeValidity,
        "recharge_short_desc": rechargeShortDesc,
        "recharge_long_desc": rechargeLongDesc,
        "recharge_type": rechargeType,
      };
}

enum RechargeTalktime {
  THE_747,
  EMPTY,
  THE_1495,
  THE_3937,
  THE_8175,
  RECHARGE_TALKTIME,
  THE_84446
}

final rechargeTalktimeValues = EnumValues({
  "-": RechargeTalktime.EMPTY,
  "": RechargeTalktime.RECHARGE_TALKTIME,
  "14.95": RechargeTalktime.THE_1495,
  "39.37": RechargeTalktime.THE_3937,
  "7.47": RechargeTalktime.THE_747,
  "81.75": RechargeTalktime.THE_8175,
  "844.46": RechargeTalktime.THE_84446
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
