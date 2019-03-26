import 'dart:convert';

NewMessage newMessageFromJson(String str) {
    final jsonData = json.decode(str);
    return NewMessage.fromJson(jsonData);
}

String newMessageToJson(NewMessage data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class NewMessage {
    int senderId;
    int receiverId;
    String content;
    String contentType;
    String title;
    int threadId;

    NewMessage({
        this.senderId,
        this.receiverId,
        this.content,
        this.contentType,
        this.title,
        this.threadId,
    });

    factory NewMessage.fromJson(Map<String, dynamic> json) => new NewMessage(
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        content: json["content"],
        contentType: json["content_type"],
        title: json["title"],
        threadId: json["thread_id"],
    );

    Map<String, dynamic> toJson() => {
        "sender_id": senderId,
        "receiver_id": receiverId,
        "content": content,
        "content_type": contentType,
        "title": title,
        "thread_id": threadId,
    };
}