import 'package:flutter/material.dart';

class ToAccount extends StatelessWidget {
  const ToAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [Text("Account Screen")],
      ),
    ));
  }
}
