import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/providers/apiv3/api_constants.dart';
import 'package:active_ecommerce_flutter/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MobileRCheckout extends StatefulWidget {
  final String operatorId;
  final String amountData;
  final operatorName;
  final String operatorIcon;
  final mobileNumber;
  const MobileRCheckout(
      {Key key,
      this.operatorIcon,
      this.operatorName,
      this.amountData,
      this.mobileNumber,
      this.operatorId
      //  this.operatorIcon
      })
      : super(key: key);

  @override
  _MobileRCheckoutState createState() => _MobileRCheckoutState();
}

class _MobileRCheckoutState extends State<MobileRCheckout> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 20,
                    ),
                  ),
                  Image.asset(
                    "assets/logocol.png",
                    height: 30,
                  )
                ],
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 10,
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              "Operator Details",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                            ),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Image.network(
                                '${API.IMAGE_URL + widget.operatorIcon}' ?? "",
                                height: 50,
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        widget.operatorName ?? "",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 3,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Biller Name",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 1,
                          ),
                          Text(
                            widget.operatorName ?? "",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 1,
                          ),
                          Text(
                            "Operator Number",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                      Text(
                        widget.mobileNumber ?? "",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 10,
              ),
              Container(
                width: SizeConfig.safeBlockVertical * 50,
                height: SizeConfig.safeBlockVertical * 8,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Transaction Amount ",
                        style: TextStyle(
                            color: MyTheme.black_color,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        "\u{20B9} ${widget.amountData}",
                        style: TextStyle(
                            color: MyTheme.black_color,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 5,
          onPressed: () {
            // _mobileRechargeRequest();
            String checkOutAmt = widget.amountData;
            int checkOutAmtAsInt = int.parse(checkOutAmt);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => CheckoutScreen(
                          // planId: widget.planId,
                          checkOutAmt: checkOutAmtAsInt,
                          mobileNum: widget.mobileNumber,
                        )));
          },
          child: Text("Pay"),
        ),
      ),
    );
  }
}
