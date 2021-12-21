import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/screens/registration.dart';
import 'package:active_ecommerce_flutter/ui_sections/sendMoneyRow/passbook.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:active_ecommerce_flutter/screens/main.dart';
import 'package:active_ecommerce_flutter/screens/profile.dart';
import 'package:active_ecommerce_flutter/screens/order_list.dart';
import 'package:active_ecommerce_flutter/screens/wishlist.dart';

import 'package:active_ecommerce_flutter/screens/login.dart';
import 'package:active_ecommerce_flutter/screens/messenger_list.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/helpers/auth_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({
    Key key,
  }) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  onTapLogout(context) async {
    AuthHelper().clearUserData();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();

    // var logoutResponse = await AuthRepository().getLogoutResponse();

    // if (logoutResponse.result == true) {
    //   ToastComponent.showDialog(logoutResponse.message, context,
    //       gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    // }

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (ctx) => Login()), (route) => false);
  }

  var _loginStatus = 0;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _loginStatus = preferences.getInt("value");
      print(_loginStatus);
      // preferences.clear();
      // print(_loginStatus);
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Drawer(
      child: Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Container(
          // padding: EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: SizeConfig.blockSizeVertical * 35,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: <Color>[
                          Color(0xFF0288D1),
                          Color(0xFF0D47A1),
                        ])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "assets/logo0.png",
                          fit: BoxFit.contain,
                          height: SizeConfig.safeBlockVertical * 5,
                        ),
                        Center(
                          // padding: const EdgeInsets.only(left: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome to PayAllDay",
                                style: TextStyle(color: Colors.white),
                              ),
                              // SizedBox(
                              //   width: SizeConfig.safeBlockHorizontal * 0.5,
                              //   child: ElevatedButton(
                              //       onPressed: () {
                              //         Navigator.push(
                              //             context,
                              //             MaterialPageRoute(
                              //                 builder: (ctx) => ProfileScreen()));
                              //       },
                              //       child: Text(
                              //         "My Profile",
                              //         style: TextStyle(color: Colors.blue),
                              //       ),
                              //       style: ButtonStyle(
                              //         backgroundColor: MaterialStateProperty.all<Color>(
                              //             Colors.white),
                              //       )),
                              // ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 2,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => Registration()));
                                },
                                child: Text(
                                  "    Create an Account",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 2,
                              ),
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  AppConfig.BASE_PATH_2 +
                                      "${avatar_original.$}",
                                ),
                              ),
                              _loginStatus == 1
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: ListTile(
                                        title: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: Text(
                                              "${user_phone.$}",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        // subtitle: user_name.$ != "" &&
                                        //         user_name.$ != null
                                        //     ? Text(
                                        //         "${user_name.$}",
                                        //         style: TextStyle(
                                        //             color: Colors.white),
                                        //       )
                                        //     : Text(
                                        //         "${user_phone.$}",
                                        //         style: TextStyle(
                                        //             color: Colors.white),
                                        //       )
                                      ),
                                    )
                                  : Text(
                                      AppLocalizations.of(context)
                                          .main_drawer_not_logged_in,
                                      style: TextStyle(
                                          color: MyTheme.black_color,
                                          fontSize: 14)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Divider(),
                ListTile(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    leading: Image.asset("assets/home.png",
                        height: 16, color: MyTheme.black_color),
                    title: Text(AppLocalizations.of(context).main_drawer_home,
                        style: TextStyle(
                            color: MyTheme.black_color, fontSize: 14)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Main();
                      }));
                    }),
                _loginStatus == 1
                    ? ListTile(
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                        leading: Image.asset("assets/profile.png",
                            height: 16, color: MyTheme.black_color),
                        title: Text(
                            AppLocalizations.of(context).main_drawer_profile,
                            style: TextStyle(
                                color: MyTheme.black_color, fontSize: 14)),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Profile(show_back_button: true);
                          }));
                        })
                    : Container(),
                _loginStatus == 1
                    ? ListTile(
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                        leading: Icon(Icons.payment,
                            size: 20, color: MyTheme.black_color),
                        title: Text(
                            AppLocalizations.of(context).payment_history,
                            style: TextStyle(
                                color: MyTheme.black_color, fontSize: 14)),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return OrderList(from_checkout: false);
                          }));
                        })
                    : Container(),
                _loginStatus == 1
                    ? ListTile(
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                        leading: Image.asset("assets/heart.png",
                            height: 16, color: MyTheme.black_color),
                        title: Text(
                            AppLocalizations.of(context).terms_and_conditions,
                            style: TextStyle(
                                color: MyTheme.black_color, fontSize: 14)),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Wishlist();
                          }));
                        })
                    : Container(),
                _loginStatus == 1
                    ? ListTile(
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                        leading: Icon(Icons.privacy_tip,
                            size: 20, color: MyTheme.black_color),
                        title: Text(AppLocalizations.of(context).privacy_policy,
                            style: TextStyle(
                                color: MyTheme.black_color, fontSize: 14)),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return MessengerList();
                          }));
                        })
                    : Container(),
                _loginStatus == 1
                    ? ListTile(
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                        leading: Image.asset("assets/wallet.png",
                            height: 16, color: MyTheme.black_color),
                        title: Text(
                            AppLocalizations.of(context).main_drawer_wallet,
                            style: TextStyle(
                                color: MyTheme.black_color, fontSize: 14)),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Passbook();
                          }));
                        })
                    : Container(),
                Divider(height: 24),
                // _loginStatus == 1
                //     ? ListTile(
                //         visualDensity:
                //             VisualDensity(horizontal: -4, vertical: -4),
                //         leading: Image.asset("assets/login.png",
                //             height: 16, color: MyTheme.black_color),
                //         title: Text(
                //             AppLocalizations.of(context).main_drawer_login,
                //             style: TextStyle(
                //                 color: MyTheme.black_color, fontSize: 14)),
                //         onTap: () {
                //           Navigator.push(context,
                //               MaterialPageRoute(builder: (context) {
                //             return Login();
                //           }));
                //         })
                //     : Container(),
                _loginStatus == 1
                    ? ListTile(
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                        leading: Image.asset("assets/logout.png",
                            height: 16, color: MyTheme.black_color),
                        title: Text(
                            AppLocalizations.of(context).main_drawer_logout,
                            style: TextStyle(
                                color: MyTheme.black_color, fontSize: 14)),
                        onTap: () {
                          onTapLogout(context);
                        })
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
