import 'dart:convert';

NotificationResponse notificationResponseFromJson(String str) {
    final jsonData = json.decode(str);
    return NotificationResponse.fromJson(jsonData);
}

String notificationResponseToJson(NotificationResponse data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class NotificationResponse {
    int threadId;
    String contentType;
    String senderName;
    String profilePicture;
    String title;
    int senderId;
    String content;

    NotificationResponse({
        this.threadId,
        this.contentType,
        this.senderName,
        this.profilePicture,
        this.title,
        this.senderId,
        this.content,
    });

    factory NotificationResponse.fromJson(Map<String, dynamic> json) => new NotificationResponse(
        threadId: json["thread_id"],
        contentType: json["content_type"],
        senderName: json["sender_name"],
        profilePicture: json["profile_picture"],
        title: json["title"],
        senderId: json["sender_id"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "thread_id": threadId,
        "content_type": contentType,
        "sender_name": senderName,
        "profile_picture": profilePicture,
        "title": title,
        "sender_id": senderId,
        "content": content,
    };

    @override
  String toString() {
    // TODO: implement toString
    return '{thread_id : $threadId}';
  }
}
