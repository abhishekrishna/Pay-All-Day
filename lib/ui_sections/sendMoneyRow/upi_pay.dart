import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
// import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/screens/qr_pay.dart';
import 'package:active_ecommerce_flutter/ui_sections/sendMoneyRow/to_wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UPIScreen extends StatefulWidget {
  const UPIScreen({Key key}) : super(key: key);

  @override
  _UPIScreenState createState() => _UPIScreenState();
}

class _UPIScreenState extends State<UPIScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        // title: Text(
        //   "UPI",
        //   style: TextStyle(color: MyTheme.black_color),
        // ),
        automaticallyImplyLeading: true,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Transfer Money",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    elevation: 10,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) => ToWallet()));
                      },
                      child: Container(
                        height: SizeConfig.blockSizeVertical * 20,
                        width: SizeConfig.blockSizeHorizontal * 30,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.send_to_mobile,
                              size: 50,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Send Money")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    child: Container(
                      height: SizeConfig.blockSizeVertical * 20,
                      width: SizeConfig.blockSizeHorizontal * 30,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.request_page,
                            size: 50,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Request Money")
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
              ),
              Center(
                child: Card(
                  elevation: 10,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => QRPay()));
                    },
                    child: Container(
                      height: SizeConfig.blockSizeVertical * 20,
                      width: SizeConfig.blockSizeHorizontal * 30,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.qr_code_scanner,
                            size: 50,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Scan QR")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
              ),
              Text(
                "My Transactions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
              ),
              Container(
                height: SizeConfig.blockSizeVertical * 30,
                child: ListView(
                  children: [
                    Card(
                      elevation: 5,
                      child: ListTile(
                          leading: Text(
                            "Transactions",
                            style: TextStyle(fontSize: 15),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                          )),
                    ),
                    Card(
                      elevation: 5,
                      child: ListTile(
                          leading: Text(
                            "My Profile",
                            style: TextStyle(fontSize: 15),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                          )),
                    ),
                    myTransactionTile(
                        context, "Bank Accounts", Icons.arrow_back_ios_new),
                    myTransactionTile(
                        context, "My Beneficiaries", Icons.arrow_back_ios_new),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

Widget myTransactionTile(
    BuildContext context, String leadText, IconData trailIcon) {
  return Card(
    elevation: 5,
    child: ListTile(
        leading: Text(
          leadText,
          style: TextStyle(fontSize: 15),
        ),
        trailing: Icon(
          trailIcon,
          size: 18,
        )),
  );
}
