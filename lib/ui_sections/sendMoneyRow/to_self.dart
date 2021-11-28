import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToSelfScreen extends StatelessWidget {
  const ToSelfScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [Text("To Self Screen")],
      ),
    ));
  }
}
