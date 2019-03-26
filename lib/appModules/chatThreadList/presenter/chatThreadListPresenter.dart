import 'package:flutter_chat_demo/webServices/webServices.dart';
import 'package:flutter_chat_demo/dataModels/responseModels/chatThreadListResponse.dart';

abstract class ChatThreadScreenContact {
  void onDataFetchedSuccess(ChatThreadList list);
  void onDateFetchedError(String errorTxt);
}

class ChatThreadPresenter {
  ChatThreadScreenContact _view;
  WebServices api = new WebServices();
  ChatThreadPresenter(this._view);

  void getChatList(String userId) {

    api.getChatThreads(userId).then((ChatThreadList value) {
      _view.onDataFetchedSuccess(value);
    });
  }
}
