import 'dart:convert';

import 'package:product/BlocClass/CommonBlocClass/BaseMode.dart';



UserLogin userLoginFromJson(String str) => UserLogin.fromJson(json.decode(str));

String userLoginToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin extends BaseModel {
    int code;
    String message;
    Result result;

    UserLogin({
        this.code,
        this.message,
        this.result,
    });

    factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(

        code: json["code"],
        message: json["message"],
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "result": result.toJson(),
    };
}

class Result {
    String userId = "";
    String name = "";
    String email = "";
    String profileImage = "";
    String phone = "";
    String address = "";

    Result({
        this.userId = "",
        this.name = "",
        this.email = "",
        this.profileImage = "",
        this.phone = "",
        this.address = "",
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        userId: json["user_id"]??"",
        name: json["name"]??"",
        email: json["email"]??"",
        profileImage: json["profile_image"]??"",
        phone: json["phone"]??"",
        address: json["address"]??"",
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId ?? "",
        "name": name ?? "",
        "email": email ?? "",
        "profile_image": profileImage ?? "",
        "phone": phone ?? "",
        "address": address ?? "",
    };
}