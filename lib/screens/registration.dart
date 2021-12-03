import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/providers/apiv3/api_constants.dart';
import 'package:active_ecommerce_flutter/providers/apiv3/network_utils.dart';
import 'package:active_ecommerce_flutter/providers/apiv3/on_response_callback.dart';
import 'package:active_ecommerce_flutter/ui_sections/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:active_ecommerce_flutter/custom/input_decorations.dart';
import 'package:active_ecommerce_flutter/custom/intl_phone_input.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:active_ecommerce_flutter/addon_config.dart';
import 'package:active_ecommerce_flutter/screens/otp.dart';
import 'package:active_ecommerce_flutter/screens/login.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:active_ecommerce_flutter/repositories/auth_repository.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String _register_by = "email"; //phone or email
  String initialCountry = 'US';
  PhoneNumber phoneCode = PhoneNumber(isoCode: 'US', dialCode: "+1");

  String _phone = "";

  //controllers
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _refferalCodeController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

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

  goToOTPScreen() {
    onPressSignUp();
    var resendOTPphone = _phoneNumberController.text.toString();
    Navigator.push(context,
        MaterialPageRoute(builder: (ctx) => Otp(resendOTPphone, _register_by)));
  }

  onPressSignUp() async {
    var name = _nameController.text.toString();
    var email = _emailController.text.toString();
    var phone = _phoneNumberController.text.toString();
    var referral = _refferalCodeController.text.toString();
    var password = _passwordController.text.toString();
    var password_confirm = _passwordConfirmController.text.toString();

    if (name == "") {
      ToastComponent.showDialog(
          AppLocalizations.of(context).registration_screen_name_warning,
          context,
          gravity: Toast.CENTER,
          duration: Toast.LENGTH_LONG);
      return;
    } else if (_register_by == 'email' && email == "") {
      ToastComponent.showDialog(
          AppLocalizations.of(context).registration_screen_email_warning,
          context,
          gravity: Toast.CENTER,
          duration: Toast.LENGTH_LONG);
      return;
    } else if (_register_by == 'phone' && _phone == "") {
      ToastComponent.showDialog(
          AppLocalizations.of(context).registration_screen_phone_warning,
          context,
          gravity: Toast.CENTER,
          duration: Toast.LENGTH_LONG);
      return;
    } else if (password == "") {
      ToastComponent.showDialog(
          AppLocalizations.of(context).registration_screen_password_warning,
          context,
          gravity: Toast.CENTER,
          duration: Toast.LENGTH_LONG);
      return;
    } else if (password_confirm == "") {
      ToastComponent.showDialog(
          AppLocalizations.of(context)
              .registration_screen_password_confirm_warning,
          context,
          gravity: Toast.CENTER,
          duration: Toast.LENGTH_LONG);
      return;
    } else if (password.length < 6) {
      ToastComponent.showDialog(
          AppLocalizations.of(context)
              .registration_screen_password_length_warning,
          context,
          gravity: Toast.CENTER,
          duration: Toast.LENGTH_LONG);
      return;
    } else if (password != password_confirm) {
      ToastComponent.showDialog(
          AppLocalizations.of(context)
              .registration_screen_password_match_warning,
          context,
          gravity: Toast.CENTER,
          duration: Toast.LENGTH_LONG);
      return;
    }

    var signupResponse = await AuthRepository().getSignupResponse(
      name,
      phone,
      password,
      referral,
      email,
    );

    if (signupResponse.result == false) {
      ToastComponent.showDialog(signupResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    } else {
      ToastComponent.showDialog(signupResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return Login();
        }),
      );
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) {
      //     return Otp(
      //       verify_by: _register_by,
      //       user_id: signupResponse.user_id,
      //     );
      //   }),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(children: [
              // Container(
              //   width: _screen_width * (3 / 4),
              //   child: Image.asset(
              //       "assets/splash_login_registration_background_image.png"),
              // ),
              Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0, bottom: 15),
                          child: Container(
                            height: 100,
                            child: Image.asset('assets/logocol.png'),
                          ),
                        ),
                        Container(
                          width: _screen_width * (3.5 / 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                  "Username", Icons.person, _nameController),
                              CustomTextField(
                                  "Mobile Number",
                                  Icons.mobile_friendly,
                                  _phoneNumberController),
                              CustomTextField("Referral", Icons.code,
                                  _refferalCodeController),
                              CustomTextField(
                                  "Email", Icons.email, _emailController),
                              CustomTextField("Password", Icons.password,
                                  _passwordController),
                              CustomTextField("Confirm Password", Icons.lock,
                                  _passwordConfirmController),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Forgot Password",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.2,
                                        fontSize: 10,
                                        color: Colors.indigo),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                            Icons.app_registration, "sign up", goToOTPScreen),
                        SizedBox(
                          height: 20,
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 4.0),
                        //   child: Text(
                        //     _register_by == "email"
                        //         ? AppLocalizations.of(context)
                        //             .registration_screen_email
                        //         : AppLocalizations.of(context)
                        //             .registration_screen_phone,
                        //     style: TextStyle(
                        //         color: MyTheme.accent_color,
                        //         fontWeight: FontWeight.w600),
                        //   ),
                        // ),
                        // if (_register_by == "email")
                        //   Padding(
                        //     padding: const EdgeInsets.only(bottom: 8.0),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.end,
                        //       children: [
                        //         Container(
                        //           height: 36,
                        //           child: TextField(
                        //             controller: _emailController,
                        //             autofocus: false,
                        //             decoration:
                        //                 InputDecorations.buildInputDecoration_1(
                        //                     hint_text: "johndoe@example.com"),
                        //           ),
                        //         ),
                        //         AddonConfig.otp_addon_installed
                        //             ? GestureDetector(
                        //                 onTap: () {
                        //                   setState(() {
                        //                     _register_by = "phone";
                        //                   });
                        //                 },
                        //                 child: Text(
                        //                   AppLocalizations.of(context)
                        //                       .registration_screen_or_register_with_phone,
                        //                   style: TextStyle(
                        //                       color: MyTheme.accent_color,
                        //                       fontStyle: FontStyle.italic,
                        //                       decoration:
                        //                           TextDecoration.underline),
                        //                 ),
                        //               )
                        //             : Container()
                        //       ],
                        //     ),
                        //   )
                        // else
                        //   Padding(
                        //     padding: const EdgeInsets.only(bottom: 8.0),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.end,
                        //       children: [
                        //         Container(
                        //           height: 36,
                        //           child: CustomInternationalPhoneNumberInput(
                        //             onInputChanged: (PhoneNumber number) {
                        //               print(number.phoneNumber);
                        //               setState(() {
                        //                 _phone = number.phoneNumber;
                        //               });
                        //             },
                        //             onInputValidated: (bool value) {
                        //               print(value);
                        //             },
                        //             selectorConfig: SelectorConfig(
                        //               selectorType:
                        //                   PhoneInputSelectorType.DIALOG,
                        //             ),
                        //             ignoreBlank: false,
                        //             autoValidateMode: AutovalidateMode.disabled,
                        //             selectorTextStyle:
                        //                 TextStyle(color: MyTheme.font_grey),
                        //             initialValue: phoneCode,
                        //             textFieldController: _phoneNumberController,
                        //             formatInput: true,
                        //             keyboardType:
                        //                 TextInputType.numberWithOptions(
                        //                     signed: true, decimal: true),
                        //             inputDecoration: InputDecorations
                        //                 .buildInputDecoration_phone(
                        //                     hint_text: "01710 333 558"),
                        //             onSaved: (PhoneNumber number) {
                        //               //print('On Saved: $number');
                        //             },
                        //           ),
                        //         ),
                        //         GestureDetector(
                        //           onTap: () {
                        //             setState(() {
                        //               _register_by = "email";
                        //             });
                        //           },
                        //           child: Text(
                        //             AppLocalizations.of(context)
                        //                 .registration_screen_or_register_with_email,
                        //             style: TextStyle(
                        //                 color: MyTheme.accent_color,
                        //                 fontStyle: FontStyle.italic,
                        //                 decoration: TextDecoration.underline),
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 4.0),
                        //   child: Text(
                        //     AppLocalizations.of(context).login_screen_password,
                        //     style: TextStyle(
                        //         color: MyTheme.accent_color,
                        //         fontWeight: FontWeight.w600),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 8.0),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.end,
                        //     children: [
                        //       Container(
                        //         height: 36,
                        //         child: TextField(
                        //           controller: _passwordController,
                        //           autofocus: false,
                        //           obscureText: true,
                        //           enableSuggestions: false,
                        //           autocorrect: false,
                        //           decoration:
                        //               InputDecorations.buildInputDecoration_1(
                        //                   hint_text: "• • • • • • • •"),
                        //         ),
                        //       ),
                        //       Text(
                        //         AppLocalizations.of(context)
                        //             .registration_screen_password_length_recommendation,
                        //         style: TextStyle(
                        //             color: MyTheme.textfield_grey,
                        //             fontStyle: FontStyle.italic),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 4.0),
                        //   child: Text(
                        //     AppLocalizations.of(context)
                        //         .registration_screen_retype_password,
                        //     style: TextStyle(
                        //         color: MyTheme.accent_color,
                        //         fontWeight: FontWeight.w600),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 8.0),
                        //   child: Container(
                        //     height: 36,
                        //     child: TextField(
                        //       controller: _passwordConfirmController,
                        //       autofocus: false,
                        //       obscureText: true,
                        //       enableSuggestions: false,
                        //       autocorrect: false,
                        //       decoration:
                        //           InputDecorations.buildInputDecoration_1(
                        //               hint_text: "• • • • • • • •"),
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 30.0),
                        //   child: Container(
                        //     height: 45,
                        //     decoration: BoxDecoration(
                        //         border: Border.all(
                        //             color: MyTheme.textfield_grey, width: 1),
                        //         borderRadius: const BorderRadius.all(
                        //             Radius.circular(12.0))),
                        //     child: FlatButton(
                        //       minWidth: MediaQuery.of(context).size.width,
                        //       //height: 50,
                        //       color: MyTheme.accent_color,
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius: const BorderRadius.all(
                        //               Radius.circular(12.0))),
                        //       child: Text(
                        //         AppLocalizations.of(context)
                        //             .registration_screen_register_sign_up,
                        //         style: TextStyle(
                        //             color: Colors.white,
                        //             fontSize: 14,
                        //             fontWeight: FontWeight.w600),
                        //       ),
                        //       onPressed: () {
                        //         onPressSignUp();
                        //       },
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 20.0),
                        //   child: Center(
                        //       child: Text(
                        //     AppLocalizations.of(context)
                        //         .registration_screen_already_have_account,
                        //     style: TextStyle(
                        //         color: MyTheme.medium_grey, fontSize: 12),
                        //   )),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 4.0),
                        //   child: Container(
                        //     height: 45,
                        //     decoration: BoxDecoration(
                        //         border: Border.all(
                        //             color: MyTheme.textfield_grey, width: 1),
                        //         borderRadius: const BorderRadius.all(
                        //             Radius.circular(12.0))),
                        //     child: FlatButton(
                        //       minWidth: MediaQuery.of(context).size.width,
                        //       //height: 50,
                        //       color: MyTheme.golden,
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius: const BorderRadius.all(
                        //               Radius.circular(12.0))),
                        //       child: Text(
                        //         AppLocalizations.of(context)
                        //             .registration_screen_log_in,
                        //         style: TextStyle(
                        //             color: Colors.white,
                        //             fontSize: 14,
                        //             fontWeight: FontWeight.w600),
                        //       ),
                        //       onPressed: () {
                        //         Navigator.push(context,
                        //             MaterialPageRoute(builder: (context) {
                        //           return Login();
                        //         }));
                        //       },
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ))
            ])));
  }
}
