import 'package:flutter/material.dart';

class Passbook extends StatelessWidget {
  const Passbook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [Text("To Passbook Screen")],
      ),
    ));
  }
}
