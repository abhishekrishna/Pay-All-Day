import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:flutter/material.dart';

class Passbook extends StatelessWidget {
  const Passbook({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: Text("Account Balance & History"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Accounts",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            Container(
                height: SizeConfig.blockSizeVertical * 70,
                child: ListView(children: [
                  Card(
                    elevation: 10,
                    child: ExpansionTile(
                      leading: Icon(
                        Icons.wallet_giftcard,
                        color: MyTheme.accent_color,
                      ),
                      title: Text(
                        "Wallet Balance",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: ListTile(
                            leading: Icon(
                              Icons.casino_sharp,
                              color: MyTheme.accent_color,
                            ),
                            title: Text(
                              "Recharge",
                            ),
                            trailing: Text("Rs. 500"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: ListTile(
                            leading: Icon(
                              Icons.monetization_on,
                              color: MyTheme.accent_color,
                            ),
                            title: Text("Income"),
                            trailing: Text("Rs. 50000"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: ListTile(
                            leading: Icon(
                              Icons.monetization_on,
                              color: MyTheme.accent_color,
                            ),
                            title: Text("CashBack"),
                            trailing: Text("Rs. 2000"),
                          ),
                        )
                      ],
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.food_bank_outlined),
                      title: Text("State Bank of India"),
                      trailing: Text("Check Now"),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.food_bank_outlined),
                      title: Text("Canara Bank"),
                      trailing: Text("Check Now"),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.food_bank_outlined),
                      title: Text("Axis Bank"),
                      trailing: Text("Check Now"),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.food_bank_outlined),
                      title: Text("Postpaid"),
                      trailing: Text("Apply Now"),
                    ),
                  )
                ]))
          ],
        ),
      ),
    ));
  }
}
