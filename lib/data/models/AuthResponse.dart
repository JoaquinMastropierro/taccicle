// To parse this JSON data, do
//
//     final authResponses = authResponsesFromJson(jsonString);

import 'dart:convert';

import 'package:taccicle/domain/entities/User.dart';

AuthResponses authResponsesFromJson(String str) => AuthResponses.fromJson(json.decode(str));


class AuthResponses {
    AuthResponses({
        required this.token,
        required this.user,
    });

    String token;
    User user;

    factory AuthResponses.fromJson(Map<String, dynamic> json) => AuthResponses(
        token: json["token"],
        user: User.fromJson(json["user"]),
    );

  
}

