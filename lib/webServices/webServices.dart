import 'dart:async';

import 'package:flutter_chat_demo/utils/networkUtils.dart';
import 'package:flutter_chat_demo/dataModels/responseModels/loginResponse.dart';
import 'package:flutter_chat_demo/dataModels/sendModels/loginSendModel.dart';
import 'package:flutter_chat_demo/dataModels/responseModels/chatThreadListResponse.dart';
import 'package:flutter_chat_demo/dataModels/responseModels/chatDetailsResponse.dart';
import 'package:flutter_chat_demo/dataModels/responseModels/userReponse.dart';
import 'package:flutter_chat_demo/dataModels/sendModels/newMessage.dart';
import 'package:flutter_chat_demo/dataModels/sendModels/firebaseTokenStore.dart';
import 'package:flutter_chat_demo/dataModels/sendModels/updateProfile.dart';

class WebServices {
  NetworkUtil _netUtil = new NetworkUtil();
  static final LOGIN_URL = "login.php";
  static final THREAD_URL = 'get_all_message_thread.php';
  static final CHAT_LIST_URL = 'get_all_message.php';
  static final SEND_MESSAGE_URL = 'send_message_v2.php';
  static final STORE_FIREBASE_TOKEN = 'firebase_token_store.php';
  static final USER_INFO_URL = 'get_all_user_info.php';
  static final LOGOUT_URL = 'logout.php';
  static final GET_LAST_MESSAGE_URL = "get_last_message.php";
  static final UPLOAD_FILE_URL = 'upload_file.php';
  static final UPDATE_PROFILE_URL = 'update_profile.php';

  Future<LoginResponse> login(LoginSendModel sendModel) {
    return _netUtil
        .post(LOGIN_URL, body: loginSendModelToJson(sendModel))
        .then((dynamic res) {
      print(res.toString());
      return new LoginResponse.map(res[0]);
    });
  }

  Future<ChatThreadList> getChatThreads(String userId) {
    String path = '$THREAD_URL?uid=$userId';
    return _netUtil
        .get(path)
        .then((dynamic res) {
      print(res.toString());
      return ChatThreadList.fromJson(res);
    });
  }

  Future<ChatDetailsList> getChatDetails(String userId, String threadId) {
    String path = '$CHAT_LIST_URL?thread_id=$threadId&uid=$userId';
    return _netUtil
        .get(path)
        .then((dynamic res) {
      print(res.toString());
      return chatDetailsListFromJson(res);
    });
  }

  Future<bool> sendNewMessage(NewMessage newMessage){
    String path = '$SEND_MESSAGE_URL';
    return _netUtil
      .postWithoutJsonResponse(path, body: newMessageToJson(newMessage))
      .then((dynamic res){
        return true;
      });
  }

  Future<bool> storeToken(TokenStoreSendModel sendModel){
    String path = '$STORE_FIREBASE_TOKEN';
    return _netUtil
      .postWithoutJsonResponse(path, body: tokenSendModelToJson(sendModel))
      .then((dynamic res){
        return true;
      });
  }

  Future<UserResponse> getUserInfo(String uid, String api){
    String path = '$USER_INFO_URL?api=$api&uid=$uid';
    return _netUtil
        .get(path)
        .then((dynamic res) {
      print(res.toString());
      return UserResponseFromJson(res);
    });
  }

  Future<bool> logout(String json){
    String path = '$LOGOUT_URL';
    return _netUtil
      .postWithoutJsonResponse(path, body: json)
      .then((dynamic res){
        return true;
      });
  }

  Future<ChatDetailsList> getLastMessage(String uid, String threadId){
    String path = '$GET_LAST_MESSAGE_URL?thread_id=$threadId&uid=$uid';
    return _netUtil
        .get(path)
        .then((dynamic res) {
      print(res.toString());
      return chatDetailsListFromJson(res);
    });
  }

  Future<String> uploadFile(String pathToFile, String fileName){
    String path = UPLOAD_FILE_URL;
    return _netUtil.uploadPicture(path, pathToFile, fileName).then((dynamic res){
      String fileLocation = res['file_location'];
      return fileLocation;
    });
  }

  Future<bool> updateProfile(UpdateProfile updateProfile){
    String path = UPDATE_PROFILE_URL;
    return _netUtil.post(path, body: updateProfile.toJson()).then((dynamic res){
      return true;
    });
  }
}
