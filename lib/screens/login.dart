import 'dart:convert';

import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
import 'package:active_ecommerce_flutter/screens/home.dart';
import 'package:active_ecommerce_flutter/ui_sections/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:active_ecommerce_flutter/screens/registration.dart';
import 'package:active_ecommerce_flutter/screens/main.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:active_ecommerce_flutter/repositories/auth_repository.dart';
import 'package:active_ecommerce_flutter/helpers/auth_helper.dart';

import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _login_by = "email"; //phone or email
  String initialCountry = 'US';
  PhoneNumber phoneCode = PhoneNumber(isoCode: 'US', dialCode: "+1");
  String _phone = "";

  //controllers
  TextEditingController _phoneNumberController = TextEditingController();
  // TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    //on Splash Screen hide statusbar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    //before going to other screen show statusbar
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  onPressedLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var email = _phoneNumberController.text.toString();
    var password = _passwordController.text.toString();

    // if (_login_by == 'email' && email == "") {
    //   ToastComponent.showDialog(
    //       AppLocalizations.of(context).login_screen_email_warning, context,
    //       gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    //   return;
    // } else if (_login_by == 'phone' && _phone == "") {
    //   ToastComponent.showDialog(
    //       AppLocalizations.of(context).login_screen_phone_warning, context,
    //       gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    //   return;
    // } else if (password == "") {
    //   ToastComponent.showDialog(
    //       AppLocalizations.of(context).login_screen_password_warning, context,
    //       gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    //   return;
    // }
    var loginResponse = await AuthRepository()
        .getLoginResponse(_login_by == 'email' ? email : _phone, password);
    // var loginsMarketResponse = await AuthRepository().getsMarketLoginResponse(
    //     _login_by == 'email' ? email : _phone, password);
    if (loginResponse.result == false) {
      ToastComponent.showDialog(loginResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    } else {
      AuthHelper().setUserData(loginResponse);
      ToastComponent.showDialog(loginResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);

      if (loginResponse.result == false) {
        ToastComponent.showDialog(loginResponse.message, context,
            gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      } else {
        ToastComponent.showDialog(loginResponse.message, context,
            gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);

        if (loginResponse.result == true) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Home()),
              (Route<dynamic> route) => false);
          // Map<String, dynamic> resposne = jsonDecode(loginResponse.access_token);
          preferences.setInt('value', 1);
          print(preferences.getInt('value').toString() + '--------------');
        }
      }

      // print(object)

      // push notification starts
      // if (OtherConfig.USE_PUSH_NOTIFICATION) {
      //   final FirebaseMessaging _fcm = FirebaseMessaging.instance;

      //   await _fcm.requestPermission(
      //     alert: true,
      //     announcement: false,
      //     badge: true,
      //     carPlay: false,
      //     criticalAlert: false,
      //     provisional: false,
      //     sound: true,
      //   );

      //   String fcmToken = await _fcm.getToken();

      //   if (fcmToken != null) {
      //     print("--fcm token--");
      //     print(fcmToken);
      //     if (is_logged_in.$ == true) {
      //       // update device token
      //       var deviceTokenUpdateResponse = await ProfileRepository()
      //           .getDeviceTokenUpdateResponse(fcmToken);
      //     }
      //   }
      // }

      //push norification ends

      // onPressedFacebookLogin() async {
      //   final facebookLogin = FacebookLogin();
      //   final facebookLoginResult = await facebookLogin.logIn(['email']);

      //   /*print(facebookLoginResult.accessToken);
      //   print(facebookLoginResult.accessToken.token);
      //   print(facebookLoginResult.accessToken.expires);
      //   print(facebookLoginResult.accessToken.permissions);
      //   print(facebookLoginResult.accessToken.userId);
      //   print(facebookLoginResult.accessToken.isValid());

      //   print(facebookLoginResult.errorMessage);
      //   print(facebookLoginResult.status);*/

      //   final token = facebookLoginResult.accessToken.token;

      //   /// for profile details also use the below code
      //   Uri url = Uri.parse(
      //       'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
      //   final graphResponse = await http.get(url);
      //   final profile = json.decode(graphResponse.body);
      //   //print(profile);
      //   /*from profile you will get the below params
      //   {
      //    "name": "Iiro Krankka",
      //    "first_name": "Iiro",
      //    "last_name": "Krankka",
      //    "email": "iiro.krankka\u0040gmail.com",
      //    "id": "<user id here>"
      //   }*/

      //   var loginResponse = await AuthRepository().getSocialLoginResponse(
      //       profile['name'], profile['email'], profile['id'].toString());

      //   if (loginResponse.result == false) {
      //     ToastComponent.showDialog(loginResponse.message, context,
      //         gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      //   } else {
      //     ToastComponent.showDialog(loginResponse.message, context,
      //         gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      //     AuthHelper().setUserData(loginResponse);
      //     Navigator.push(context, MaterialPageRoute(builder: (context) {
      //       return Main();
      //     }));
      //   }
      // }

      // onPressedGoogleLogin() async {
      //   GoogleSignIn _googleSignIn = GoogleSignIn(
      //     scopes: [
      //       'email',
      //       // you can add extras if you require
      //     ],
      //   );

      //   _googleSignIn.signIn().then((GoogleSignInAccount acc) async {
      //     GoogleSignInAuthentication auth = await acc.authentication;
      //     print(acc.id);
      //     print(acc.email);
      //     print(acc.displayName);
      //     print(acc.photoUrl);

      //     acc.authentication.then((GoogleSignInAuthentication auth) async {
      //       print(auth.idToken);
      //       print(auth.accessToken);

      //       //---------------------------------------------------
      //       var loginResponse = await AuthRepository().getSocialLoginResponse(
      //           acc.displayName, acc.email, auth.accessToken);

      //       if (loginResponse.result == false) {
      //         ToastComponent.showDialog(loginResponse.message, context,
      //             gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      //       } else {
      //         ToastComponent.showDialog(loginResponse.message, context,
      //             gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      //         AuthHelper().setUserData(loginResponse);
      //         Navigator.push(context, MaterialPageRoute(builder: (context) {
      //           return Main();
      //         }));
      //       }

      //       //-----------------------------------
      //     });
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(children: [
                    ClipPath(
                      clipper: BezierClipper(),
                      child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                                colors: <Color>[
                              Color(0xFF0288D1),
                              Color(0xFF1565C0)
                            ])),

                        height: _screen_height * 0.40,
                        // child:
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 35, 10, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child:
                                  Image.asset("assets/logo0.png", height: 35),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Text(
                              "Login or Create an Account",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  letterSpacing: 0.5),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Text(
                              "Fast and Secure Paments, Pay Utility Bills or \nMobile Recharge & Get CashBack",
                              style: TextStyle(
                                  fontSize: 10, color: Colors.white60),
                            ),
                            Column(children: [
                              SizedBox(
                                height: _screen_width * 0.25,
                              ),
                              // SizedBox(
                              //   height: 40,
                              //   child: TextFormField(
                              //     inputFormatters: [
                              //       FilteringTextInputFormatter.digitsOnly
                              //     ],
                              //     decoration: const InputDecoration(
                              //         hintText: "Mobile Number",
                              //         prefixIcon: Icon(
                              //           Icons.phone,
                              //           color: Color(0xFF000000),
                              //         ),
                              //         hintStyle: TextStyle(
                              //             fontWeight: FontWeight.bold,
                              //             color: Colors.black,
                              //             fontSize: 12)),
                              //     controller: _mobileController,
                              //     keyboardType: TextInputType.number,
                              //   ),
                              // ),
                              Container(
                                width: double.infinity,
                                child: SingleChildScrollView(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: _screen_width * (3.5 / 4),
                                      child: Column(
                                        children: [
                                          // Padding(
                                          //   padding: const EdgeInsets.only(
                                          //       bottom: 4.0),
                                          //   child: Text(
                                          //     _login_by == "email"
                                          //         ? AppLocalizations.of(context)
                                          //             .login_screen_email
                                          //         : AppLocalizations.of(context)
                                          //             .login_screen_phone,
                                          //     style: TextStyle(
                                          //         color: MyTheme.accent_color,
                                          //         fontWeight: FontWeight.w600),
                                          //   ),
                                          // ),
                                          // if (_login_by == "email")
                                          //   Padding(
                                          //     padding: const EdgeInsets.only(
                                          //         bottom: 8.0),
                                          //     child: Column(
                                          //       crossAxisAlignment:
                                          //           CrossAxisAlignment.end,
                                          //       children: [
                                          //         Container(
                                          //           height: 36,
                                          //           child: TextField(
                                          //             controller:
                                          //                 _emailController,
                                          //             autofocus: false,
                                          //             decoration: InputDecorations
                                          //                 .buildInputDecoration_1(
                                          //                     hint_text:
                                          //                         "johndoe@example.com"),
                                          //           ),
                                          //         ),
                                          //         AddonConfig.otp_addon_installed
                                          //             ? GestureDetector(
                                          //                 onTap: () {
                                          //                   setState(() {
                                          //                     _login_by = "phone";
                                          //                   });
                                          //                 },
                                          //                 child: Text(
                                          //                   AppLocalizations.of(
                                          //                           context)
                                          //                       .login_screen_or_login_with_phone,
                                          //                   style: TextStyle(
                                          //                       color: MyTheme
                                          //                           .accent_color,
                                          //                       fontStyle:
                                          //                           FontStyle
                                          //                               .italic,
                                          //                       decoration:
                                          //                           TextDecoration
                                          //                               .underline),
                                          //                 ),
                                          //               )
                                          //             : Container()
                                          //       ],
                                          //     ),
                                          //   )
                                          // else
                                          //   Padding(
                                          //     padding: const EdgeInsets.only(
                                          //         bottom: 8.0),
                                          //     child: Column(
                                          //       crossAxisAlignment:
                                          //           CrossAxisAlignment.end,
                                          //       children: [
                                          //         Container(
                                          //           height: 36,
                                          //           child:
                                          //               CustomInternationalPhoneNumberInput(
                                          //             onInputChanged:
                                          //                 (PhoneNumber number) {
                                          //               print(number.phoneNumber);
                                          //               setState(() {
                                          //                 _phone =
                                          //                     number.phoneNumber;
                                          //               });
                                          //             },
                                          //             onInputValidated:
                                          //                 (bool value) {
                                          //               print(value);
                                          //             },
                                          //             selectorConfig:
                                          //                 SelectorConfig(
                                          //               selectorType:
                                          //                   PhoneInputSelectorType
                                          //                       .DIALOG,
                                          //             ),
                                          //             ignoreBlank: false,
                                          //             autoValidateMode:
                                          //                 AutovalidateMode
                                          //                     .disabled,
                                          //             selectorTextStyle:
                                          //                 TextStyle(
                                          //                     color: MyTheme
                                          //                         .font_grey),
                                          //             textStyle: TextStyle(
                                          //                 color:
                                          //                     MyTheme.font_grey),
                                          //             initialValue: phoneCode,
                                          //             textFieldController:
                                          //                 _phoneNumberController,
                                          //             formatInput: true,
                                          //             keyboardType: TextInputType
                                          //                 .numberWithOptions(
                                          //                     signed: true,
                                          //                     decimal: true),
                                          //             inputDecoration: InputDecorations
                                          //                 .buildInputDecoration_phone(
                                          //                     hint_text:
                                          //                         "01710 333 558"),
                                          //             onSaved:
                                          //                 (PhoneNumber number) {
                                          //               print(
                                          //                   'On Saved: $number');
                                          //             },
                                          //           ),
                                          //         ),
                                          // GestureDetector(
                                          //   onTap: () {
                                          //     setState(() {
                                          //       _login_by = "email";
                                          //     });
                                          //   },
                                          //   child: Text(
                                          //     AppLocalizations.of(context)
                                          //         .login_screen_or_login_with_email,
                                          //     style: TextStyle(
                                          //         color: MyTheme
                                          //             .accent_color,
                                          //         fontStyle:
                                          //             FontStyle.italic,
                                          //         decoration:
                                          //             TextDecoration
                                          //                 .underline),
                                          //   ),
                                          // )
                                          //     ],
                                          //   ),
                                          // ),
                                          SizedBox(
                                            height: _screen_height * 0.05,
                                          ),
                                          CustomTextField(
                                              "Mobile Number",
                                              Icons.mobile_friendly,
                                              _phoneNumberController),
                                          SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    10,
                                            child: TextField(
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                  hintText: "Password",
                                                  prefixIcon: Icon(
                                                    Icons.password,
                                                    color:
                                                        const Color(0xFF000000),
                                                  ),
                                                  hintStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 12)),
                                              controller: _passwordController,
                                            ),
                                          ),
                                          // CustomTextField(
                                          //     "Password",
                                          //     Icons.phone_android,
                                          //     _passwordController),
                                          SizedBox(
                                            height: _screen_height * 0.15,
                                          ),
                                          Center(
                                            child: CustomButton(Icons.login,
                                                "Login", onPressedLogin),
                                          )

                                          // Padding(
                                          //   padding:
                                          //       const EdgeInsets.only(top: 30.0),
                                          //   child: Container(
                                          //     height: 45,
                                          //     decoration: BoxDecoration(
                                          //         border: Border.all(
                                          //             color:
                                          //                 MyTheme.textfield_grey,
                                          //             width: 1),
                                          //         borderRadius:
                                          //             const BorderRadius.all(
                                          //                 Radius.circular(12.0))),
                                          //     child: FlatButton(
                                          //       minWidth: MediaQuery.of(context)
                                          //           .size
                                          //           .width,
                                          //       //height: 50,
                                          //       color: MyTheme.golden,
                                          //       shape: RoundedRectangleBorder(
                                          //           borderRadius:
                                          //               const BorderRadius.all(
                                          //                   Radius.circular(
                                          //                       12.0))),
                                          //       child: Text(
                                          //         AppLocalizations.of(context)
                                          //             .login_screen_log_in,
                                          //         style: TextStyle(
                                          //             color: Colors.white,
                                          //             fontSize: 14,
                                          //             fontWeight:
                                          //                 FontWeight.w600),
                                          //       ),
                                          //       onPressed: () {
                                          //         onPressedLogin();
                                          //       },
                                          //     ),
                                          //   ),
                                          // ),

                                          // Visibility(
                                          //   visible:
                                          //       SocialConfig.allow_google_login ||
                                          //           SocialConfig.allow_facebook_login,
                                          //   child: Padding(
                                          //     padding:
                                          //         const EdgeInsets.only(top: 20.0),
                                          //     child: Center(
                                          //         child: Text(
                                          //       AppLocalizations.of(context)
                                          //           .login_screen_login_with,
                                          //       style: TextStyle(
                                          //           color: MyTheme.medium_grey,
                                          //           fontSize: 14),
                                          //     )),
                                          //   ),
                                          // ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(top: 30.0),
                                          //   child: Center(
                                          //     child: Container(
                                          //       width: 120,
                                          //       child: Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment.spaceBetween,
                                          //         children: [
                                          //           Visibility(
                                          //             visible: SocialConfig
                                          //                 .allow_google_login,
                                          //             child: InkWell(
                                          //               onTap: () {
                                          //                 onPressedGoogleLogin();
                                          //               },
                                          //               child: Container(
                                          //                 width: 28,
                                          //                 child: Image.asset(
                                          //                     "assets/google_logo.png"),
                                          //               ),
                                          //             ),
                                          //           ),
                                          //           Visibility(
                                          //             visible: SocialConfig
                                          //                 .allow_facebook_login,
                                          //             child: InkWell(
                                          //               onTap: () {
                                          //                 onPressedFacebookLogin();
                                          //               },
                                          //               child: Container(
                                          //                 width: 28,
                                          //                 child: Image.asset(
                                          //                     "assets/facebook_logo.png"),
                                          //               ),
                                          //             ),
                                          //           ),
                                          //           // Visibility(
                                          //           //   visible: false,
                                          //           //   child: InkWell(
                                          //           //     onTap: () {
                                          //           //       // onPressedTwitterLogin();
                                          //           //     },
                                          //           //     child: Container(
                                          //           //       width: 28,
                                          //           //       child: Image.asset(
                                          //           //           "assets/twitter_logo.png"),
                                          //           //     ),
                                          //           //   ),
                                          //           // ),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                              ),
                            ])
                          ]),
                    ),
                  ]),
                  // Container(
                  //   height: SizeConfig.blockSizeVertical * 17.3,
                  //   width: double.infinity,
                  // ),
                  Transform.rotate(
                      angle: 3.14,
                      child: ClipPath(
                        clipper: BottomClipper(),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.indigo[900]),
                          width: double.infinity,
                          height: _screen_height * 0.20,
                          child: Align(
                            alignment: Alignment.center,
                            child: Transform.rotate(
                                angle: 3.14,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  Registration()));
                                    },
                                    child: RichText(
                                      text: const TextSpan(
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              letterSpacing: 0.8),
                                          children: [
                                            TextSpan(
                                                text:
                                                    "Don't have an account ? "),
                                            TextSpan(
                                                text: "Signup",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ]),
                                    ))),
                          ),
                        ),
                      ))
                ],
              ),
            )
            // bottomNavigationBar: BottomNavigationBar(fixedColor: LinearGradient[],),
            ));
  }
}

class BezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.9); //vertical line
    path.quadraticBezierTo(size.width / 2, size.height, size.width,
        size.height * 0.1); //quadratic curve
    path.lineTo(size.width, 0); //vertical line
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 35.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 75);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 0);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
