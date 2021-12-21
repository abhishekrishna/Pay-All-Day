// To parse this JSON data, do
//
//     final walletReponse = walletReponseFromJson(jsonString);

import 'dart:convert';

WalletReponse walletReponseFromJson(String str) =>
    WalletReponse.fromJson(json.decode(str));

String walletReponseToJson(WalletReponse data) => json.encode(data.toJson());

class WalletReponse {
  WalletReponse({
    this.result,
    this.message,
    this.mainWalletBalance,
    this.cashbackWalletBalance,
    this.rechargeWalletBalance,
    this.activetionWalletBalance,
    this.incomeWalletBalance,
    this.shoppingWalletBalance,
    this.voucherWalletBalance,
    this.walletTransactionHistory,
  });

  String result;
  String message;
  String mainWalletBalance;
  String cashbackWalletBalance;
  String rechargeWalletBalance;
  String activetionWalletBalance;
  String incomeWalletBalance;
  String shoppingWalletBalance;
  String voucherWalletBalance;
  List<WalletTransactionHistory> walletTransactionHistory;

  factory WalletReponse.fromJson(Map<String, dynamic> json) => WalletReponse(
        result: json["result"],
        message: json["message"],
        mainWalletBalance: json["main_wallet_balance"],
        cashbackWalletBalance: json["cashback_wallet_balance"],
        rechargeWalletBalance: json["recharge_wallet_balance"],
        activetionWalletBalance: json["activetion_wallet_balance"],
        incomeWalletBalance: json["income_wallet_balance"],
        shoppingWalletBalance: json["shopping_wallet_balance"],
        voucherWalletBalance: json["voucher_wallet_balance"],
        walletTransactionHistory: List<WalletTransactionHistory>.from(
            json["wallet_transaction_history"]
                .map((x) => WalletTransactionHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "main_wallet_balance": mainWalletBalance,
        "cashback_wallet_balance": cashbackWalletBalance,
        "recharge_wallet_balance": rechargeWalletBalance,
        "activetion_wallet_balance": activetionWalletBalance,
        "income_wallet_balance": incomeWalletBalance,
        "shopping_wallet_balance": shoppingWalletBalance,
        "voucher_wallet_balance": voucherWalletBalance,
        "wallet_transaction_history":
            List<dynamic>.from(walletTransactionHistory.map((x) => x.toJson())),
      };
}

class WalletTransactionHistory {
  WalletTransactionHistory({
    this.payCreatedAt,
    this.payYear,
    this.payMonth,
    this.payTransaction,
  });

  DateTime payCreatedAt;
  int payYear;
  int payMonth;
  List<PayTransaction> payTransaction;

  factory WalletTransactionHistory.fromJson(Map<String, dynamic> json) =>
      WalletTransactionHistory(
        payCreatedAt: DateTime.parse(json["pay_created_at"]),
        payYear: json["pay_year"],
        payMonth: json["pay_month"],
        payTransaction: List<PayTransaction>.from(
            json["pay_transaction"].map((x) => PayTransaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pay_created_at": payCreatedAt.toIso8601String(),
        "pay_year": payYear,
        "pay_month": payMonth,
        "pay_transaction":
            List<dynamic>.from(payTransaction.map((x) => x.toJson())),
      };
}

class PayTransaction {
  PayTransaction({
    this.id,
    this.payAmount,
    this.payTitle,
    this.payDescription,
    this.payStatus,
    this.payCreatedAt,
    this.payYear,
    this.payMonth,
  });

  int id;
  int payAmount;
  PayTitle payTitle;
  String payDescription;
  String payStatus;
  DateTime payCreatedAt;
  int payYear;
  int payMonth;

  factory PayTransaction.fromJson(Map<String, dynamic> json) => PayTransaction(
        id: json["id"],
        payAmount: json["pay_amount"],
        payTitle: payTitleValues.map[json["pay_title"]],
        payDescription: json["pay_description"],
        payStatus: json["pay_status"],
        payCreatedAt: DateTime.parse(json["pay_created_at"]),
        payYear: json["pay_year"],
        payMonth: json["pay_month"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pay_amount": payAmount,
        "pay_title": payTitleValues.reverse[payTitle],
        "pay_description": payDescription,
        "pay_status": payStatus,
        "pay_created_at": payCreatedAt.toIso8601String(),
        "pay_year": payYear,
        "pay_month": payMonth,
      };
}

enum PayTitle {
  RECHARGE_SUCCESSFULL_OF_JIO_JIO_10,
  RECHARGE_SUCCESSFULL_OF_VODAPHONE_VI_10,
  RECHARGE_SUCCESSFULL_OF_VODAPHONE_VI_0,
  RECHARGE_SUCCESSFULL_OF_JIO_JIO_1
}

final payTitleValues = EnumValues({
  "Recharge successfull of Jio (JIO) 1":
      PayTitle.RECHARGE_SUCCESSFULL_OF_JIO_JIO_1,
  "Recharge successfull of Jio (JIO) 10":
      PayTitle.RECHARGE_SUCCESSFULL_OF_JIO_JIO_10,
  "Recharge successfull of Vodaphone (VI) 0":
      PayTitle.RECHARGE_SUCCESSFULL_OF_VODAPHONE_VI_0,
  "Recharge successfull of Vodaphone (VI) 10":
      PayTitle.RECHARGE_SUCCESSFULL_OF_VODAPHONE_VI_10
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
