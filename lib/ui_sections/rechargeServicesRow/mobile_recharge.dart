// import 'package:active_ecommerce_flutter/providers/apiv3/on_response_callback.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/repositories/operator_repository.dart';
import 'package:flutter/gestures.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

class MobileRecharge extends StatefulWidget {
  const MobileRecharge({Key key}) : super(key: key);

  @override
  State<MobileRecharge> createState() => _MobileRechargeState();
}

class _MobileRechargeState extends State<MobileRecharge> {
// enum types for recharge
  MobileRechargeType _changeType = MobileRechargeType.Prepaid;
  PhoneContact _phoneContact;
  EmailContact _emailContact;
  String _contact;
  Image _contactPhoto;
  bool kIsWeb = false;
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

  _showPlansBottomSheetList() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (builder) {
          return new Container(
              // height: SizeConfig.safeBlockVertical * 200,
              child: Column(
            children: [
              Container(
                height: SizeConfig.safeBlockVertical * 50,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      Card(
                        child: ListTile(
                          leading: Text('Val : \n10 Days'),
                          title: Text("Plan Short Details"),
                          subtitle: Text('Plan Long Details : .'),
                          trailing: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(
                                      5.0) //         <--- border radius here
                                  ),
                              border: Border.all(
                                color: MyTheme.accent_color,
                              ),
                            ),
                            height: 25,
                            width: 40,
                            child: Center(
                              child: Text("Rs. 34"),
                            ),
                          ),
                          isThreeLine: true,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Card(
                        child: ListTile(
                          leading: FlutterLogo(size: 72.0),
                          title: Text('Three-line ListTile'),
                          subtitle: Text(
                              'A sufficiently long subtitle warrants three lines.'),
                          trailing: Icon(Icons.more_vert),
                          isThreeLine: true,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Card(
                        child: ListTile(
                          leading: FlutterLogo(size: 72.0),
                          title: Text('Three-line ListTile'),
                          subtitle: Text(
                              'A sufficiently long subtitle warrants three lines.'),
                          trailing: Icon(Icons.more_vert),
                          isThreeLine: true,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ));
        });
  }

  _findMobileOperator() async {
    var phoneNumber = _mobileController.text.toString();
    var rechargeService = "2";
    var rechargeServiceType = "3";
    var operatorResponse = await OperatorRepository().getOpeartorDataResponse(
        phoneNumber, rechargeService, rechargeServiceType);

    if (
        // operatorResponse.data[0].operatorIsMatched == true &&
        operatorResponse.data[1].operatorIsMatched == false) {
      ToastComponent.showDialog(
          operatorResponse.data[0].operatorIsMatched.toString(), context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
    } else {
      ToastComponent.showDialog(
          operatorResponse.data[0].operatorIsMatched.toString(), context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) {
      //     return Home();
      //   }),
      // );
      _showPlansBottomSheetList();
    }
  }

  _findMobilePlans() {
    var phoneNumber = _mobileController.text.toString();
    var rechargeService = "2";
    var rechargeOperatorCode = "VF";
    var rechargeOperatorCircle = "19";
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
                      // const Text(
                      //   "Operator Details",
                      //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // const Text(
                      //   "Jio Fi",
                      //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                      // ),
                      // const SizedBox(
                      //   height: 30,
                      // ),
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

  Widget _buildError(BuildContext context) {
    return RichText(
      text: TextSpan(
          text:
              'Your browser does not support contact pickers for more information see: ',
          children: [
            TextSpan(
                text: 'https://web.dev/contact-picker/',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                // ..onTap = () => launch('https://web.dev/contact-picker/')
                ),
            TextSpan(text: ' and '),
            TextSpan(
                text:
                    'https://developer.mozilla.org/en-US/docs/Web/API/Contact_Picker_API#Browser_compatibility/',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                // ..onTap = () => launch(
                // 'https://developer.mozilla.org/en-US/docs/Web/API/Contact_Picker_API#Browser_compatibility'))
                )
          ]),
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
    return <Widget>[
      if (_emailContact != null)
        Column(
          children: <Widget>[
            const Text("Email contact:"),
            Text("Name: ${_emailContact.fullName}"),
            Text(
                "Email: ${_emailContact.email.email} (${_emailContact.email.label})")
          ],
        ),
      if (_phoneContact != null)
        Column(
          children: <Widget>[
            const Text("Phone contact:"),
            Text("Name: ${_phoneContact.fullName}"),
            Text(
                "Phone: ${_phoneContact.phoneNumber.number} (${_phoneContact.phoneNumber.label})")
          ],
        ),
      if (_contactPhoto != null) _contactPhoto,
      if (_contact != null) Text(_contact),
      ElevatedButton(
        child: const Text("pick phone contact"),
        onPressed: () async {
          final PhoneContact contact =
              await FlutterContactPicker.pickPhoneContact();
          print(contact);
          setState(() {
            _phoneContact = contact;
          });
        },
      ),
      ElevatedButton(
        child: const Text("pick email contact"),
        onPressed: () async {
          final EmailContact contact =
              await FlutterContactPicker.pickEmailContact();
          print(contact);
          setState(() {
            _emailContact = contact;
          });
        },
      ),
      ElevatedButton(child: const Text("pick full contact"), onPressed: () {}),
      ElevatedButton(
        child: const Text('Check permission'),
        onPressed: () async {
          final granted = await FlutterContactPicker.hasPermission();
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                  title: const Text('Granted: '), content: Text('$granted')));
        },
      ),
      ElevatedButton(
        child: const Text('Request permission'),
        onPressed: () async {
          final granted = await FlutterContactPicker.requestPermission();
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                  title: const Text('Granted: '), content: Text('$granted')));
        },
      ),
    ];
  }
}

enum MobileRechargeType { Prepaid, Postpaid }
