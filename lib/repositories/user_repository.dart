import 'package:active_ecommerce_flutter/data_model/user_profile_response.dart';

import '../app_config.dart';
import 'package:http/http.dart' as http;
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';

class UserDataRepository {
  Future<UserData> getUserDataResponse() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL_2}/auth/user");
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.$}",
        // "App-Language": app_language.$
      },
    );

    print("hello" + response.body);
    return userDataFromJson(response.body);
  }
}
