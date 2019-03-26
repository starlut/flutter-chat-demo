import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';

import 'package:flutter_chat_demo/dataModels/dbModel/user.dart';
import 'package:flutter_chat_demo/db/dbHelper.dart';
import 'package:flutter_chat_demo/const/valueConstants.dart';
import 'package:flutter_chat_demo/appModules/settings/presenter/settingsPresenter.dart';
import 'dart:io';

class Settings extends StatefulWidget {
  @override
  State createState() => new SettingsScreenState();
}

class SettingsScreenState extends State<Settings>
    implements SettingScreenContact {
  TextEditingController controllerFullName;
  TextEditingController controllerAboutMe;
  SettingsPresenter presenter;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PersistentBottomSheetController bottomController;
  BuildContext context;

  bool isLocal = false;

  User _user;
  String localFilePath;
  bool isLoading = false;

  final FocusNode focusNodeNickname = new FocusNode();
  final FocusNode focusNodeAboutMe = new FocusNode();

  @override
  void initState() {
    super.initState();
    readLocal();
    controllerAboutMe = new TextEditingController();
    controllerFullName = new TextEditingController();
    presenter = SettingsPresenter(this);
  }

  void readLocal() async {
    setState(() {
      isLoading = true;
    });
    var db = new DatabaseHelper();
    db.getUser().then((dynamic user) {
      _user = user;
      setState(() {
        controllerFullName.text = _user.fullName;
        controllerAboutMe.text = _user.name;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Avatar
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Material(
                                child: isLocal
                                    ? Image.file(new File(localFilePath))
                                    : FadeInImage.assetNetwork(
                                        placeholder: 'animation/loading.gif',
                                        image: '$BASE_URL/' + _user.pic,
                                      ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45.0)),
                                clipBehavior: Clip.hardEdge,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: primaryColor.withOpacity(0.5),
                                  ),
                                  onPressed: selectPictureBS,
                                  splashColor: Colors.transparent,
                                  highlightColor: greyColor,
                                  iconSize: 30.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        width: double.infinity,
                        margin: EdgeInsets.all(20.0),
                      ),

                // Input
                Column(
                  children: <Widget>[
                    // Username
                    Container(
                      child: Text(
                        'Full Name',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      ),
                      margin:
                          EdgeInsets.only(left: 10.0, bottom: 5.0, top: 10.0),
                    ),
                    Container(
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(primaryColor: primaryColor),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: new EdgeInsets.all(5.0),
                            hintStyle: TextStyle(color: greyColor),
                          ),
                          controller: controllerFullName,
                          onChanged: (value) {
                            // nickname = value;
                          },
                          focusNode: focusNodeNickname,
                        ),
                      ),
                      margin: EdgeInsets.only(left: 30.0, right: 30.0),
                    ),

                    // About me
                    Container(
                      child: Text(
                        'Email',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      ),
                      margin:
                          EdgeInsets.only(left: 10.0, top: 30.0, bottom: 5.0),
                    ),
                    Container(
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(primaryColor: primaryColor),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Fun, like travel and play PES...',
                            contentPadding: EdgeInsets.all(5.0),
                            hintStyle: TextStyle(color: greyColor),
                          ),
                          controller: controllerAboutMe,
                          onChanged: (value) {
                            controllerFullName.text = value;
                          },
                          focusNode: focusNodeAboutMe,
                        ),
                      ),
                      margin: EdgeInsets.only(left: 30.0, right: 30.0),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),

                // Button
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: updateProfile,
                        child: Text(
                          'UPDATE',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        color: primaryColor,
                        highlightColor: new Color(0xff8d93a0),
                        splashColor: Colors.transparent,
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50),
                        child: FlatButton(
                          onPressed: logout,
                          child: Text(
                            'Logout',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          color: primaryColor,
                          highlightColor: new Color(0xff8d93a0),
                          splashColor: Colors.transparent,
                          textColor: Colors.white,
                          padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
          ),

          // Loading
          Positioned(
            child: isLoading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(themeColor)),
                    ),
                    color: Colors.white.withOpacity(0.8),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  void selectPictureBS() {
    bottomController =
        _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
      return new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Text(
                'Please select an action to get picture',
                textAlign: TextAlign.center,
              )),
          new ListTile(
            leading: new Icon(Icons.camera),
            title: new Text('Camera'),
            onTap: selectCamera,
          ),
          new ListTile(
            leading: new Icon(Icons.photo_album),
            title: new Text('Photos'),
            onTap: selectPhoto,
          ),
        ],
      );
    });
    bottomController.close();
  }

  void selectCamera() async {
    // await FilePicker.getFilePath(
    //   type: FileType.CAMERA,
    // ).then((value) {
    //   setState(() {
    //    localFilePath = value;
    //    isLocal = true;
    //    build(context);
    //   });
    // });
  }

  void selectPhoto() async {
    await FilePicker.getFilePath(
      type: FileType.IMAGE,
    ).then((value) {
      setState(() {
       localFilePath = value;
       isLocal = true;
       build(context);
      });
    });
  }

  void updateProfile() {
    _user.fullName = controllerFullName.text;
    if(isLocal){
      int time = DateTime.now().millisecondsSinceEpoch;
      String fileName = '$time'  + _user.id+ extension(localFilePath);
      print(fileName);
      presenter.uploadProfilePicture(_user, localFilePath, fileName);
    }

  }

  void logout() {
    presenter.logout(_user.id);
  }

  @override
  void onLogOutSuccess() {
    var db = DatabaseHelper();
    db.deleteUsers().then((int i) {
      Navigator.of(context).pushReplacementNamed('/');
    });
  }

  @override
  void onUpdateProfileSuccess(User user) {
    var db = new DatabaseHelper();
    db.saveUser(user).then((int value) {
      readLocal();
    });
  }
}
