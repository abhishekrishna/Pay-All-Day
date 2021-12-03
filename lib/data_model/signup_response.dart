// To parse this JSON data, do
//
//     final signupResponse = signupResponseFromJson(jsonString);

import 'dart:convert';

SignupResponse signupResponseFromJson(String str) =>
    SignupResponse.fromJson(json.decode(str));

String signupResponseToJson(SignupResponse data) => json.encode(data.toJson());

class SignupResponse {
  SignupResponse({
    this.result,
    this.message,
    this.is_otp_sent,
  });

  bool result;
  String message;
  bool is_otp_sent;

  factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
        result: json["result"],
        message: json["message"],
        is_otp_sent: json["is_otp_sent"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "is_otp_sent": is_otp_sent,
      };
}
