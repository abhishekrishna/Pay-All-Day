// To parse this JSON data, do
//
//     final confirmCodeResponse = confirmCodeResponseFromJson(jsonString);

import 'dart:convert';

import 'login_response.dart';

ConfirmCodeResponse confirmCodeResponseFromJson(String str) =>
    ConfirmCodeResponse.fromJson(json.decode(str));

String confirmCodeResponseToJson(ConfirmCodeResponse data) =>
    json.encode(data.toJson());

class ConfirmCodeResponse {
  ConfirmCodeResponse({
    this.result,
    this.message,
    this.accessToken,
    this.tokenType,
    this.expiresAt,
    this.user,
  });

  bool result;
  String message;
  String accessToken;
  String tokenType;
  DateTime expiresAt;
  User user;

  factory ConfirmCodeResponse.fromJson(Map<String, dynamic> json) =>
      ConfirmCodeResponse(
        result: json["result"],
        message: json["message"],
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresAt: DateTime.parse(json["expires_at"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_at": expiresAt.toIso8601String(),
        "user": user.toJson(),
      };
}
