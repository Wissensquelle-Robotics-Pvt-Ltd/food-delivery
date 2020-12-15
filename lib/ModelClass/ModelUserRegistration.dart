import 'dart:convert';

UserRegistration userRegistrationFromJson(String str) => UserRegistration.fromJson(json.decode(str));

String userRegistrationToJson(UserRegistration data) => json.encode(data.toJson());

class UserRegistration {
    int code;
    String message;
    ResResult resResult;

    UserRegistration({
        this.code,
        this.message,
        this.resResult,
    });

    factory UserRegistration.fromJson(Map<String, dynamic> json) => UserRegistration(
        code: json["code"]??"",
        message: json["message"??""],
        resResult: ResResult.fromJson(json["result"] ?? []),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "resResult": resResult.toJson(),
    };
}

class ResResult {
    String userId;
    String name;
    String email;
    String profileImage;
    String phone;
    String address;

    ResResult({
        this.userId,
        this.name,
        this.email,
        this.profileImage,
        this.phone,
        this.address,
    });

    factory ResResult.fromJson(Map<String, dynamic> json) => ResResult(
        userId: json["user_id"]??"",
        name: json["name"]??"",
        email: json["email"]??"",
        profileImage: json["profile_image"]??"",
        phone: json["phone"]??"",
        address: json["address"]??"",
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "email": email,
        "profile_image": profileImage,
        "phone": phone,
        "address": address,
    };
}