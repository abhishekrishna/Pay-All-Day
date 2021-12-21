import 'package:active_ecommerce_flutter/data_model/mobile_recharge_request_response.dart';
import 'package:active_ecommerce_flutter/data_model/wallet_response.dart';
import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/repositories/mobile_recharge_request_repository.dart';
import 'package:active_ecommerce_flutter/repositories/wallet_repository.dart';
import 'package:active_ecommerce_flutter/ui_sections/custom_widgets.dart';
import 'package:active_ecommerce_flutter/ui_sections/rechargeServicesRow/recharge_status_screen.dart';
import 'package:active_ecommerce_flutter/ui_sections/sendMoneyRow/recharge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum Paymentoptions { RechargeWallet, PayalldayBank, Bank }

class CheckoutScreen extends StatefulWidget {
  final String operatorId;
  final int checkOutAmt;
  final String mobileNum;
  const CheckoutScreen(
      {Key key, this.checkOutAmt, this.mobileNum, this.operatorId})
      : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Paymentoptions _paymentoptions = Paymentoptions.RechargeWallet;
  bool isChecked = false;
  bool canUseWallet = false;
  RechargeRequestModel rechargeResponse = RechargeRequestModel();
  WalletReponse walletData = WalletReponse();
  // TransactionResponse transactionData = TransactionResponse();
  bool isLoading = true;

  fetchBalanceDetails() async {
    var balanceDetailsResponse = await WalletRepository().getBalance();

    setState(() {
      walletData = balanceDetailsResponse;
      isLoading = false;

      print("This is wallet data --> ${walletData.mainWalletBalance}");
    });
    checkWallet();
    print(walletData.rechargeWalletBalance);
  }

  //Initiate Recharge Request with Amount
  _mobileRechargeRequest() async {
    var checkOutAmtasString = widget.checkOutAmt.toString();
    print(checkOutAmtasString);
    var rechargeNumber = widget.mobileNum.toString();
    var rechargePlanId = "1";
    var rechargePlanAmount = checkOutAmtasString;
    var rechargeOperatorId = "2";
    var rechargePaymentMode = "";
    var rechargeRequestResponse = await MobileRechargeRequestRepository()
        .chargeMobileRechargeRequest(rechargeNumber, rechargePlanId,
            rechargePlanAmount, rechargeOperatorId, rechargePaymentMode);

    isLoading = true;
    setState(() {
      rechargeResponse = rechargeRequestResponse;
      print(rechargeResponse.data);
      isLoading = false;
    });

    if (rechargeResponse.result == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MRechargeSucessFullScreen(
                    rechargeTransactionId:
                        rechargeResponse.data.rechargeOrderId,
                  )));
    }
  }

  checkWallet() {
    double rechargeBalAsInt = double.parse(walletData.mainWalletBalance);
    if (rechargeBalAsInt < widget.checkOutAmt)
      canUseWallet = false;
    else {
      canUseWallet = true;
    }
    print("This is walletUse value --> $canUseWallet");
  }

  @override
  void initState() {
    fetchBalanceDetails();
    // setState(() {
    print("This is walletUse value --> $canUseWallet");
    // });
    // checkWallet();
    // TODO: implement initState
    super.initState();
  }

  _processRechargeRequest() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            _mobileRechargeRequest();
            return Container(
              height: SizeConfig.blockSizeVertical * 20,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Processing Recharge Request",
                      style: TextStyle(fontSize: 20),
                    ),
                    CircularProgressIndicator()
                  ],
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Image.asset(
            "assets/logocol.png",
            width: 50,
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select an Option to Pay ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          "\u{20B9} ${widget.checkOutAmt}.00" ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 10,
                    ),
                    Container(
                      height: SizeConfig.blockSizeVertical * 30,
                      child: ListView(
                        children: [
                          Card(
                            child: ExpansionTile(
                              initiallyExpanded: true,
                              children: [
                                canUseWallet
                                    ? Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          "Pay With Wallet Balance : ${walletData.mainWalletBalance}" ??
                                              "",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          "Insufficient Wallet Balance : \u{20B9} ${walletData.mainWalletBalance}" ??
                                              "",
                                          style: TextStyle(
                                              letterSpacing: 1,
                                              color: Colors.amber.shade700,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                              ],
                              leading: Radio(
                                groupValue: _paymentoptions,
                                value: Paymentoptions.RechargeWallet,
                                onChanged: (value) {
                                  setState(() {
                                    _paymentoptions = value;
                                  });
                                },
                              ),
                              title: Text(
                                "RECHARGE WALLET",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                Icons.payment,
                                color: MyTheme.accent_color,
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                                leading: Radio(
                                  groupValue: _paymentoptions,
                                  value: Paymentoptions.PayalldayBank,
                                  onChanged: (value) {
                                    setState(() {
                                      _paymentoptions = value;
                                    });
                                  },
                                ),
                                title: Text(
                                  "PAYALLDAY BANK",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Image.asset(
                                  "assets/logocol.png",
                                  height: 30,
                                )),
                          ),
                          // Card(
                          //   child: ListTile(
                          //       leading: Radio(
                          //         groupValue: _paymentoptions,
                          //         value: Paymentoptions.Bank,
                          //         onChanged: (value) {
                          //           setState(() {
                          //             _paymentoptions = value;
                          //           });
                          //         },
                          //       ),
                          //       title: Text(
                          //         "BANDHAN BANK",
                          //         style: TextStyle(
                          //             fontSize: 14,
                          //             fontWeight: FontWeight.bold),
                          //       ),
                          //       trailing: Icon(
                          //         Icons.card_membership,
                          //         color: MyTheme.accent_color,
                          //       )),
                          // )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 10,
                    ),
                    canUseWallet
                        ? CustomButton(
                            Icons.payment, "proceed to pay", sendToSucessScreen)
                        : DisabledButton(
                            Icons.dangerous, "Add Balance", addMoneyToast)
                    // ElevatedButton(
                    //     child: Padding(
                    //       padding: const EdgeInsets.fromLTRB(60, 15, 50, 15),
                    //       child: Row(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           canUseWallet
                    //               ? Text("proceed to pay".toUpperCase(),
                    //                   style: canUseWallet
                    //                       ? TextStyle(
                    //                           fontSize: 14,
                    //                           color: Colors.white,
                    //                         )
                    //                       : TextStyle(
                    //                           fontSize: 14,
                    //                           color: Colors.black,
                    //                         ))
                    //               : Text("Please Add Balance".toUpperCase(),
                    //                   style: canUseWallet
                    //                       ? TextStyle(
                    //                           fontSize: 14,
                    //                           color: Colors.black,
                    //                         )
                    //                       : TextStyle(
                    //                           fontSize: 14,
                    //                           color: Colors.white,
                    //                         )),
                    //           SizedBox(
                    //             width: SizeConfig.blockSizeHorizontal * 0.9,
                    //           ),
                    //           Icon(
                    //             Icons.payment,
                    //             color:
                    //                 canUseWallet ? Colors.black : Colors.white,
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //     style: ElevatedButton.styleFrom(
                    //         onSurface: Colors.grey.shade400,
                    //         primary: Colors.indigo.shade900,
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(30),
                    //             side: const BorderSide(color: Colors.indigo))),
                    //     onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (ctx) =>
                    //                   MRechargeSucessFullScreen()));
                    //     })
                    // canUseWallet ? _mobileRechargeRequest : null)
                    // StateButton(Icons.payments, "Proceed to PAY",
                    //     canUseWallet ? _mobileRechargeRequest : null)
                  ],
                ),
              ),
      ),
    );
  }

  void addMoneyToast() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Please Add Funds"),
    ));
  }

  void sendToSucessScreen() {
    _processRechargeRequest();
    //   _mobileRechargeRequest();
    //   setState(() {
    //     isLoading = true;
    //     var sendTranactionId = rechargeResponse.data.rechargeOrderId;
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (ctx) => MRechargeSucessFullScreen(
    //                   rechargeTransactionId: sendTranactionId,
    //                 )));
    //     isLoading = false;
    //   });
  }
}
