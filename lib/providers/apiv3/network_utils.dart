// ignore_for_file: file_names

import 'package:connectivity/connectivity.dart';

/*
* https://stackoverflow.com/a/54644937
* */

class NetworkUtils {
  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  dynamic checkInternet(Function func) {
    check().then((internet) {
      // ignore: unnecessary_null_comparison
      if (internet != null && internet) {
        func(true);
      } else {
        func(false);
      }
    });
  }
}
