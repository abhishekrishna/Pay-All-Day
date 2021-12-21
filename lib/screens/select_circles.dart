import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/data_model/operator_circle_response.dart';
import 'package:active_ecommerce_flutter/data_model/operator_data_response.dart';
import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
import 'package:active_ecommerce_flutter/repositories/operator_circle_repository.dart';
import 'package:active_ecommerce_flutter/repositories/operator_repository.dart';
import 'package:active_ecommerce_flutter/ui_sections/rechargeServicesRow/mobile_recharge_amount.dart';
import 'package:active_ecommerce_flutter/ui_sections/rechargeServicesRow/select_operator.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class RechargeCircle extends StatefulWidget {
  final String operatorIcon;
  final String operatorName;
  final String numberToSetOperator;

  const RechargeCircle(
      {Key key, this.operatorName, this.numberToSetOperator, this.operatorIcon})
      : super(key: key);

  @override
  _RechargeCircleState createState() => _RechargeCircleState();
}

class _RechargeCircleState extends State<RechargeCircle> {
  bool _isLoading = true;
  CircleReponse circleData = CircleReponse();
  bool isFetchingOperators = false;
  String selectedCircle = "";

  List planData = [];
  List _listOpData = [];
  FindMobileOperator operatorData = FindMobileOperator();
  @override
  void initState() {
    super.initState();
    fetchCircles();
    _findMobileOperator();
  }

  fetchCircles() async {
    var operatorCircleResponse =
        await OperatorCircleRepository().getOperatorCircleResponse();
    setState(() {
      circleData = operatorCircleResponse;
      _isLoading = false;
    });
    // print({circleData[5].circleCode});
  }

  _moveToPlansScreen() {
    String operatorLogo = operatorData.operatorIcon.toString();
    String matchedMobile = widget.numberToSetOperator;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => MobileRechargeAmount(
                text: matchedMobile,
                operatorId:
                    operatorData.operatorMatchedData.operatorId.toString(),
                operatorIcon: operatorLogo)));
  }

  _moveToOperatorSelection() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => SelectMOperator(
                  number: widget.numberToSetOperator,
                )));
  }

  _findMobileOperator() async {
    isFetchingOperators = true;
    var phoneNumber = widget.numberToSetOperator;
    var rechargeService = "2";
    var rechargeServiceType = "3";
    var operatorResponse = await OperatorRepository().getOpeartorDataResponse(
        phoneNumber, rechargeService, rechargeServiceType);
    setState(() {
      operatorData = operatorResponse;
      print(operatorData.toString());
    });

    if (operatorData.operatorIsMatched == true) {
      isFetchingOperators = false;
      _moveToPlansScreen();
      // ToastComponent.showDialog(
      //     operatorResponse.data[0].operatorIsMatched.toString(), context,
      //     gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
    } else if (operatorData.operatorIsMatched == false) {
      _moveToOperatorSelection();
      ToastComponent.showDialog(
          operatorResponse.data[1].operatorIsMatched.toString(), context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (ctx) => MobileRechargeAmount()));
    }
  }

  // _getCircleValue(int i) {
  //   return selectedCircle = circleData[i].circleCode;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          "Select Circle",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    // color: Colors.amber,
                    height: SizeConfig.blockSizeVertical * 180,
                    child: ListView.builder(
                        itemCount: circleData.data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onTap: () {
                                    _moveToPlansScreen();
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (ctx) =>
                                    //             MobileRechargeAmount(
                                    //                 text: widget
                                    //                     .numberToSetOperator,
                                    //                 operatorName:
                                    //                     widget.operatorName,
                                    //                 operatorIcon:
                                    //                     widget.operatorIcon)
                                    //                     )
                                    //                     );
                                  },
                                  title: Text(
                                      "${circleData.data[index].circleName}"),
                                  // leading: Text("${circleData[index].circleCode}"),
                                ),
                              ),
                              Divider()
                            ],
                          );
                        }),
                  ),
                  Divider(
                    height: 2,
                  )
                ],
              ),
            ),
    );
  }
}
