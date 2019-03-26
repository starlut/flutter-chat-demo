import 'dart:convert';

LoginSendModel loginSendModelFromJson(String str) {
  final jsonData = json.decode(str);
  return LoginSendModel.fromJson(jsonData);
}

String loginSendModelToJson(LoginSendModel data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class LoginSendModel {
  String username;
  String password;

  LoginSendModel({
    this.username,
    this.password,
  });

  factory LoginSendModel.fromJson(Map<String, dynamic> json) =>
      new LoginSendModel(
          username: json["username"], password: json["password"]);

  Map<String, dynamic> toJson() => {"username": username, "password": password};
}
