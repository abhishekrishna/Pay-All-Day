import 'package:flutter/material.dart';

class MyWallet extends StatelessWidget {
  const MyWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [Text("To My Wallet Screen")],
      ),
    ));
  }
}
