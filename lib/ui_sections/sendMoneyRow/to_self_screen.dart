import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
import 'package:flutter/material.dart';

enum BankType { StateBankOfIndia, BankofBaroda, NewBankAcc }

class ToSelfScreen extends StatefulWidget {
  ToSelfScreen({Key key}) : super(key: key);

  @override
  State<ToSelfScreen> createState() => _ToSelfScreenState();
}

class _ToSelfScreenState extends State<ToSelfScreen> {
  BankType _bankType = BankType.StateBankOfIndia;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Send money to your own Bank Account",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2.5,
            ),
            Text(
              "Select bank account you want to send money to",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600),
            ),
            SizedBox(height: SizeConfig.safeBlockVertical * 2),
            Container(
              height: SizeConfig.safeBlockVertical * 20,
              child: ListView(
                children: [
                  ListTile(
                    leading: Radio(
                        value: BankType.StateBankOfIndia,
                        groupValue: _bankType,
                        onChanged: (BankType value) {
                          setState(() {
                            _bankType = value;
                          });
                        }),
                    title: Text(
                      "Bank of Baroda",
                    ),
                    trailing: Icon(Icons.food_bank_outlined),
                  ),
                  ListTile(
                    leading: Radio(
                        value: BankType.BankofBaroda,
                        groupValue: _bankType,
                        onChanged: (BankType value) {
                          setState(() {
                            _bankType = value;
                          });
                        }),
                    title: Text(
                      "State Bank of India",
                    ),
                    trailing: Icon(Icons.indeterminate_check_box),
                  ),
                  ListTile(
                    leading: Radio(
                        value: BankType.NewBankAcc,
                        groupValue: _bankType,
                        onChanged: (BankType value) {
                          setState(() {
                            _bankType = value;
                          });
                        }),
                    title: Text(
                      "New Bank Account",
                    ),
                    // trailing: Icon(Icons.food_bank_outlined),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: SizeConfig.blockSizeVertical * 8,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Color(0xFF0288D1), Color(0xFF0D47A1)]),
          ),
          child: MaterialButton(
            onPressed: () => {},
            child: Text(
              "Proceed",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    ));
  }
}
