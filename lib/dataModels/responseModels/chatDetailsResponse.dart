

ChatDetailsList chatDetailsListFromJson(dynamic str) {
    // final jsonData = json.decode(str);
    return ChatDetailsList.fromJson(str);
}

class ChatDetailsList {
    List<MessageList> messageList;

    ChatDetailsList({
        this.messageList,
    });

    factory ChatDetailsList.fromJson(Map<String, dynamic> json) => new ChatDetailsList(
        messageList: new List<MessageList>.from(json["message_thread_list"].map((x) => MessageList.fromJson(x))),
    );

    @override
      String toString() {
        return "chatDetailsList: "+ messageList.toString();
      }
}

class MessageList {
    String id;
    String contentType;
    String content;
    String title;
    bool own;
    String time;

    MessageList({
        this.id,
        this.contentType,
        this.content,
        this.title,
        this.own,
        this.time,
    });

    factory MessageList.fromJson(Map<String, dynamic> json) => new MessageList(
        id: json["id"],
        contentType: json["content_type"],
        content: json["content"],
        title: json["title"],
        own: json["own"],
        time: json["time"],
    );

    @override
      String toString() {
        return '{id: $id, content_type: $contentType, content: $content, title: $title, own: $own, time: $time}';
      }
}
