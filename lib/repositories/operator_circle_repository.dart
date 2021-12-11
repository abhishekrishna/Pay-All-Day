import 'package:active_ecommerce_flutter/data_model/operator_circle_response.dart';

import '../app_config.dart';
import 'package:http/http.dart' as http;
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';

class OperatorCircleRepository {
  Future<CircleReponse> getOperatorCircleResponse() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL_2}/recharge/circle");
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${access_token.$}",
        // "App-Language": app_language.$,
      },
    );
    print("this is op circle --> ${response.body}");
    return circleReponseFromJson(response.body);
  }
}
