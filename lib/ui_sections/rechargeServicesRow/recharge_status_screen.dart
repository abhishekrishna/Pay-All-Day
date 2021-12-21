import 'package:active_ecommerce_flutter/data_model/mobile_recharge_request_response.dart';
import 'package:active_ecommerce_flutter/data_model/recharge_status_response.dart';
import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
import 'package:active_ecommerce_flutter/repositories/recharge_status_repository.dart';
import 'package:active_ecommerce_flutter/ui_sections/sendMoneyRow/passbook.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MRechargeSucessFullScreen extends StatefulWidget {
  final String rechargeTransactionId;
  const MRechargeSucessFullScreen({Key key, this.rechargeTransactionId})
      : super(key: key);

  @override
  _MRechargeSucessFullScreenState createState() =>
      _MRechargeSucessFullScreenState();
}

class _MRechargeSucessFullScreenState extends State<MRechargeSucessFullScreen> {
  bool isLoading = false;
  bool isProcessing = true;
  RechargeRequestModel _rechargeRequestModel = RechargeRequestModel();
  RechargeStatusModel rechargeStatusData = RechargeStatusModel();

  _checkRechargeStatus() async {
    setState(() {
      isLoading = true;
    });
    var rechargeTransactionId = widget.rechargeTransactionId;
    var rechargeStatusResponse = await MobileRechargeStatusRepository()
        .checkMobileRechargeStatusRequest(rechargeTransactionId);

    setState(() {
      rechargeStatusData = rechargeStatusResponse;
      isLoading = false;
    });
    print(rechargeStatusResponse);

    print("This is status data ----------${rechargeStatusData.data}");

    if (rechargeStatusData.data.rechargeThirdPartyStatus == 1) {
      isProcessing = false;
    } else {
      isProcessing = true;
    }
  }

  @override
  void initState() {
    _checkRechargeStatus();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: SizeConfig.blockSizeVertical * 40,
                    decoration: BoxDecoration(
                        color: isProcessing
                            ? Colors.green.shade600
                            : Colors.amber.shade600),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline_rounded,
                          size: 80,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 5,
                        ),
                        Text(
                          rechargeStatusData.message ?? "",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  Text(
                    "PAYMENT SUMMARY",
                    style: TextStyle(fontSize: 16, letterSpacing: 0.5),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 50,
                    child: Divider(
                      thickness: 1.5,
                      height: 30,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 80,
                    child: Card(
                        elevation: 5,
                        child: ListTile(
                          leading: Icon(Icons.account_balance_wallet),
                          title: Text("Paid using wallet"),
                          subtitle: Text(
                            "Updated wallet balance",
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "\u{20B9} ${rechargeStatusData.data.rechargeAmount.toString()}" ??
                                    "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 1,
                              ),
                              Text(
                                "\u{20B9} - ${rechargeStatusData.data.rechargeAmount.toString()}",
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 1,
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 50,
                    child: Divider(
                      thickness: 1.5,
                      height: 30,
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 80,
                    child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  rechargeStatusData.data.rechargeNumber,
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1,
                                ),
                                Text(
                                  rechargeStatusData.data.rechargeOperatorName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.grey.shade600),
                                )
                              ],
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  rechargeStatusData
                                      .data.rechargeReferenceNumber,
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1,
                                ),
                                Text(
                                  rechargeStatusData.data.rechargeCreatedAt
                                      .toString()
                                      .replaceAll(".000Z", ""),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.grey.shade600),
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                ],
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
              onPressed: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => Passbook()))
                // _sendDataToSecondScreen(context)
                // if (_formKey.currentState.validate())
                //   {
                //     // If the form is valid, display a snackbar. In the real world,
                //     // you'd often call a server or save the information in a database.
                //     _sendDataToSecondScreen(context),
                //   }
                // else
                //   {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(content: Text('Enter Valid Number')),
                //     )
                //   }
                // validateNumber(_mobileController.text),
                // _sendDataToSecondScreen(context)
              },
              child: Text(
                "Go to Wallet".toUpperCase(),
                style: TextStyle(
                    color: Colors.white, fontSize: 18, letterSpacing: 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
