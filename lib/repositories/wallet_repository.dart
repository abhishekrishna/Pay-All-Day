import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:active_ecommerce_flutter/data_model/wallet_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';

class WalletRepository {
  Future<WalletReponse> getBalance() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL_2}/wallet/all-balance");

    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${access_token.$}",
        // "App-Language": app_language.$,
      },
    );

    print(response.body.toString());
    return walletReponseFromJson(response.body);
  }

  // Future<WalletReponse> getRechargeList({int page = 1}) async {
  //   Uri url = Uri.parse(
  //       "${AppConfig.BASE_URL}/wallet/history/${user_id.$}?page=${page}");

  //   final response = await http.get(
  //     url,
  //     headers: {
  //       "Authorization": "Bearer ${access_token.$}",
  //       "App-Language": app_language.$,
  //     },
  //   );

  //   print("url:" + url.toString());
  //   print(response.body);
  //   return walletReponseFromJson(response.body);
  // }
}
