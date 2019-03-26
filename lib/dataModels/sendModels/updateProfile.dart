import 'dart:convert';

UpdateProfile updateProfileFromJson(String str) {
    final jsonData = json.decode(str);
    return UpdateProfile.fromJson(jsonData);
}

String updateProfileToJson(UpdateProfile data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class UpdateProfile {
    String uid;
    String userName;
    String userFullName;
    String profilePicture;
    String position;

    UpdateProfile({
        this.uid,
        this.userName,
        this.userFullName,
        this.profilePicture,
        this.position,
    });

    factory UpdateProfile.fromJson(Map<String, dynamic> json) => new UpdateProfile(
        uid: json["uid"],
        userName: json["user_name"],
        userFullName: json["user_full_name"],
        profilePicture: json["profile_picture"],
        position: json["position"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "user_name": userName,
        "user_full_name": userFullName,
        "profile_picture": profilePicture,
        "position": position,
    };
}
