import 'dart:convert';
import 'package:active_ecommerce_flutter/data_model/operator_plans_response.dart';

import '../app_config.dart';
import 'package:http/http.dart' as http;
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';

class OperatorPlansRepository {
  Future<PlansData> getOperatorPlansResponse(
      String phoneNumber,
      String rechargeService,
      String rechargeOperatorCode,
      String rechargeOperatorCircle) async {
    var post_body = jsonEncode({
      {
        "recharge_phone": "$phoneNumber",
        "recharge_service": "$rechargeService",
        "recharge_operator_code": "$rechargeOperatorCode",
        "recharge_operator_circel": "$rechargeOperatorCircle"
      }
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL_2}/recharge/mobile-plans");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          // "App-Language": app_language.$
        },
        body: post_body);

    print("hello" + response.body.toString());
    return plansDataFromJson(response.body);
  }
}
