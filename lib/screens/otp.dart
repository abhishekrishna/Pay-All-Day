// import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/ui_sections/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:active_ecommerce_flutter/custom/input_decorations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:active_ecommerce_flutter/screens/login.dart';
import 'package:active_ecommerce_flutter/repositories/auth_repository.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:toast/toast.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Otp extends StatefulWidget {
  Otp(this.verify_by, this.phone);
  final String verify_by;
  final String phone;

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  //controllers
  TextEditingController _verificationCodeController = TextEditingController();

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

  onTapResend() async {
    var resendCodeResponse = await AuthRepository()
        .getResendCodeResponse(widget.phone, widget.verify_by);

    if (resendCodeResponse.result == false) {
      ToastComponent.showDialog(resendCodeResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    } else {
      ToastComponent.showDialog(resendCodeResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    }
  }

  onPressConfirm() async {
    var code = _verificationCodeController.text.toString();

    if (code == "") {
      ToastComponent.showDialog(
          AppLocalizations.of(context).otp_screen_verification_code_warning,
          context,
          gravity: Toast.CENTER,
          duration: Toast.LENGTH_LONG);
      return;
    }

    var confirmCodeResponse =
        await AuthRepository().getConfirmCodeResponse(widget.phone, code);

    if (confirmCodeResponse.result == false) {
      ToastComponent.showDialog(confirmCodeResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    } else {
      ToastComponent.showDialog(confirmCodeResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return Login();
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String _verify_by = widget.verify_by; //phone or email
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Container(
            //   width: _screen_width * (3 / 4),
            //   child: Image.asset(
            //       "assets/splash_login_registration_background_image.png"),
            // ),
            Container(
              width: double.infinity,
              child: SingleChildScrollView(
                  child:
                      Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                    SizedBox(
                      height: _screen_height * 0.1,
                    ),
                    Center(
                        child: Image.asset(
                      "assets/verifyotp.png",
                      scale: 0.9,
                    )),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Verification",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Enter OTP Code sent to your number \n  ",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                        child: Container(
                      height: _screen_height * 0.5,
                      decoration: const BoxDecoration(color: Colors.white10),
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            PinCodeTextField(
                              enablePinAutofill: true,
                              length: 4,
                              obscureText: false,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                activeColor: Colors.white,
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 50,
                                fieldWidth: 60,
                                activeFillColor: Colors.white,
                              ),
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              controller: _verificationCodeController,
                              onCompleted: (v) {
                                // ignore: avoid_print
                                print("Completed");
                              },
                              onChanged: (value) {
                                // ignore: avoid_print
                                print(value);
                                // setState(() {
                                //   currentText = value;
                                // });
                              },
                              beforeTextPaste: (text) {
                                // ignore: avoid_print
                                print("Allowing to paste $text");
                                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                return true;
                              },
                              appContext: context,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomButton(Icons.app_registration, "verify otp",
                                onPressConfirm),
                            CustomButton(Icons.sms, "resend otp", onTapResend),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 100),
                            //   child: InkWell(
                            //     onTap: () {
                            //       onTapResend();
                            //     },
                            //     child: Text(
                            //         AppLocalizations.of(context)
                            //             .otp_screen_resend_code,
                            //         textAlign: TextAlign.center,
                            //         style: TextStyle(
                            //             color: MyTheme.accent_color,
                            //             decoration: TextDecoration.underline,
                            //             fontSize: 13)),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ))
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
