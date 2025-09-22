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
  int? amount; // ให้เป็น nullable

  LottoRedeemPostResponse({required this.message, this.amount});

  factory LottoRedeemPostResponse.fromJson(Map<String, dynamic> json) =>
      LottoRedeemPostResponse(
        message: json["message"],
        amount: json["amount"] != null ? json["amount"] as int : null,
      );

  Map<String, dynamic> toJson() => {"message": message, "amount": amount};
}

class Prize {
  int rank;
  int amount;

  Prize({required this.rank, required this.amount});

  factory Prize.fromJson(Map<String, dynamic> json) =>
      Prize(rank: json["rank"], amount: json["amount"]);

  Map<String, dynamic> toJson() => {"rank": rank, "amount": amount};
}
