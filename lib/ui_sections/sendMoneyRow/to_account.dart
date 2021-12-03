import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ToAccount extends StatelessWidget {
  const ToAccount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Send Money to Bank Account",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Container(
                height: SizeConfig.blockSizeVertical * 40,
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(Icons.details),
                      title: Text("Enter Bank A/c Details"),
                      subtitle: Text("Choose Bank or enter IFSC Details"),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                    ),
                    ListTile(
                      leading: Icon(Icons.upcoming),
                      title: Text("Enter UPI ID"),
                      subtitle: Text("You have got a geek bone"),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                    ),
                    ListTile(
                      leading: Icon(Icons.mobile_friendly),
                      title: Text("Enter Mobile Number"),
                      subtitle: Text("Direct Transfer to Linked Bank Account"),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                    ),
                    ListTile(
                      leading: Icon(Icons.search),
                      title: Text("Search"),
                      subtitle: Text("By Name or Bank Account"),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                    )
                  ],
                ),
              ),
              Container(
                height: SizeConfig.blockSizeVertical * 4,
                decoration: BoxDecoration(color: Colors.grey.shade400),
                child: Center(
                  child: Text(
                    "Saved Accounts",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
              Container(
                height: SizeConfig.blockSizeVertical * 40,
                child: ListView(
                  children: [
                    ListTile(
                      leading: CircleAvatar(),
                      title: Text("Jhon Doe"),
                      isThreeLine: true,
                      subtitle: Text("Citi Bank \nPaid Rs. 1001/-"),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                    ),
                    ListTile(
                      leading: CircleAvatar(),
                      title: Text("Alexandra Dadario"),
                      isThreeLine: true,
                      subtitle: Text("State Bank of India\nPaid Rs. 11/-"),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                    ),
                    ListTile(
                      leading: CircleAvatar(),
                      title: Text("Gal Gadot"),
                      isThreeLine: true,
                      subtitle: Text("Canara Bank\nPaid Rs. 101/-"),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                    ),
                    ListTile(
                      leading: CircleAvatar(),
                      title: Text("Mia Pearl"),
                      isThreeLine: true,
                      subtitle:
                          Text("By Name or Bank Account\nPaid Rs. 9819/-"),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                    ),
                    ListTile(
                      leading: CircleAvatar(),
                      title: Text("Jhon Snow"),
                      isThreeLine: true,
                      subtitle:
                          Text("By Name or Bank Account\nPaid Rs. 9819/-"),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                    )
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
