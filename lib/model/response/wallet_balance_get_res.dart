// To parse this JSON data, do
//
//     final walletBalanceGetResponse = walletBalanceGetResponseFromJson(jsonString);

import 'dart:convert';

WalletBalanceGetResponse walletBalanceGetResponseFromJson(String str) =>
    WalletBalanceGetResponse.fromJson(json.decode(str));

String walletBalanceGetResponseToJson(WalletBalanceGetResponse data) =>
    json.encode(data.toJson());

class WalletBalanceGetResponse {
  int balance;

  WalletBalanceGetResponse({required this.balance});

  factory WalletBalanceGetResponse.fromJson(Map<String, dynamic> json) =>
      WalletBalanceGetResponse(balance: json["balance"]);

  Map<String, dynamic> toJson() => {"balance": balance};
}
