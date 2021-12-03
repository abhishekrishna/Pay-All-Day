import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
import 'package:active_ecommerce_flutter/ui_sections/custom_widgets.dart';
import 'package:flutter/material.dart';

import '../../my_theme.dart';

class ToWallet extends StatelessWidget {
  const ToWallet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "PayAllDay Wallet",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 2,
              ),
              Text(
                "Available wallet Balance \u{20B9} 0.00",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500,
                    fontSize: 12),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 5,
              ),
              TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 5),
                    hintText: " 1000",
                    prefixText: "\u{20B9}  ",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    suffixText: "Apply Promocode",
                    suffixStyle: TextStyle(
                      color: MyTheme.accent_color,
                    )),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 5,
              ),
              Container(
                height: SizeConfig.blockSizeVertical * 7,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400, width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Automatically add balance when wallet balance is below \u{20B9} 200",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        "T&C Apply",
                        style: TextStyle(color: Colors.blue.shade400),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100, bottom: 20),
                child: Row(
                  children: [
                    Text(
                      "Money Will be added to ",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.warning),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Paytm Wallet",
                      style:
                          TextStyle(fontSize: 12, color: Colors.blue.shade400),
                    ),
                    Icon(Icons.arrow_drop_down_outlined)
                  ],
                ),
              ),
              Center(
                  child: CustomButton(null, "Add 1,000 & Set Automatic", null)),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 5,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "Use your wallet to",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ),
              Container(
                height: SizeConfig.safeBlockVertical * 28,
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.payment,
                      ),
                      title: Text("Make a Payment"),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.card_giftcard,
                      ),
                      title: Text("Send Gift Voucher"),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.send,
                      ),
                      title: Text("Send Money to Bank"),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: Text(
                  "Manage your Wallet",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ),
              Container(
                height: SizeConfig.safeBlockVertical * 28,
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.add,
                      ),
                      title: Text("Automatic Add Money"),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.card_giftcard,
                      ),
                      title: Text("Nearby Cash Deposit Points"),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.send,
                      ),
                      title: Text("Set Payment Reminder"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
