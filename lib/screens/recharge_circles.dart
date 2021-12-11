import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
import 'package:active_ecommerce_flutter/repositories/operator_circle_repository.dart';
import 'package:flutter/material.dart';

class RechargeCircle extends StatefulWidget {
  const RechargeCircle({Key key}) : super(key: key);

  @override
  _RechargeCircleState createState() => _RechargeCircleState();
}

class _RechargeCircleState extends State<RechargeCircle> {
  bool _isLoading = true;
  List circleData = [];
  fetchCircles() async {
    var operatorCircleResponse =
        await OperatorCircleRepository().getOperatorCircleResponse();
    setState(() {
      circleData = operatorCircleResponse.data;
      _isLoading = false;
    });
    // print({circleData[5].circleCode});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCircles();
  }

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
                        itemCount: circleData.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title:
                                      Text("${circleData[index].circleName}"),
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
