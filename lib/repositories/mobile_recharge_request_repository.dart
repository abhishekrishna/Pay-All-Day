import 'dart:convert';

import 'package:active_ecommerce_flutter/data_model/mobile_recharge_request_response.dart';

import '../app_config.dart';
import 'package:http/http.dart' as http;
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';

class MobileRechargeRequestRepository {
  Future<RechargeRequestModel> chargeMobileRechargeRequest(
      String rechargeNumber,
      String rechargePlanId,
      String rechargePlanAmount,
      String rechargeOperatorId,
      String rechargePaymentMode) async {
    var post_body = jsonEncode({
      "recharge_number": rechargeNumber,
      "recharge_plan_id": rechargePlanId,
      "recharge_plan_amount": rechargePlanAmount,
      "recharge_operator_id": rechargeOperatorId,
      "recharge_payment_mode": rechargePaymentMode
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL_2}/recharge/request");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          // "App-Language": app_language.$
        },
        body: post_body);

    print("hello" + response.body.toString());
    return rechargeRequestModelFromJson(response.body);
  }
}
