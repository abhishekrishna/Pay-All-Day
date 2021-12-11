import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/screens/recharge_circles.dart';
import 'package:flutter/material.dart';

class SelectMOperator extends StatefulWidget {
  const SelectMOperator({Key key}) : super(key: key);

  @override
  _SelectMOperatorState createState() => _SelectMOperatorState();
}

class _SelectMOperatorState extends State<SelectMOperator> {
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
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical * 20,
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 100,
              child: GridView.builder(
                itemCount: 5,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => RechargeCircle()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: new Card(
                        child: new GridTile(
                          footer: new Text('JIO'),
                          child: new Text(
                              "Jio"), //just for testing, will fill with image later
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
