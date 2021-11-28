import 'package:flutter/material.dart';

class ElectricBill extends StatelessWidget {
  const ElectricBill({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [Text("Electric Bill")],
      ),
    ));
  }
}
