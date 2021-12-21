import 'dart:developer';

import 'package:active_ecommerce_flutter/data_model/operator_list_response.dart';
import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/providers/apiv3/api_constants.dart';
import 'package:active_ecommerce_flutter/repositories/operator_list_repository.dart';
import 'package:active_ecommerce_flutter/screens/select_circles.dart';
import 'package:flutter/material.dart';

class SelectMOperator extends StatefulWidget {
  final String number;
  const SelectMOperator({Key key, this.number}) : super(key: key);

  @override
  _SelectMOperatorState createState() => _SelectMOperatorState();
}

class _SelectMOperatorState extends State<SelectMOperator> {
  bool _isLoading = true;
  OperatorListResponse operatorListdata = OperatorListResponse();
  fetchOperatorList() async {
    var operatorListResponse =
        await OperatorListRepository().getOpeartorListResponse("2");
    setState(() {
      _isLoading = true;
      operatorListdata = operatorListResponse;
      print(operatorListResponse.data);
      _isLoading = false;
    });
  }

  @override
  void initState() {
    fetchOperatorList();
    // TODO: implement initState
    super.initState();
  }

  static Map<String, String> getTokenHeaders() {
    Map<String, String> headers = new Map();
    headers['Authorization'] = access_token.toString();
    return headers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.splash_screen_color,
        foregroundColor: MyTheme.black_color,
        title: Text(
          "Select Mobile Operator",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Container(
                      height: SizeConfig.blockSizeVertical * 100,
                      child: GridView.builder(
                        physics: new NeverScrollableScrollPhysics(),
                        itemCount: operatorListdata.data.length ?? "",
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              elevation: 5,
                              child: InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => RechargeCircle(
                                                numberToSetOperator:
                                                    widget.number,
                                                operatorIcon: operatorListdata
                                                    .data[index].operatorIcon,
                                                operatorName: operatorListdata
                                                    .data[index].operatorName,
                                              )));

                                  log('${API.IMAGE_URL + operatorListdata.data[0].operatorIcon} ');
                                },
                                child: Container(
                                  child: new GridTile(
                                    // footer:

                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          child: Image.network(
                                            '${API.IMAGE_URL + operatorListdata.data[index].operatorIcon}',
                                            height: 80,
                                            width: 50,
                                          ),
                                        ),
                                        Center(
                                          child: FittedBox(
                                            child: new Text(
                                              operatorListdata
                                                  .data[index].operatorName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // child: new NetworkImage(
                                    //   "$API.BASE_URL//all//BnPSD5ELXQBbJXUY6pOlmkKg50eSftFewJxJefLI.png",
                                    //   height: 50,
                                    // ), //just for testing, will fill with image later
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
