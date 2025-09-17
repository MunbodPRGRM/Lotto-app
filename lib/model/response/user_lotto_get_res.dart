// To parse this JSON data, do
//
//     final userLottoGetResponse = userLottoGetResponseFromJson(jsonString);

import 'dart:convert';

List<UserLottoGetResponse> userLottoGetResponseFromJson(String str) =>
    List<UserLottoGetResponse>.from(
      json.decode(str).map((x) => UserLottoGetResponse.fromJson(x)),
    );

String userLottoGetResponseToJson(List<UserLottoGetResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserLottoGetResponse {
  int id;
  String number;
  int price;
  String status;

  UserLottoGetResponse({
    required this.id,
    required this.number,
    required this.price,
    required this.status,
  });

  factory UserLottoGetResponse.fromJson(Map<String, dynamic> json) =>
      UserLottoGetResponse(
        id: json["id"],
        number: json["number"],
        price: json["price"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "number": number,
    "price": price,
    "status": status,
  };
}
