import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payallday/api/api_calls.dart';
import 'package:payallday/api/api_constants.dart';
import 'package:payallday/api/on_response_callback.dart';

class MobileRecharge extends StatefulWidget {
  const MobileRecharge({Key? key}) : super(key: key);

  @override
  State<MobileRecharge> createState() => _MobileRechargeState();
}

class _MobileRechargeState extends State<MobileRecharge>
    implements OnResponseCallback {
// Initialize Controller to auto hit api
  final TextEditingController _mobileController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _mobileController.dispose();
    super.dispose();
  }

// Listen to changes
  // @override
  // void initState() {
  //   super.initState();

  //   // Start listening to changes.
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back)),
                Image.asset(
                  "assets/logocol.png",
                  height: 30,
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Operator Details",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Jio Fi",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      if (text.isEmpty) {}
                      if (text.length == 10) {
                        _findMobileOperator();
                      }
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    cursorHeight: 20,
                    controller: _mobileController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  _findMobileOperator() {
    if (_mobileController.text.isNotEmpty) {
      var request = {};
      request["recharge_phone"] = _mobileController.text;
      request["recharge_service"] = "2";
      request["recharge_service_type_id"] = "3";
      APICall(context).doFindMobileOperator(request, this).then((value) {});
    }
  }

  @override
  void onResponseError(String message, int requestCode) {}

  @override
  void onResponseReceived(response, int requestCode) {
    if (mounted && requestCode == API.findMobileOperator) {
      // ignore: avoid_print
      print("Remove all OTHER RESPONSES$response");
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (ctx) => HomeScreen()));
    } else {
      // ignore: avoid_print

    }
  }
}
