import 'dart:developer';

import 'package:active_ecommerce_flutter/data_model/transaction_response.dart';
import 'package:active_ecommerce_flutter/data_model/wallet_response.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/repositories/transaction_repository.dart';
import 'package:active_ecommerce_flutter/repositories/wallet_repository.dart';
import 'package:flutter/material.dart';

class Passbook extends StatefulWidget {
  const Passbook({Key key}) : super(key: key);

  @override
  State<Passbook> createState() => _PassbookState();
}

class _PassbookState extends State<Passbook> {
  WalletReponse walletData = WalletReponse();
  TransactionResponse transactionData = TransactionResponse();
  bool isLoading = true;

  fetchBalanceDetails() async {
    var balanceDetailsResponse = await WalletRepository().getBalance();

    setState(() {
      walletData = balanceDetailsResponse;
      isLoading = false;

      // print("This is wallet data --> ${walletData.mainWalletBalance}");
    });
  }

  fetchTransactionDetails() async {
    var transactionDetailsResponse =
        await TransactionRepository().getTransactions();

    setState(() {
      transactionData = transactionDetailsResponse;
      print("This is transaction data --> ${transactionData.data}");
      isLoading = false;
    });
  }

  @override
  void initState() {
    fetchBalanceDetails();
    fetchTransactionDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: Text(
          "Account Balance & History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "MY WALLETS",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                    ),
                    SizedBox(
                      height: mediaQuery.height * 0.03,
                    ),
                    Container(
                        height: mediaQuery.height * 0.6,
                        child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              passBookCards(
                                  context,
                                  walletData,
                                  "PAYALLDAY WALLET",
                                  "\u{20B9} ${walletData.mainWalletBalance}" ??
                                      ""),
                              passBookCards(
                                  context,
                                  walletData,
                                  "CASHBACK WALLET",
                                  "\u{20B9} ${walletData.cashbackWalletBalance}" ??
                                      ""),
                              passBookCards(
                                  context,
                                  walletData,
                                  "INCOME WALLET",
                                  "\u{20B9} ${walletData.incomeWalletBalance}" ??
                                      ""),
                              passBookCards(
                                  context,
                                  walletData,
                                  "SHOPPING WALLET",
                                  "\u{20B9} ${walletData.shoppingWalletBalance}" ??
                                      ""),
                              passBookCards(
                                  context,
                                  walletData,
                                  "VOUCHER WALLET",
                                  "\u{20B9} ${walletData.voucherWalletBalance}" ??
                                      "")
                            ])),
                    Padding(
                      padding: const EdgeInsets.only(left: 160),
                      child: SizedBox(
                        width: mediaQuery.width * 0.22,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side:
                                            BorderSide(color: Colors.indigo)))),
                            onPressed: () {},
                            child: Row(
                              children: [
                                FittedBox(
                                  child: Text(
                                    "View All",
                                    style: TextStyle(
                                        color: Colors.indigo,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.indigo,
                                )
                              ],
                            )),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "PAYMENT HISTORY",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                        Icon(Icons.list_alt)
                      ],
                    ),
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            height: mediaQuery.height * 4.4,
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: walletData
                                        .walletTransactionHistory[0]
                                        .payTransaction
                                        .length ??
                                    "",
                                itemBuilder: (
                                  context,
                                  index,
                                ) {
                                  // log("${walletData.walletTransactionHistory[0].payTransaction[index].payTitle}");
                                  return isLoading
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : ListTile(
                                          leading: CircleAvatar(
                                            child: Text(
                                              "${walletData.walletTransactionHistory[0].payTransaction[index].id}" ??
                                                  "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          title: Text(
                                            "${walletData.walletTransactionHistory[0].payTransaction[index].payTitle}"
                                                    .replaceAll(
                                                        "PayTitle.", "") ??
                                                "",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                          subtitle: Text(
                                            "${walletData.walletTransactionHistory[0].payTransaction[index].payCreatedAt}"
                                                    .replaceAll(".000Z", "") ??
                                                "",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          trailing: Text(
                                            "\u{20B9} ${walletData.walletTransactionHistory[0].payTransaction[index].payAmount}" ??
                                                "",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        );
                                }),
                          )
                  ],
                ),
              ),
            ),
    ));
  }
}

Widget passBookCards(BuildContext context, WalletReponse walletData,
    String cardTitle, String walletAmount) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    elevation: 3,
    child: ListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      leading: Icon(
        Icons.wallet_giftcard,
        color: MyTheme.accent_color,
      ),
      title: Text(
        cardTitle,
        style: TextStyle(
          fontWeight: FontWeight.w800,
        ),
      ),
      isThreeLine: true,
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              walletAmount ?? "",
              style: TextStyle(
                  color: MyTheme.black_color,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            // SizedBox(
            //   height: mediaQuery.height * 1,
            // ),
            // Text("Savings Account No. XXXXXXXX567"),
            // SizedBox(
            //   height: mediaQuery.height * 1,
            // ),
            // Text(
            //   "Share Account No & IFSC Code ",
            //   style: TextStyle(
            //       color: Colors.blue.shade400,
            //       fontWeight: FontWeight.bold,
            //       fontSize: 12),
            // )
          ],
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.all(10),
        child: Icon(
          Icons.arrow_forward_ios_outlined,
          size: 20,
          color: MyTheme.black_color,
        ),
      ),
      tileColor: Colors.blue.shade50,
      // trailing: ,
    ),
  );
}
