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
    this.incomeWalletBalance,
    this.shoppingWalletBalance,
    this.voucherWalletBalance,
    this.walletTransactionHistory,
  });

  int result;
  String message;
  double mainWalletBalance;
  int cashbackWalletBalance;
  int rechargeWalletBalance;
  int incomeWalletBalance;
  int shoppingWalletBalance;
  int voucherWalletBalance;
  List<WalletTransactionHistory> walletTransactionHistory;

  factory WalletReponse.fromJson(Map<String, dynamic> json) => WalletReponse(
        result: json["result"],
        message: json["message"],
        mainWalletBalance: json["main_wallet_balance"],
        cashbackWalletBalance: json["cashback_wallet_balance"],
        rechargeWalletBalance: json["recharge_wallet_balance"],
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
  dynamic payAmount;
  dynamic payTitle;
  dynamic payDescription;
  String payStatus;
  DateTime payCreatedAt;
  int payYear;
  int payMonth;

  factory PayTransaction.fromJson(Map<String, dynamic> json) => PayTransaction(
        id: json["id"],
        payAmount: json["pay_amount"],
        payTitle: json["pay_title"],
        payDescription: json["pay_description"],
        payStatus: json["pay_status"],
        payCreatedAt: DateTime.parse(json["pay_created_at"]),
        payYear: json["pay_year"],
        payMonth: json["pay_month"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pay_amount": payAmount,
        "pay_title": payTitle,
        "pay_description": payDescription,
        "pay_status": payStatus,
        "pay_created_at": payCreatedAt.toIso8601String(),
        "pay_year": payYear,
        "pay_month": payMonth,
      };
}
