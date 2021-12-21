import 'package:active_ecommerce_flutter/data_model/operator_data_response.dart';
import 'package:active_ecommerce_flutter/data_model/operator_plans_response.dart';
import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/providers/apiv3/api_constants.dart';
import 'package:active_ecommerce_flutter/repositories/operator_plans_repository.dart';
import 'package:active_ecommerce_flutter/repositories/operator_repository.dart';
import 'package:active_ecommerce_flutter/ui_sections/rechargeServicesRow/select_operator.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mobile_recharge_checkout.dart';
// import 'recharge_plan.dart';

class MobileRechargeAmount extends StatefulWidget {
  final String operatorId;
  final String text;
  final String operatorIcon;

  // final String operatorName;
  // final String rechargeAmount;

  const MobileRechargeAmount({
    Key key,
    // this.keys,
    this.operatorId,
    this.text,
    this.operatorIcon,
    // this.operatorName,
  }) : super(key: key);

  @override
  _MobileRechargeAmountState createState() => _MobileRechargeAmountState();
}

class _MobileRechargeAmountState extends State<MobileRechargeAmount> {
  final TextEditingController _amountController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  // final String _height = "10";
  PlansData planData = PlansData();
  // List operatorData = [];
  bool isLoading = false;
  String planAmount;
  // String operatorIcon;

  @override
  void initState() {
    _findMobilePlans();
    // _findMobileOperator();
    super.initState();
    print(isLoading);
  }

  // _showPlansBottomSheetList() {
  //   showModalBottomSheet(
  //       isScrollControlled: true,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //       context: context,
  //       builder: (builder) {
  //         return
  //       });
  //// }

  FindMobileOperator operatorData = FindMobileOperator();

  _findMobileOperator() async {
    isLoading = true;

    var phoneNumber = widget.text;
    var rechargeService = "2";
    var rechargeServiceType = "3";
    var operatorResponse = await OperatorRepository().getOpeartorDataResponse(
        phoneNumber, rechargeService, rechargeServiceType);
    setState(() {
      operatorData = operatorResponse;
      var operatorName = operatorData.operatorMatchedData.operatorName;
      print(operatorData.toString());
      isLoading = false;
    });
  }

  _findMobilePlans() async {
    isLoading = true;

    var phoneNumber = widget.text.toString();
    var rechargeService = "1234";
    var rechargeOperatorCode = "JIO";
    var rechargeOperatorCircle = "23";
    var plansResponse = await OperatorPlansRepository()
        .getOperatorPlansResponse(phoneNumber, rechargeService,
            rechargeOperatorCode, rechargeOperatorCircle);

    setState(() {
      planData = plansResponse;
      isLoading = false;
      // isLoading = false;
      // print("this is my planlist {$planData[0].rechargeTalktime}".toString());
    });

    // print("This is planData${plansResponse.data[0].operatorId.toString()}");

    // if (
    //     // operatorResponse.data[0].operatorIsMatched == true &&
    //     plansResponse.data[1].operatorIsMatched == false) {
    //   ToastComponent.showDialog(
    //       plansResponse.data[0].operatorIsMatched.toString(), context,
    //       gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
    // } else {
    //   ToastComponent.showDialog(
    //       operatorResponse.data[0].operatorIsMatched.toString(), context,
    //       gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) {
    //     return Home();
    //   }),
    // );
    _findMobileOperator();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return SafeArea(
      child: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircularProgressIndicator(),
                  Text(
                    "Loading Updated Plan List",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )
                ],
              ),
            )
          : Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[
                        Color(0xFF0288D1),
                        Color(0xFF0D47A1)
                      ])),
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
              body: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.text ?? "",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: MyTheme.black_color,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 1,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${operatorData.operatorMatchedData.operatorName}," ??
                                      "",
                                  style: TextStyle(
                                      color: MyTheme.black_color,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeVertical * 1,
                                ),
                                Text(
                                  operatorData.operatorMatchedData
                                          .operatorCircleName ??
                                      "",
                                  style: TextStyle(
                                      color: MyTheme.black_color,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 3,
                            ),
                            InkWell(
                              onTap: () {
                                // print('API.IMAGE_URL + ${operatorData.operatorIcon}');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => SelectMOperator()));
                              },
                              child: Text("Change Operator",
                                  style: TextStyle(color: Colors.blue)),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 50,
                          child: Image.network(
                            '${API.IMAGE_URL + widget.operatorIcon ?? ""}',
                            height: 40,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () {
                          // Navigator.pop(context);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (ctx) => RechargePlans(
                          //             widget.text,
                          //             operatorData.operatorMatchedData.operatorIcon
                          //                 .toString(),
                          //             widget.operatorName)));
                        },
                        child: Text(
                          "Browse Plans",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "   \u{20B9}   ",
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Tap on Amount Box to select plan",
                          style: TextStyle(
                              color: Colors.grey, fontStyle: FontStyle.italic)),
                    ),
                    Container(
                      height: SizeConfig.safeBlockVertical * 40,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: planData.data.length,
                            itemBuilder: (context, index) {
                              // final List<PlansData> rechargeAmount =
                              //     List.generate(
                              //         planData.data.length,
                              //         (index) => PlansData(
                              //               {
                              //                 planData.data[index]
                              //                     .rechargeAmount
                              //               },
                              //             ));
                              return Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ExpansionTileCard(
                                    initiallyExpanded: true,
                                    initialElevation: 5,
                                    elevation: 5,
                                    // key: cardA6
                                    leading: SizedBox(
                                      width: 50,
                                      child: Text(
                                        "Validity: \n${planData.data[index].rechargeValidity.toString()}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    title: Text(
                                      planData.data[index].rechargeShortDesc
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(planData
                                        .data[index].rechargeTalktime
                                        .toString()),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              _amountController.text = planData
                                                  .data[index].rechargeAmount;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      5.0) //         <--- border radius here
                                                  ),
                                              border: Border.all(
                                                color: MyTheme.accent_color,
                                              ),
                                            ),
                                            height: 25,
                                            width: 50,
                                            child: Center(
                                              child: Text(
                                                  "Rs. ${planData.data[index].rechargeAmount.toString()}"),
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                    children: <Widget>[
                                      Divider(
                                        thickness: 1.0,
                                        height: 1.0,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                            vertical: 8.0,
                                          ),
                                          child: Text(
                                            "Plan Description : ${planData.data[index].rechargeLongDesc.toString()}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .copyWith(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      // ButtonBar(
                                      //   alignment: MainAxisAlignment.spaceAround,
                                      //   buttonHeight: 52.0,
                                      //   buttonMinWidth: 90.0,
                                      //   children: <Widget>[
                                      //     TextButton(
                                      //       style: flatButtonStyle,
                                      //       onPressed: () {
                                      //         cardB.currentState?.expand();
                                      //       },
                                      //       child: Column(
                                      //         children: <Widget>[
                                      //           Icon(Icons.arrow_downward),
                                      //           Padding(
                                      //             padding: const EdgeInsets.symmetric(
                                      //                 vertical: 2.0),
                                      //           ),
                                      //           Text('Open'),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //     TextButton(
                                      //       style: flatButtonStyle,
                                      //       onPressed: () {
                                      //         cardB.currentState?.collapse();
                                      //       },
                                      //       child: Column(
                                      //         children: <Widget>[
                                      //           Icon(Icons.arrow_upward),
                                      //           Padding(
                                      //             padding: const EdgeInsets.symmetric(
                                      //                 vertical: 2.0),
                                      //           ),
                                      //           Text('Close'),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //     TextButton(
                                      //       style: flatButtonStyle,
                                      //       onPressed: () {
                                      //         cardB.currentState?.toggleExpansion();
                                      //       },
                                      //       child: Column(
                                      //         children: <Widget>[
                                      //           Icon(Icons.swap_vert),
                                      //           Padding(
                                      //             padding: const EdgeInsets.symmetric(
                                      //                 vertical: 2.0),
                                      //           ),
                                      //           Text('Toggle'),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                              );

                              //  ListTile(
                              //   title: Text(planData[index].id.toString()),
                              // );
                            },
                          )),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                child: Container(
                  height: SizeConfig.safeBlockVertical * 8,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[Color(0xFF0288D1), Color(0xFF0D47A1)]),
                  ),
                  child: MaterialButton(
                    onPressed: () => {moveAmt(context)},
                    child: Text(
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  moveAmt(context) {
    String _amountData = _amountController.text;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => MobileRCheckout(
                operatorId: widget.operatorId,
                operatorName: operatorData.operatorMatchedData.operatorName,
                operatorIcon: widget.operatorIcon,
                amountData: _amountData,
                mobileNumber: widget.text)));
  }
}
