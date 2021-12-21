import 'dart:convert';

import 'package:active_ecommerce_flutter/data_model/operator_list_response.dart';

import '../app_config.dart';
import 'package:http/http.dart' as http;
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';

class OperatorListRepository {
  Future<OperatorListResponse> getOpeartorListResponse(
    String rechargeService,
  ) async {
    var post_body = jsonEncode({
      "recharge_service": "$rechargeService",
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL_2}/recharge/operators-list");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          // "App-Language": app_language.$
        },
        body: post_body);

    print("hello" + response.body.toString());
    return operatorListResponseFromJson(response.body);
  }
}
