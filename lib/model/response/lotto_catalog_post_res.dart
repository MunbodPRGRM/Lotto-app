// To parse this JSON data, do
//
//     final lottoCatalogPostResponse = lottoCatalogPostResponseFromJson(jsonString);

import 'dart:convert';

List<LottoCatalogPostResponse> lottoCatalogPostResponseFromJson(String str) => List<LottoCatalogPostResponse>.from(json.decode(str).map((x) => LottoCatalogPostResponse.fromJson(x)));

String lottoCatalogPostResponseToJson(List<LottoCatalogPostResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LottoCatalogPostResponse {
    int id;
    String number;
    int price;
    String status;
    int? userId;

    LottoCatalogPostResponse({
        required this.id,
        required this.number,
        required this.price,
        required this.status,
        required this.userId,
    });

    factory LottoCatalogPostResponse.fromJson(Map<String, dynamic> json) => LottoCatalogPostResponse(
        id: json["id"],
        number: json["number"],
        price: json["price"],
        status: json["status"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "price": price,
        "status": status,
        "user_id": userId,
    };
}
