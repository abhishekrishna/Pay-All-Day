import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:active_ecommerce_flutter/data_model/login_response.dart';
import 'package:active_ecommerce_flutter/data_model/logout_response.dart';
import 'package:active_ecommerce_flutter/data_model/signup_response.dart';
import 'package:active_ecommerce_flutter/data_model/resend_code_response.dart';
import 'package:active_ecommerce_flutter/data_model/confirm_code_response.dart';
import 'package:active_ecommerce_flutter/data_model/password_forget_response.dart';
import 'package:active_ecommerce_flutter/data_model/password_confirm_response.dart';
import 'package:active_ecommerce_flutter/data_model/user_by_token.dart';
// import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthRepository with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;
  Future<LoginResponse> getLoginResponse(String email, String password) async {
    var post_body = jsonEncode({
      "username": "$email",
      "password": "$password",
      // "identity_matrix": AppConfig.purchase_code
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL_2}/auth/login");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$,
        },
        body: post_body);
    return loginResponseFromJson(response.body);
  }

  // Future<LoginResponse> getsMarketLoginResponse(
  //     String email, String password) async {
  //   var post_body = jsonEncode({
  //     "username": "$email",
  //     "password": "$password",
  //     // "identity_matrix": AppConfig.purchase_code
  //   });

  //   Uri url = Uri.parse("${AppConfig.BASE_URL}/auth/login");
  //   final response = await http.post(url,
  //       headers: {
  //         "Content-Type": "application/json",
  //         "App-Language": app_language.$,
  //       },
  //       body: post_body);
  //   return loginResponseFromJson(response.body);
  // }

  // Future<LoginResponse> getSocialLoginResponse(
  //     String name, String email, String provider) async {
  //   var post_body = jsonEncode(
  //       {"name": "${name}", "email": "${email}", "provider": "$provider"});

  //   Uri url = Uri.parse("${AppConfig.BASE_URL}/auth/social-login");
  //   final response = await http.post(url,
  //       headers: {
  //         "Content-Type": "application/json",
  //         "App-Language": app_language.$,
  //       },
  //       body: post_body);
  //   print(response.body);
  //   return loginResponseFromJson(response.body);
  // }

  Future<LogoutResponse> getLogoutResponse() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL_2}/auth/logout");
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$,
      },
    );

    print(response.body);

    return logoutResponseFromJson(response.body);
  }

  Future<SignupResponse> getSignupResponse(
    String name,
    String phone,
    String password,
    String referral,
    String email,
  ) async {
    var post_body = jsonEncode({
      "user_name": "$name",
      "user_mobile": "$phone",
      "user_password": "$password",
      "user_referral": "$referral",
      "user_email": "$email",
      "auto_fill_sms_key": "",
      "fcm_device_token": ""

      // "register_by": "$register_by"
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL_2}/auth/signup");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$,
        },
        body: post_body);

    return signupResponseFromJson(response.body);
  }

  Future<SignupResponse> getsMarketSignupResponse(
    String name,
    String phone,
    String password,
    String referral,
    String email,
  ) async {
    var post_body = jsonEncode({
      "user_name": "$name",
      "user_mobile": "$phone",
      "user_password": "$password",
      "user_referral": "$referral",
      "user_email": "$email",
      "auto_fill_sms_key": "",
      "fcm_device_token": ""

      // "register_by": "$register_by"
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/auth/signup");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$,
        },
        body: post_body);

    return signupResponseFromJson(response.body);
  }

  Future<ResendCodeResponse> getResendCodeResponse(
      String phone, String verify_by) async {
    var post_body =
        jsonEncode({"user_mobile": "$phone", "verify_by": "$verify_by"});

    Uri url = Uri.parse("${AppConfig.BASE_URL_2}/auth/resend_code");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          // "App-Language": app_language.$,
        },
        body: post_body);

    return resendCodeResponseFromJson(response.body);
  }

  Future<ConfirmCodeResponse> getConfirmCodeResponse(
      phone, verification_code) async {
    var post_body = jsonEncode(
        {"user_mobile": "$phone", "verification_code": "$verification_code"});

    Uri url = Uri.parse("${AppConfig.BASE_URL_2}/auth/confirm_code");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$,
        },
        body: post_body);

    return confirmCodeResponseFromJson(response.body);
  }

  Future<PasswordForgetResponse> getPasswordForgetResponse(
      String email_or_phone, String send_code_by) async {
    var post_body = jsonEncode(
        {"email_or_phone": "$email_or_phone", "send_code_by": "$send_code_by"});

    Uri url = Uri.parse(
      "${AppConfig.BASE_URL}/auth/password/forget_request",
    );
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$,
        },
        body: post_body);

    //print(response.body.toString());

    return passwordForgetResponseFromJson(response.body);
  }

  Future<PasswordConfirmResponse> getPasswordConfirmResponse(
      String verification_code, String password) async {
    var post_body = jsonEncode(
        {"verification_code": "$verification_code", "password": "$password"});

    Uri url = Uri.parse(
      "${AppConfig.BASE_URL}/auth/password/confirm_reset",
    );
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$,
        },
        body: post_body);

    return passwordConfirmResponseFromJson(response.body);
  }

  Future<ResendCodeResponse> getPasswordResendCodeResponse(
      String email_or_code, String verify_by) async {
    var post_body = jsonEncode(
        {"email_or_code": "$email_or_code", "verify_by": "$verify_by"});

    Uri url = Uri.parse("${AppConfig.BASE_URL}/auth/password/resend_code");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$,
        },
        body: post_body);

    return resendCodeResponseFromJson(response.body);
  }

  Future<UserByTokenResponse> getUserByTokenResponse() async {
    var post_body = jsonEncode({"access_token": "${access_token.$}"});

    Uri url = Uri.parse("${AppConfig.BASE_URL_2}/user");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",

          // "App-Language": app_language.$,
        },
        body: post_body);

    return userByTokenResponseFromJson(response.body);
  }
}
