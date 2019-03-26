import 'package:flutter_chat_demo/webServices/webServices.dart';
import 'package:flutter_chat_demo/dataModels/sendModels/loginSendModel.dart';
import 'package:flutter_chat_demo/dataModels/responseModels/loginResponse.dart';
import 'package:flutter_chat_demo/dataModels/dbModel/user.dart';

abstract class LoginScreenContract {
  void onLoginSuccess(User response);
  void onLoginError(String errorTxt);
}

class LoginPresenter {
  LoginScreenContract _view;
  WebServices api = new WebServices();
  LoginPresenter(this._view);

  void login(String username, String password) {
    LoginSendModel sendModel =
        new LoginSendModel(username: username, password: password);
    print(sendModel.toString());
    // try {
      api.login(sendModel).then((LoginResponse response) {
        if (response.status == true) {
          User user = new User(
              name: response.name,
              id: response.id,
              pic: response.pic,
              position: response.position,
              fullName: response.fullName);
          _view.onLoginSuccess(user);
        } else {
          _view.onLoginError(response.msg);
        }
      });
    // } on Exception catch (error) {
      // _view.onLoginError(error.toString());
    // }
  }

  void checkLogin() {}
}
