import 'dart:convert';

import 'package:flutter_chat_demo/webServices/webServices.dart';
import 'package:flutter_chat_demo/dataModels/dbModel/user.dart';
import 'package:flutter_chat_demo/dataModels/sendModels/updateProfile.dart';

abstract class SettingScreenContact {
  void onLogOutSuccess();
  void onUpdateProfileSuccess(User user);
}

class SettingsPresenter {
  WebServices api = WebServices();
  SettingScreenContact _view;
  SettingsPresenter(this._view);

  void logout(String userid) {
    String logoutJson = json.encode({"user_id": userid});
    api.logout(logoutJson).then((bool value) {
      _view.onLogOutSuccess();
    });
  }

  void uploadProfilePicture(User user, String filePath, String fileName) {
    api.uploadFile(filePath, fileName).then((String a) {
      UpdateProfile updateProfile = UpdateProfile(
          uid: user.id,
          userName: user.name,
          userFullName: user.fullName,
          position: user.position,
          profilePicture: a);

      saveProfile(updateProfile);
    });
  }

  void saveProfile(UpdateProfile profile) {
    api.updateProfile(profile).then((bool value) {
      if (value) {
        User user = User(
            id: profile.uid,
            position: profile.position,
            fullName: profile.userFullName,
            name: profile.userName,
            pic: profile.profilePicture);
        _view.onUpdateProfileSuccess(user);
      }
    });
  }
}
