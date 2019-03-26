import 'dart:convert';

TokenStoreSendModel tokenSendModelFromJson(String str) {
    final jsonData = json.decode(str);
    return TokenStoreSendModel.fromJson(jsonData);
}

String tokenSendModelToJson(TokenStoreSendModel data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class TokenStoreSendModel {
    String token;
    String userId;

    TokenStoreSendModel({
        this.token,
        this.userId,
    });

    factory TokenStoreSendModel.fromJson(Map<String, dynamic> json) => new TokenStoreSendModel(
        token: json["token"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user_id": userId,
    };
}
