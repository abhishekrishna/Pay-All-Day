import 'dart:convert';

import 'package:active_ecommerce_flutter/data_model/mobile_recharge_request_response.dart';
import 'package:active_ecommerce_flutter/data_model/recharge_status_response.dart';

import '../app_config.dart';
import 'package:http/http.dart' as http;
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';

class MobileRechargeStatusRepository {
  Future<RechargeStatusModel> checkMobileRechargeStatusRequest(
      String rechargeTransactionId) async {
    var post_body = jsonEncode({
      "recharge_transaction_id": rechargeTransactionId,
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL_2}/recharge/status");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          // "App-Language": app_language.$
        },
        body: post_body);

    print("hello" + response.body.toString());
    return rechargeStatusModelFromJson(response.body);
  }
}
