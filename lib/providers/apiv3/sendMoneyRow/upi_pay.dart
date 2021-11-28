import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UPIScreen extends StatefulWidget {
  const UPIScreen({Key? key}) : super(key: key);

  @override
  _UPIScreenState createState() => _UPIScreenState();
}

class _UPIScreenState extends State<UPIScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [Text("UPI ")],
      ),
    ));
  }
}
