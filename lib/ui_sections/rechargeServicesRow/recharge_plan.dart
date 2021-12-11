import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
import 'package:active_ecommerce_flutter/repositories/operator_plans_repository.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

import '../../my_theme.dart';

class RechargePlans extends StatefulWidget {
  final String mobileNumber;
  RechargePlans(this.mobileNumber);

  @override
  _RechargePlansState createState() => _RechargePlansState();
}

class _RechargePlansState extends State<RechargePlans> {
  List planData = [];
  List operatorData = [];
  bool isLoading = true;

  @override
  void initState() {
    _findMobilePlans();
    super.initState();
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
  // }

  _findMobilePlans() async {
    var phoneNumber = widget.mobileNumber.toString();
    var rechargeService = "1234";
    var rechargeOperatorCode = "JIO";
    var rechargeOperatorCircle = "23";
    var plansResponse = await OperatorPlansRepository()
        .getOperatorPlansResponse(phoneNumber, rechargeService,
            rechargeOperatorCode, rechargeOperatorCircle);
    setState(() {
      isLoading = true;
      planData = plansResponse.data;
      isLoading = false;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding:
                          const EdgeInsets.only(left: 30, top: 20, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            operatorData[1].operatorName ??
                                "Operator Not Matched",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          // Image.network(operatorData[0].operatorIcon, width: 50)
                        ],
                      ),
                    ),
              Container(
                height: SizeConfig.blockSizeVertical * 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: SizeConfig.safeBlockVertical * 150,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child:
                            //           ListView(
                            //             children: [
                            //               // Card(
                            //               //   child: ListTile(
                            //               //     leading: Text('Val : \n10 Days'),
                            //               //     title: Text("Plan Short Details"),
                            //               //     subtitle: Text('Plan Long Details : .'),
                            //               //     trailing: Column(
                            //               //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //               //       children: [
                            //               //         Container(
                            //               //           decoration: BoxDecoration(
                            //               //             borderRadius: BorderRadius.all(
                            //               //                 Radius.circular(
                            //               //                     5.0) //         <--- border radius here
                            //               //                 ),
                            //               //             border: Border.all(
                            //               //               color: MyTheme.accent_color,
                            //               //             ),
                            //               //           ),
                            //               //           height: 25,
                            //               //           width: 40,
                            //               //           child: Center(
                            //               //             child: Text("Rs. 34"),
                            //               //           ),
                            //               //         ),
                            //               //         Icon(
                            //               //           Icons.keyboard_arrow_down,
                            //               //           color: Colors.black,
                            //               //         ),
                            //               //       ],
                            //               //     ),
                            //               //     isThreeLine: true,
                            //               //   ),
                            //               // ),
                            //               // SizedBox(
                            //               //   height: 5,
                            //               // ),

                            //               Padding(
                            //                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            //                 child: ExpansionTileCard(
                            //                   initialElevation: 5,
                            //                   elevation: 5,
                            //                   key: cardA,
                            //                   leading: Text('Validity:\n10 Days'),
                            //                   title: Text('Tap me!'),
                            //                   subtitle: Text('I expand!'),
                            //                   trailing: Column(
                            //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //                     children: [
                            //                       Container(
                            //                         decoration: BoxDecoration(
                            //                           borderRadius: BorderRadius.all(
                            //                               Radius.circular(
                            //                                   5.0) //         <--- border radius here
                            //                               ),
                            //                           border: Border.all(
                            //                             color: MyTheme.accent_color,
                            //                           ),
                            //                         ),
                            //                         height: 25,
                            //                         width: 40,
                            //                         child: Center(
                            //                           child: Text("Rs. 34"),
                            //                         ),
                            //                       ),
                            //                       Icon(
                            //                         Icons.keyboard_arrow_down,
                            //                         color: Colors.black,
                            //                       ),
                            //                     ],
                            //                   ),
                            //                   children: <Widget>[
                            //                     Divider(
                            //                       thickness: 1.0,
                            //                       height: 1.0,
                            //                     ),
                            //                     Align(
                            //                       alignment: Alignment.centerLeft,
                            //                       child: Padding(
                            //                         padding: const EdgeInsets.symmetric(
                            //                           horizontal: 16.0,
                            //                           vertical: 8.0,
                            //                         ),
                            //                         child: Text(
                            //                           """Hi there, I'm a drop-in replacement for Flutter's ExpansionTile.

                            // Use me any time you think your app could benefit from being just a bit more Material.

                            // These buttons control the next card down!""",
                            //                           style: Theme.of(context)
                            //                               .textTheme
                            //                               .bodyText2
                            //                               .copyWith(fontSize: 16),
                            //                         ),
                            //                       ),
                            //                     ),
                            //                     // ButtonBar(
                            //                     //   alignment: MainAxisAlignment.spaceAround,
                            //                     //   buttonHeight: 52.0,
                            //                     //   buttonMinWidth: 90.0,
                            //                     //   children: <Widget>[
                            //                     //     TextButton(
                            //                     //       style: flatButtonStyle,
                            //                     //       onPressed: () {
                            //                     //         cardB.currentState?.expand();
                            //                     //       },
                            //                     //       child: Column(
                            //                     //         children: <Widget>[
                            //                     //           Icon(Icons.arrow_downward),
                            //                     //           Padding(
                            //                     //             padding: const EdgeInsets.symmetric(
                            //                     //                 vertical: 2.0),
                            //                     //           ),
                            //                     //           Text('Open'),
                            //                     //         ],
                            //                     //       ),
                            //                     //     ),
                            //                     //     TextButton(
                            //                     //       style: flatButtonStyle,
                            //                     //       onPressed: () {
                            //                     //         cardB.currentState?.collapse();
                            //                     //       },
                            //                     //       child: Column(
                            //                     //         children: <Widget>[
                            //                     //           Icon(Icons.arrow_upward),
                            //                     //           Padding(
                            //                     //             padding: const EdgeInsets.symmetric(
                            //                     //                 vertical: 2.0),
                            //                     //           ),
                            //                     //           Text('Close'),
                            //                     //         ],
                            //                     //       ),
                            //                     //     ),
                            //                     //     TextButton(
                            //                     //       style: flatButtonStyle,
                            //                     //       onPressed: () {
                            //                     //         cardB.currentState?.toggleExpansion();
                            //                     //       },
                            //                     //       child: Column(
                            //                     //         children: <Widget>[
                            //                     //           Icon(Icons.swap_vert),
                            //                     //           Padding(
                            //                     //             padding: const EdgeInsets.symmetric(
                            //                     //                 vertical: 2.0),
                            //                     //           ),
                            //                     //           Text('Toggle'),
                            //                     //         ],
                            //                     //       ),
                            //                     //     ),
                            //                     //   ],
                            //                     // ),
                            //                   ],
                            //                 ),
                            //               ),
                            //               // Card(
                            //               //   child: ListTile(
                            //               //     leading: FlutterLogo(size: 72.0),
                            //               //     title: Text('Three-line ListTile'),
                            //               //     subtitle: Text(
                            //               //         'A sufficiently long subtitle warrants three lines.'),
                            //               //     trailing: Icon(Icons.more_vert),
                            //               //     isThreeLine: true,
                            //               //   ),
                            //               // ),
                            //               SizedBox(
                            //                 height: 5,
                            //               ),
                            //               Card(
                            //                 child: ListTile(
                            //                   leading: FlutterLogo(size: 72.0),
                            //                   title: Text('Three-line ListTile'),
                            //                   subtitle: Text(
                            //                       'A sufficiently long subtitle warrants three lines.'),
                            //                   trailing: Icon(Icons.more_vert),
                            //                   isThreeLine: true,
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            isLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView.builder(
                                    itemCount: planData.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ExpansionTileCard(
                                          initialElevation: 5,
                                          elevation: 5,
                                          // key: cardA6
                                          leading: Text(
                                            "Validity: \n${planData[index].rechargeValidity.toString()}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          title: Text(
                                            planData[index]
                                                .rechargeShortDesc
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(planData[index]
                                              .rechargeTalktime
                                              .toString()),
                                          trailing: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
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
                                                      "Rs. ${planData[index].rechargeAmount.toString()}"),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 16.0,
                                                  vertical: 8.0,
                                                ),
                                                child: Text(
                                                  "Plan Description : ${planData[index].rechargeLongDesc.toString()}",
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
                                      );

                                      //  ListTile(
                                      //   title: Text(planData[index].id.toString()),
                                      // );
                                    },
                                  ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
