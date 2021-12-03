import 'dart:convert';

import 'package:active_ecommerce_flutter/data_model/operator_data_response.dart';

import '../app_config.dart';
import 'package:http/http.dart' as http;
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';

class OperatorRepository {
  Future<OperatorData> getOpeartorDataResponse(
    String phoneNumber,
    String rechargeService,
    String rechargeServiceType,
  ) async {
    var post_body = jsonEncode({
      "recharge_phone": "$phoneNumber",
      "recharge_service": "$rechargeService",
      "recharge_service_type_id": "$rechargeServiceType",
    });

    Uri url =
        Uri.parse("${AppConfig.BASE_URL_2}/recharge/find-mobile-operator");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          // "App-Language": app_language.$
        },
        body: post_body);

    print("hello" + response.body.toString());
    return operatorDataFromJson(response.body);
  }
}
