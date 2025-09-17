// To parse this JSON data, do
//
//     final userLoginPostResponse = userLoginPostResponseFromJson(jsonString);

import 'dart:convert';

UserLoginPostResponse userLoginPostResponseFromJson(String str) => UserLoginPostResponse.fromJson(json.decode(str));

String userLoginPostResponseToJson(UserLoginPostResponse data) => json.encode(data.toJson());

class UserLoginPostResponse {
    String message;
    User user;
    Wallet wallet;

    UserLoginPostResponse({
        required this.message,
        required this.user,
        required this.wallet,
    });

    factory UserLoginPostResponse.fromJson(Map<String, dynamic> json) => UserLoginPostResponse(
        message: json["message"],
        user: User.fromJson(json["user"]),
        wallet: Wallet.fromJson(json["wallet"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "user": user.toJson(),
        "wallet": wallet.toJson(),
    };
}

class User {
    int id;
    String username;
    String email;
    String role;

    User({
        required this.id,
        required this.username,
        required this.email,
        required this.role,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "role": role,
    };
}

class Wallet {
    int id;
    int balance;

    Wallet({
        required this.id,
        required this.balance,
    });

    factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        balance: json["balance"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "balance": balance,
    };
}
