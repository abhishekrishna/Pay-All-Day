// import 'package:active_ecommerce_flutter/providers/apiv3/on_response_callback.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/repositories/operator_repository.dart';
import 'package:active_ecommerce_flutter/ui_sections/rechargeServicesRow/select_operator.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

enum MobileRechargeType { Prepaid, Postpaid }

class MobileRecharge extends StatefulWidget {
  const MobileRecharge({Key key}) : super(key: key);

  @override
  State<MobileRecharge> createState() => _MobileRechargeState();
}

class _MobileRechargeState extends State<MobileRecharge> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();

// enum types for recharge
  MobileRechargeType _changeType = MobileRechargeType.Prepaid;
  PhoneContact _phoneContact;
  EmailContact _emailContact;
  String _contact;
  Image _contactPhoto;
  bool kIsWeb = false;

  List planData = [];
  List operatorData = [];
// Initialize Controller to auto hit api
  final TextEditingController _mobileController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _mobileController.dispose();
    super.dispose();
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  );

  _moveToPlansScreen() {}

  _moveToOperatorSelection() {
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => SelectMOperator()));
  }

  _findMobileOperator() async {
    var phoneNumber = _mobileController.text.toString();
    var rechargeService = "2";
    var rechargeServiceType = "3";
    var operatorResponse = await OperatorRepository().getOpeartorDataResponse(
        phoneNumber, rechargeService, rechargeServiceType);
    setState(() {
      operatorData = operatorResponse.data;
      // print(operatorData[0].operatorName.toString());
    });

    if (operatorResponse.operatorIsMatched == true) {
      _moveToOperatorSelection();
      // ToastComponent.showDialog(
      //     operatorResponse.data[0].operatorIsMatched.toString(), context,
      //     gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
    } else {
      // ToastComponent.showDialog(
      //     operatorResponse.data[1].operatorIsMatched.toString(), context,
      //     gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (ctx) => SelectMOperator()));

    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Color(0xFF0288D1), Color(0xFF0D47A1)])),
          child: Row(
            children: [
              SizedBox(
                width: mediaQuery.width * 0.02,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: mediaQuery.width * 0.25,
              ),
              Center(
                  child: Text(
                "Mobile Recharge",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 1.5),
              )),
            ],
          ),
          // automaticallyImplyLeading: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Radio(
                  value: MobileRechargeType.Prepaid,
                  groupValue: _changeType,
                  onChanged: (MobileRechargeType value) {
                    setState(() {
                      _changeType = value;
                    });
                  },
                ),
                Text("Prepaid"),
                SizedBox(
                  width: mediaQuery.width * 0.10,
                ),
                Radio(
                  value: MobileRechargeType.Postpaid,
                  groupValue: _changeType,
                  onChanged: (MobileRechargeType value) {
                    setState(() {
                      _changeType = value;
                    });
                  },
                ),
                Text("Postpaid")
              ],
            ),
            SizedBox(height: mediaQuery.height * 0.02),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        onChanged: (text) {
                          if (text.isEmpty) {
                            Toast.show("Enter Valid Number", context);
                          }
                          if (text.length == 10) {
                            _findMobileOperator();
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        cursorHeight: 20,
                        controller: _mobileController,
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                                onTap: () async {
                                  final FullContact contact =
                                      (await FlutterContactPicker
                                          .pickFullContact());
                                  setState(() {
                                    _contact = contact.toString();
                                    _contactPhoto = contact.photo?.asWidget();
                                  });
                                },
                                child: Icon(
                                  Icons.contact_phone,
                                  color: MyTheme.soft_accent_color,
                                )),
                            hintText: 'Enter Mobile Number',
                            hintStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                      ),
                      SizedBox(height: mediaQuery.height * 0.04),
                      Text(
                        "Recent Payments",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: mediaQuery.height * 0.04),
                      Container(
                        height: mediaQuery.height * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(
                            children: [
                              ListTile(
                                leading: CircleAvatar(),
                                title: Text("Jhon Doe"),
                              ),
                              ListTile(
                                leading: CircleAvatar(),
                                title: Text("Robert Doe"),
                              ),
                              ListTile(
                                leading: CircleAvatar(),
                                title: Text("Other"),
                              )
                            ],
                          ),
                        ),
                      ),
                    ])),
          ]),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Color(0xFF0288D1), Color(0xFF0D47A1)]),
          ),
          child: MaterialButton(
            onPressed: () => {},
            child: Text(
              "Continue",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    ));
  }
}
