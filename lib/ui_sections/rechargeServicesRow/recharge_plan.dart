// import 'package:active_ecommerce_flutter/data_model/operator_data_response.dart';
// import 'package:active_ecommerce_flutter/data_model/operator_plans_response.dart';
// import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
// import 'package:active_ecommerce_flutter/providers/apiv3/api_constants.dart';
// import 'package:active_ecommerce_flutter/repositories/operator_plans_repository.dart';
// import 'package:active_ecommerce_flutter/repositories/operator_repository.dart';
// import 'package:expansion_tile_card/expansion_tile_card.dart';
// import 'package:flutter/material.dart';

// import '../../my_theme.dart';
// import 'mobile_recharge_amount.dart';

// class RechargePlans extends StatefulWidget {
//   final String mobileNumber;
//   final String operatorIcon;
//   final String operatorName;
//   RechargePlans(this.mobileNumber, this.operatorName, this.operatorIcon);

//   @override
//   _RechargePlansState createState() => _RechargePlansState();
// }

// class _RechargePlansState extends State<RechargePlans> {
//   PlansData planData = PlansData();
//   // List operatorData = [];
//   bool isLoading = true;
//   String planAmount;

//   @override
//   void initState() {
//     _findMobilePlans();
//     _findMobileOperator();
//     super.initState();
//   }

//   // _showPlansBottomSheetList() {
//   //   showModalBottomSheet(
//   //       isScrollControlled: true,
//   //       shape: RoundedRectangleBorder(
//   //         borderRadius: BorderRadius.circular(10.0),
//   //       ),
//   //       context: context,
//   //       builder: (builder) {
//   //         return
//   //       });
//   // }
//   FindMobileOperator operatorData = FindMobileOperator();
//   _findMobileOperator() async {
//     var phoneNumber = widget.mobileNumber;
//     var rechargeService = "2";
//     var rechargeServiceType = "3";
//     var operatorResponse = await OperatorRepository().getOpeartorDataResponse(
//         phoneNumber, rechargeService, rechargeServiceType);
//     setState(() {
//       operatorData = operatorResponse;
//       print(operatorData.toString());
//     });

//     if (operatorData.operatorIsMatched == true) {
//       // _moveToPlansScreen();
//       // ToastComponent.showDialog(
//       //     operatorResponse.data[0].operatorIsMatched.toString(), context,
//       //     gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
//     } else if (operatorData.operatorIsMatched == false) {
//       // _moveToOperatorSelection();
//       // ToastComponent.showDialog(
//       //     operatorResponse.data[1].operatorIsMatched.toString(), context,
//       //     gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
//       // Navigator.push(
//       //     context, MaterialPageRoute(builder: (ctx) => MobileRechargeAmount()));
//     }
//   }

//   _findMobilePlans() async {
//     var phoneNumber = widget.mobileNumber.toString();
//     var rechargeService = "1234";
//     var rechargeOperatorCode = "JIO";
//     var rechargeOperatorCircle = "23";
//     var plansResponse = await OperatorPlansRepository()
//         .getOperatorPlansResponse(phoneNumber, rechargeService,
//             rechargeOperatorCode, rechargeOperatorCircle);
//     setState(() {
//       isLoading = true;
//       planData = plansResponse;
//       isLoading = false;
//       // print("this is my planlist {$planData[0].rechargeTalktime}".toString());
//     });
//     // print("This is planData${plansResponse.data[0].operatorId.toString()}");

//     // if (
//     //     // operatorResponse.data[0].operatorIsMatched == true &&
//     //     plansResponse.data[1].operatorIsMatched == false) {
//     //   ToastComponent.showDialog(
//     //       plansResponse.data[0].operatorIsMatched.toString(), context,
//     //       gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
//     // } else {
//     //   ToastComponent.showDialog(
//     //       operatorResponse.data[0].operatorIsMatched.toString(), context,
//     //       gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
//     // Navigator.push(
//     //   context,
//     //   MaterialPageRoute(builder: (context) {
//     //     return Home();
//     //   }),
//     // );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? Center(
//             child: CircularProgressIndicator(),
//           )
//         : Scaffold(
//             appBar: AppBar(
//               elevation: 3,
//               backgroundColor: Colors.white,
//               foregroundColor: Colors.black,
//               title: Text(
//                 operatorData.operatorMatchedData.operatorName ??
//                     "Operator Not Matched",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     width: SizeConfig.safeBlockHorizontal * 5,
//                     child: Image.network(
//                       '${API.IMAGE_URL + operatorData.operatorMatchedData.operatorIcon.toString()}' ??
//                           "",
//                       height: 20,
//                       width: 25,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             body: SafeArea(
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: SizeConfig.blockSizeVertical * 200,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(
//                             height: SizeConfig.safeBlockVertical * 150,
//                             child: Padding(
//                               padding: const EdgeInsets.only(top: 10),
//                               child: isLoading
//                                   ? Center(
//                                       child: CircularProgressIndicator(),
//                                     )
//                                   : ListView.builder(
//                                       itemCount: planData.data.length,
//                                       itemBuilder: (context, index) {
//                                         // final List<PlansData> rechargeAmount =
//                                         //     List.generate(
//                                         //         planData.data.length,
//                                         //         (index) => PlansData(
//                                         //               {
//                                         //                 planData.data[index]
//                                         //                     .rechargeAmount
//                                         //               },
//                                         //             ));
//                                         return Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: ExpansionTileCard(
//                                             initialElevation: 5,
//                                             elevation: 5,
//                                             // key: cardA6
//                                             leading: SizedBox(
//                                               width: 50,
//                                               child: Text(
//                                                 "Validity: \n${planData.data[index].rechargeValidity.toString()}",
//                                                 style: TextStyle(
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                             ),
//                                             title: Text(
//                                               planData
//                                                   .data[index].rechargeShortDesc
//                                                   .toString(),
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                             subtitle: Text(planData
//                                                 .data[index].rechargeTalktime
//                                                 .toString()),
//                                             trailing: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceAround,
//                                               children: [
//                                                 InkWell(
//                                                   onTap: () {
//                                                     setState(() {
//                                                       String planAmount =
//                                                           planData.data[index]
//                                                               .rechargeAmount
//                                                               .toString();

//                                                       Navigator.push(
//                                                           context,
//                                                           MaterialPageRoute(
//                                                               builder: (ctx) =>
//                                                                   MobileRechargeAmount()));
//                                                     });
//                                                   },
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.all(
//                                                               Radius.circular(
//                                                                   5.0) //         <--- border radius here
//                                                               ),
//                                                       border: Border.all(
//                                                         color: MyTheme
//                                                             .accent_color,
//                                                       ),
//                                                     ),
//                                                     height: 25,
//                                                     width: 50,
//                                                     child: Center(
//                                                       child: Text(
//                                                           "Rs. ${planData.data[index].rechargeAmount.toString()}"),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Icon(
//                                                   Icons.keyboard_arrow_down,
//                                                   color: Colors.black,
//                                                 ),
//                                               ],
//                                             ),
//                                             children: <Widget>[
//                                               Divider(
//                                                 thickness: 1.0,
//                                                 height: 1.0,
//                                               ),
//                                               Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(
//                                                     horizontal: 16.0,
//                                                     vertical: 8.0,
//                                                   ),
//                                                   child: Text(
//                                                     "Plan Description : ${planData.data[index].rechargeLongDesc.toString()}",
//                                                     style: Theme.of(context)
//                                                         .textTheme
//                                                         .bodyText2
//                                                         .copyWith(fontSize: 16),
//                                                   ),
//                                                 ),
//                                               ),
//                                               // ButtonBar(
//                                               //   alignment: MainAxisAlignment.spaceAround,
//                                               //   buttonHeight: 52.0,
//                                               //   buttonMinWidth: 90.0,
//                                               //   children: <Widget>[
//                                               //     TextButton(
//                                               //       style: flatButtonStyle,
//                                               //       onPressed: () {
//                                               //         cardB.currentState?.expand();
//                                               //       },
//                                               //       child: Column(
//                                               //         children: <Widget>[
//                                               //           Icon(Icons.arrow_downward),
//                                               //           Padding(
//                                               //             padding: const EdgeInsets.symmetric(
//                                               //                 vertical: 2.0),
//                                               //           ),
//                                               //           Text('Open'),
//                                               //         ],
//                                               //       ),
//                                               //     ),
//                                               //     TextButton(
//                                               //       style: flatButtonStyle,
//                                               //       onPressed: () {
//                                               //         cardB.currentState?.collapse();
//                                               //       },
//                                               //       child: Column(
//                                               //         children: <Widget>[
//                                               //           Icon(Icons.arrow_upward),
//                                               //           Padding(
//                                               //             padding: const EdgeInsets.symmetric(
//                                               //                 vertical: 2.0),
//                                               //           ),
//                                               //           Text('Close'),
//                                               //         ],
//                                               //       ),
//                                               //     ),
//                                               //     TextButton(
//                                               //       style: flatButtonStyle,
//                                               //       onPressed: () {
//                                               //         cardB.currentState?.toggleExpansion();
//                                               //       },
//                                               //       child: Column(
//                                               //         children: <Widget>[
//                                               //           Icon(Icons.swap_vert),
//                                               //           Padding(
//                                               //             padding: const EdgeInsets.symmetric(
//                                               //                 vertical: 2.0),
//                                               //           ),
//                                               //           Text('Toggle'),
//                                               //         ],
//                                               //       ),
//                                               //     ),
//                                               //   ],
//                                               // ),
//                                             ],
//                                           ),
//                                         );

//                                         //  ListTile(
//                                         //   title: Text(planData[index].id.toString()),
//                                         // );
//                                       },
//                                     ),
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             bottomNavigationBar: BottomAppBar(
//               child: Container(
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                       colors: <Color>[Color(0xFF0288D1), Color(0xFF0D47A1)]),
//                 ),
//                 child: MaterialButton(
//                   onPressed: () => {_sendDataToSecondScreen(context)},
//                   child: Text(
//                     "Continue",
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                 ),
//               ),
//             ),
//           );
//   }

//   void _sendDataToSecondScreen(BuildContext context) {
//     String mobileNumber = widget.mobileNumber;
//     String operatorLogo = widget.operatorIcon;
//     String operatorName = widget.operatorName;
//     // String rechargeAmount = planData.data[0].rechargeAmount;
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (ctx) => MobileRechargeAmount(
//                   text: mobileNumber,
//                   // operatorIcon: operatorLogo,
//                   // operatorName: operatorName,
//                 )));
//   }
// }
