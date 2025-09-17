// To parse this JSON data, do
//
//     final lottoCheckGetResponse = lottoCheckGetResponseFromJson(jsonString);

import 'dart:convert';

List<LottoCheckGetResponse> lottoCheckGetResponseFromJson(String str) =>
    List<LottoCheckGetResponse>.from(
      json.decode(str).map((x) => LottoCheckGetResponse.fromJson(x)),
    );

String lottoCheckGetResponseToJson(List<LottoCheckGetResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LottoCheckGetResponse {
  int lotteryId;
  String number;
  int price;
  int prizeRank;
  int prizeAmount;

  LottoCheckGetResponse({
    required this.lotteryId,
    required this.number,
    required this.price,
    required this.prizeRank,
    required this.prizeAmount,
  });

  factory LottoCheckGetResponse.fromJson(Map<String, dynamic> json) =>
      LottoCheckGetResponse(
        lotteryId: json["lottery_id"],
        number: json["number"],
        price: json["price"],
        prizeRank: json["prize_rank"],
        prizeAmount: json["prize_amount"],
      );

  Map<String, dynamic> toJson() => {
    "lottery_id": lotteryId,
    "number": number,
    "price": price,
    "prize_rank": prizeRank,
    "prize_amount": prizeAmount,
  };
}
