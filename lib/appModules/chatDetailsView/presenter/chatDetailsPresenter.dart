import 'package:flutter_chat_demo/webServices/webServices.dart';
import 'package:flutter_chat_demo/dataModels/responseModels/chatDetailsResponse.dart';
import 'package:flutter_chat_demo/dataModels/sendModels/newMessage.dart';
import 'package:flutter_chat_demo/dataModels/responseModels/userReponse.dart';

abstract class ChatDetailsScreenContatct {
  void onDataFetchedSuccess(List<MessageList> list);
  void onDateFetchedError(String errorTxt);
  void onMessageSendStatus(bool isSent);
  void onUserDataFetched(UserInfo userinfo);
  void onLastMessageDataFetched(List<MessageList> list);
}

class ChatDetailsPresenter {
  ChatDetailsScreenContatct _view;
  WebServices api = new WebServices();
  ChatDetailsPresenter(this._view);

  void getChatList(String threadId, String userId) {

    api.getChatDetails(userId, threadId).then((ChatDetailsList value) {
      print(value.toString());
      _view.onDataFetchedSuccess(value.messageList);
    });
  }

  void sendMessage(String content, String contentType, int senderId, int receiverId, int threadId, String title){
    NewMessage newMessage = new NewMessage(senderId: senderId, receiverId: receiverId, content: content, contentType: contentType, threadId: threadId);

    api.sendNewMessage(newMessage).then((bool value){
      _view.onMessageSendStatus(value);
    });
  }

  void getOtherUserInfo(String uid){
    api.getUserInfo(uid, "SINGLE").then((UserResponse userResponse){
      _view.onUserDataFetched(userResponse.userInfo[0]);
    });
  }

  void getLastMessage(String threadId, String uid){
    api.getLastMessage(uid, threadId).then((ChatDetailsList value){
      _view.onLastMessageDataFetched(value.messageList);
    });
  }
}
