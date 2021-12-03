import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToContactSend extends StatelessWidget {
  const ToContactSend({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // title: Text("Send Money"),

          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/logo.png",
              ),
            )
          ],
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Send Money to Bank A/c\nusing Mobile Number",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 2,
                ),
                TextField(
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.contact_mail),
                      prefixIcon: Icon(Icons.search)),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 2,
                ),
                Container(
                  height: SizeConfig.safeBlockVertical * 3.5,
                  child: Center(child: Text("Recent Money Transfers")),
                  decoration: BoxDecoration(color: Colors.grey.shade300),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 2,
                ),
                Container(
                    height: SizeConfig.blockSizeVertical * 40,
                    child: GridView.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 5,
                      children: <Widget>[
                        Column(
                          children: [CircleAvatar(), Text("Contact 1")],
                        ),
                        Column(
                          children: [CircleAvatar(), Text("Contact 2")],
                        ),
                        Column(
                          children: [CircleAvatar(), Text("Contact 3")],
                        ),
                        Column(
                          children: [CircleAvatar(), Text("Contact 4")],
                        ),
                        Column(
                          children: [CircleAvatar(), Text("Contact 1")],
                        ),
                        Column(
                          children: [CircleAvatar(), Text("Contact 2")],
                        ),
                        Column(
                          children: [CircleAvatar(), Text("Contact 3")],
                        ),
                        Column(
                          children: [CircleAvatar(), Text("Contact 4")],
                        ),
                        Column(
                          children: [CircleAvatar(), Text("Contact 1")],
                        ),
                        Column(
                          children: [CircleAvatar(), Text("Contact 2")],
                        ),
                        Column(
                          children: [CircleAvatar(), Text("Contact 3")],
                        ),
                        Column(
                          children: [CircleAvatar(), Text("Contact 4")],
                        ),
                      ],
                    )),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ))),
                    onPressed: () {},
                    child: Text("View All +"),
                  ),
                ),
                Container(
                  height: SizeConfig.safeBlockVertical * 30,
                  child: ListView(
                    children: [
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.attach_money),
                          title: Text("Account Balance"),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.history),
                          title: Text("Payments History"),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.history),
                          title: Text("Your Contacts on PayAllDay"),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.history),
                          title: Text("Refer and Earn"),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
