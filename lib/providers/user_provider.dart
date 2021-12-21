// import 'package:active_ecommerce_flutter/data_model/login_response.dart';
// import 'package:active_ecommerce_flutter/data_model/user_profile_response.dart';
// import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
// import 'package:active_ecommerce_flutter/repositories/user_repository.dart';
// import 'package:active_ecommerce_flutter/screens/login.dart';
// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserProvider with ChangeNotifier {
//   LoginResponse _user = new LoginResponse();

//   LoginResponse get user => _user;

//   void setUser(LoginResponse user) {
//     _user = user;
//     notifyListeners();
//   }
// }

// class UserPreferences {
//   Future<bool> saveUser(LoginResponse user) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     prefs.setInt("userId", user.user.id);
//     prefs.setString("name", user.user.name);
//     prefs.setString("email", user.user.email);
//     prefs.setString("phone", user.user.phone);
//     prefs.setString("type", user.user.type);
//     prefs.setString("token", user.access_token);

//     return saveUser(user);
//   }

//   Future<LoginResponse> getUser() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     String id = prefs.getString("user_id");
//     String name = prefs.getString("name");
//     String email = prefs.getString("email");
//     String phone = prefs.getString("phone");
//     String type = prefs.getString("type");
//     String token = prefs.getString("token");

//     return LoginResponse(
//       user: user_i,
//       name: name,
//       email: email,
//       phone: phone,
//       type: type,
//       token: token,
//     );
//   }

//   void removeUser() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     prefs.remove("name");
//     prefs.remove("email");
//     prefs.remove("phone");
//     prefs.remove("type");
//     prefs.remove("token");
//   }

//   Future<String> getToken(args) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString("token");
//     return token;
//   }
// }
