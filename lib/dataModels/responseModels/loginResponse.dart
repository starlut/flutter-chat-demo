import 'dart:convert';

LoginResponse loginResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return LoginResponse.fromJson(jsonData);
}

List<LoginResponse> loginFromJson(String str) {
    final jsonData = json.decode(str);
    return new List<LoginResponse>.from(jsonData.map((x) => LoginResponse.fromJson(x)));
}

String loginResponseToJson(LoginResponse data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class LoginResponse {
  bool status;
  String msg;
  String name;
  String id;
  String pic;
  String position;
  String fullName;

  LoginResponse({
    this.status,
    this.msg,
    this.name,
    this.id,
    this.pic,
    this.position,
    this.fullName,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      new LoginResponse(
        status: json["status"],
        msg: json["msg"],
        name: json["name"],
        id: json["id"],
        pic: json["pic"],
        position: json["position"],
        fullName: json["full_name"],
      );

  LoginResponse.map(dynamic json) {
    status = json["status"];
    msg = json["msg"];
    name = json["name"];
    id = json["id"];
    pic = json["pic"];
    position = json["position"];
    fullName = json["full_name"];
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "name": name,
        "id": id,
        "pic": pic,
        "position": position,
        "full_name": fullName,
      };

  @override
  String toString() {
    // TODO: implement toString
    return 'loginresponse $status, $msg, $name, $id, $pic, $position, $fullName';
  }
}
