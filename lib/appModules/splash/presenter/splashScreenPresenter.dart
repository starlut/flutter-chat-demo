import 'package:flutter_chat_demo/webServices/webServices.dart';
import 'package:flutter_chat_demo/dataModels/sendModels/firebaseTokenStore.dart';

abstract class SplashScreenContact {
  void onTokenStoreSuccess();
  void onTokenStoreFailed();
}

class SplashPresenter {
  SplashScreenContact _view;
  WebServices api = new WebServices();
  SplashPresenter(this._view);

  void storeToken(String userId, String token) {
    TokenStoreSendModel sendModel =
        new TokenStoreSendModel(token: token, userId: userId);

    api.storeToken(sendModel).then((bool isSuccess) {
      if (isSuccess) {
        _view.onTokenStoreSuccess();
      }
    });
  }
}
