// To parse this JSON data, do
//
//     final userLoginPostRequest = userLoginPostRequestFromJson(jsonString);

import 'dart:convert';

UserLoginPostRequest userLoginPostRequestFromJson(String str) =>
    UserLoginPostRequest.fromJson(json.decode(str));

String userLoginPostRequestToJson(UserLoginPostRequest data) =>
    json.encode(data.toJson());

class UserLoginPostRequest {
  String username;
  String password;

  UserLoginPostRequest({required this.username, required this.password});

  factory UserLoginPostRequest.fromJson(Map<String, dynamic> json) =>
      UserLoginPostRequest(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {"username": username, "password": password};
}
