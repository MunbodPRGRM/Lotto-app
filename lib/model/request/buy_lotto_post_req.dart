// To parse this JSON data, do
//
//     final buyLottoPostRequest = buyLottoPostRequestFromJson(jsonString);

import 'dart:convert';

BuyLottoPostRequest buyLottoPostRequestFromJson(String str) =>
    BuyLottoPostRequest.fromJson(json.decode(str));

String buyLottoPostRequestToJson(BuyLottoPostRequest data) =>
    json.encode(data.toJson());

class BuyLottoPostRequest {
  int userId;
  int lotteryId;

  BuyLottoPostRequest({required this.userId, required this.lotteryId});

  factory BuyLottoPostRequest.fromJson(Map<String, dynamic> json) =>
      BuyLottoPostRequest(
        userId: json["user_id"],
        lotteryId: json["lottery_id"],
      );

  Map<String, dynamic> toJson() => {"user_id": userId, "lottery_id": lotteryId};
}
