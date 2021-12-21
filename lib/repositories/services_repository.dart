import 'package:active_ecommerce_flutter/data_model/services_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:http/http.dart' as http;
import '../app_config.dart';

class ServicesRepository {
  Future<PublicServicesResponse> getServicesList() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL_2}/thirdparty/service");

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.$}",
      },
    );
    print("This is token ----------${access_token.$}");
    print(response.body);
    return publicServicesResponseFromJson(response.body);
  }
}
