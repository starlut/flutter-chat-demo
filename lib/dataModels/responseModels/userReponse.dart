UserResponse UserResponseFromJson(dynamic str) {
  return UserResponse.fromJson(str);
}

class UserResponse {
  List<UserInfo> userInfo;

  UserResponse({
    this.userInfo,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => new UserResponse(
        userInfo: new List<UserInfo>.from(
            json["user_info"].map((x) => UserInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_info": new List<dynamic>.from(userInfo.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return "user_info : " + userInfo.toString();
  }
}

class UserInfo {
  String uid;
  String username;
  String fullName;
  String picture;
  String position;
  String lastlogin;

  UserInfo({
    this.uid,
    this.username,
    this.fullName,
    this.picture,
    this.position,
    this.lastlogin,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => new UserInfo(
        uid: json["uid"],
        username: json["username"],
        fullName: json["full_name"],
        picture: json["picture"],
        position: json["position"],
        lastlogin: json["lastlogin"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "full_name": fullName,
        "picture": picture,
        "position": position,
        "lastlogin": lastlogin,
      };

  @override
  String toString() {
    return "{ uid: $uid, username : $username, full_name: $fullName, picture: $picture," +
        " position : $position, lastlogin: $lastlogin}";
  }
}
