// To parse this JSON data, do
//
//     final rechargeStatusModel = rechargeStatusModelFromJson(jsonString);

import 'dart:convert';

RechargeStatusModel rechargeStatusModelFromJson(String str) =>
    RechargeStatusModel.fromJson(json.decode(str));

String rechargeStatusModelToJson(RechargeStatusModel data) =>
    json.encode(data.toJson());

class RechargeStatusModel {
  RechargeStatusModel({
    this.result,
    this.message,
    this.data,
  });

  bool result;
  String message;
  Data data;

  factory RechargeStatusModel.fromJson(Map<String, dynamic> json) =>
      RechargeStatusModel(
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
    this.rechargeId,
    this.rechargeTitle,
    this.rechargeOperatorId,
    this.rechargeOperatorName,
    this.rechargeOperatorIcon,
    this.rechargeOrderId,
    this.rechargeDescription,
    this.rechargeAmount,
    this.rechargePaymentMode,
    this.rechargeTransactionId,
    this.rechargeCreatedAt,
    this.rechargeUpdatedAt,
    this.rechargeStatus,
    this.rechargeStatusHistory,
    this.rechargeThirdPartyStatus,
    this.rechargeReferenceNumber,
    this.rechargeApiId,
    this.rechargeUserId,
    this.rechargeNumber,
  });

  int rechargeId;
  String rechargeTitle;
  int rechargeOperatorId;
  String rechargeOperatorName;
  String rechargeOperatorIcon;
  String rechargeOrderId;
  String rechargeDescription;
  int rechargeAmount;
  int rechargePaymentMode;
  dynamic rechargeTransactionId;
  DateTime rechargeCreatedAt;
  DateTime rechargeUpdatedAt;
  String rechargeStatus;
  dynamic rechargeStatusHistory;
  String rechargeThirdPartyStatus;
  String rechargeReferenceNumber;
  String rechargeApiId;
  int rechargeUserId;
  String rechargeNumber;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        rechargeId: json["recharge_id"],
        rechargeTitle: json["recharge_title"],
        rechargeOperatorId: json["recharge_operator_id"],
        rechargeOperatorName: json["recharge_operator_name"],
        rechargeOperatorIcon: json["recharge_operator_icon"],
        rechargeOrderId: json["recharge_order_id"],
        rechargeDescription: json["recharge_description"],
        rechargeAmount: json["recharge_amount"],
        rechargePaymentMode: json["recharge_payment_mode"],
        rechargeTransactionId: json["recharge_transaction_id"],
        rechargeCreatedAt: DateTime.parse(json["recharge_created_at"]),
        rechargeUpdatedAt: DateTime.parse(json["recharge_updated_at"]),
        rechargeStatus: json["recharge_status"],
        rechargeStatusHistory: json["recharge_status_history"],
        rechargeThirdPartyStatus: json["recharge_third_party_status"],
        rechargeReferenceNumber: json["recharge_reference_number"],
        rechargeApiId: json["recharge_api_id"],
        rechargeUserId: json["recharge_user_id"],
        rechargeNumber: json["recharge_number"],
      );

  Map<String, dynamic> toJson() => {
        "recharge_id": rechargeId,
        "recharge_title": rechargeTitle,
        "recharge_operator_id": rechargeOperatorId,
        "recharge_operator_name": rechargeOperatorName,
        "recharge_operator_icon": rechargeOperatorIcon,
        "recharge_order_id": rechargeOrderId,
        "recharge_description": rechargeDescription,
        "recharge_amount": rechargeAmount,
        "recharge_payment_mode": rechargePaymentMode,
        "recharge_transaction_id": rechargeTransactionId,
        "recharge_created_at": rechargeCreatedAt.toIso8601String(),
        "recharge_updated_at": rechargeUpdatedAt.toIso8601String(),
        "recharge_status": rechargeStatus,
        "recharge_status_history": rechargeStatusHistory,
        "recharge_third_party_status": rechargeThirdPartyStatus,
        "recharge_reference_number": rechargeReferenceNumber,
        "recharge_api_id": rechargeApiId,
        "recharge_user_id": rechargeUserId,
        "recharge_number": rechargeNumber,
      };
}
