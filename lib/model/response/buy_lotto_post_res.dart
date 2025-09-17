// To parse this JSON data, do
//
//     final buyLottoPostResponse = buyLottoPostResponseFromJson(jsonString);

import 'dart:convert';

BuyLottoPostResponse buyLottoPostResponseFromJson(String str) =>
    BuyLottoPostResponse.fromJson(json.decode(str));

String buyLottoPostResponseToJson(BuyLottoPostResponse data) =>
    json.encode(data.toJson());

class BuyLottoPostResponse {
  String message;
  int lotteryId;
  int newBalance;

  BuyLottoPostResponse({
    required this.message,
    required this.lotteryId,
    required this.newBalance,
  });

  factory BuyLottoPostResponse.fromJson(Map<String, dynamic> json) =>
      BuyLottoPostResponse(
        message: json["message"],
        lotteryId: json["lottery_id"],
        newBalance: json["new_balance"],
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "lottery_id": lotteryId,
    "new_balance": newBalance,
  };
}
