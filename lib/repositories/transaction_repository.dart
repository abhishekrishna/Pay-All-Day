import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/data_model/transaction_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:http/http.dart' as http;

class TransactionRepository {
  Future<TransactionResponse> getTransactions() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL_2}/wallet/transaction-details");

    final response = await http.post(url, headers: {
      "Authorization": "Bearer ${access_token.$}",
      // "App-Language": app_language.$,
    }, body: {
      "id": "3"
    });

    print(response.body.toString());
    return transactionResponseFromJson(response.body);
  }
}
