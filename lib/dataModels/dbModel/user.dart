import 'dart:convert';

User userResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromJson(jsonData);
}

String userResponseToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class User {
  String name;
  String id;
  String pic;
  String position;
  String fullName;

  User({
    this.name,
    this.id,
    this.pic,
    this.position,
    this.fullName,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
        name: json["user_name"],
        id: json["user_id"],
        pic: json["user_pic"],
        position: json["position"],
        fullName: json["user_full_name"],
      );

  Map<String, dynamic> toJson() => {
        "user_name": name,
        "user_id": id,
        "user_pic": pic,
        "user_position": position,
        "user_full_name": fullName,
      };

  User.fromMap(Map<String, dynamic> map) {
    id = map['user_id'];
    name = map['user_name'];
    pic = map['user_pic'];
    position = map['user_position'];
    fullName = map['user_full_name'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'xyz user{userid: $id, name: $name, pic: $pic, position: $position}';
  }
}
