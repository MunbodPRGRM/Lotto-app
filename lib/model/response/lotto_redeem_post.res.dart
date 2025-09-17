// To parse this JSON data, do
//
//     final lottoRedeemPostResponse = lottoRedeemPostResponseFromJson(jsonString);

import 'dart:convert';

LottoRedeemPostResponse lottoRedeemPostResponseFromJson(String str) =>
    LottoRedeemPostResponse.fromJson(json.decode(str));

String lottoRedeemPostResponseToJson(LottoRedeemPostResponse data) =>
    json.encode(data.toJson());

class LottoRedeemPostResponse {
  String message;
  int amount;

  LottoRedeemPostResponse({required this.message, required this.amount});

  factory LottoRedeemPostResponse.fromJson(Map<String, dynamic> json) =>
      LottoRedeemPostResponse(message: json["message"], amount: json["amount"]);

  Map<String, dynamic> toJson() => {"message": message, "amount": amount};
}
