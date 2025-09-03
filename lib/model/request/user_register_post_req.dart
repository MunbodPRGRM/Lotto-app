// To parse this JSON data, do
//
//     final UserRegisterPostRequest = userRegisterPostRequestFromJson(jsonString);

import 'dart:convert';

UserRegisterPostRequest userRegisterPostRequestFromJson(String str) =>
    UserRegisterPostRequest.fromJson(json.decode(str));

String userRegisterPostRequestToJson(UserRegisterPostRequest data) =>
    json.encode(data.toJson());

class UserRegisterPostRequest {
  String email;
  String password;
  String username;

  UserRegisterPostRequest({
    required this.email,
    required this.password,
    required this.username,
  });

  factory UserRegisterPostRequest.fromJson(Map<String, dynamic> json) =>
      UserRegisterPostRequest(
        email: json["email"],
        password: json["password"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "username": username,
  };
}
