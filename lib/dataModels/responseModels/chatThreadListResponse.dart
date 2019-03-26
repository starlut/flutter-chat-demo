import 'dart:convert';

ChatThreadList chatThreadListFromJson(dynamic str) {
  // final jsonData = json.decode(str);
  return ChatThreadList.fromJson(str);
}

String chatThreadListToJson(ChatThreadList data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class ChatThreadList {
  List<MessageThread> messageThreadList;

  ChatThreadList({
    this.messageThreadList,
  });

  factory ChatThreadList.fromJson(Map<String, dynamic> json) =>
      new ChatThreadList(
        messageThreadList: new List<MessageThread>.from(
            json["message_thread_list"]
                .map((x) => MessageThread.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message_thread_list":
            new List<dynamic>.from(messageThreadList.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return "message_thread_list : " + messageThreadList.toString();
  }
}

class MessageThread {
  String threadId;
  String otherId;
  String lastMessage;
  String lastMessageTime;
  String isUnread;

  MessageThread({
    this.threadId,
    this.otherId,
    this.lastMessage,
    this.lastMessageTime,
    this.isUnread,
  });

  factory MessageThread.fromJson(Map<String, dynamic> json) =>
      new MessageThread(
        threadId: json["thread_id"],
        otherId: json["other_id"],
        lastMessage: json["last_message"],
        lastMessageTime: json["last_message_time"],
        isUnread: json["isUnread"],
      );

  Map<String, dynamic> toJson() => {
        "thread_id": threadId,
        "other_id": otherId,
        "last_message": lastMessage,
        "last_message_time": lastMessageTime,
        "isUnread": isUnread,
      };

  MessageThread.map(dynamic json) {
    threadId = json["thread_id"];
    otherId = json["other_id"];
    lastMessage = json["last_message"];
    lastMessageTime = json["last_message_time"];
    isUnread = json["isUnread"];
  }

  @override
  String toString() {
    return "{ thread_id: $threadId, other_id : $otherId, last_message: $lastMessage, lat_message_time: $lastMessageTime," +
        " isUnread : $isUnread}";
  }
}
