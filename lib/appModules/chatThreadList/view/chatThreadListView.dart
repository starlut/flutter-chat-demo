import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_chat_demo/appModules/chatThreadList/viewExtention/chatThreadViewExtentions.dart';
import 'package:flutter_chat_demo/appModules/chatThreadList/presenter/chatThreadListPresenter.dart';
import 'package:flutter_chat_demo/dataModels/dbModel/user.dart';
import 'package:flutter_chat_demo/db/dbHelper.dart';
import 'package:flutter_chat_demo/dataModels/responseModels/chatThreadListResponse.dart';
import 'package:flutter_chat_demo/appModules/settings/settingsView.dart';
import 'package:flutter_chat_demo/appModules/chatDetailsView/view/chatDetailsView.dart';
import 'package:flutter_chat_demo/dataModels/models/threadModel.dart';
import 'package:flutter_chat_demo/dataModels/responseModels/notificationResponse.dart';

class ChatThreadScreen extends StatefulWidget {
  @override
  _ChatThreadState createState() => _ChatThreadState();
}

class _ChatThreadState extends State<ChatThreadScreen>
    implements ChatThreadScreenContact {
  ChatThreadPresenter _presenter;
  BuildContext _context;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  User _user;
  List<MessageThread> _messageThreadLists;
  var isLoading = false;
  bool firebaseMessage = false;
  NotificationResponse notificationResponse;

  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  _ChatThreadState() {
    _presenter = new ChatThreadPresenter(this);
  }

  @override
  void initState() {
    super.initState();

    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Thread App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings()));
            },
          )
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : new ChatThreadListCard(
              messageThreads: _messageThreadLists,
              user: _user,
            ),
    );
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  void onDateFetchedError(String errorTxt) {
    _showSnackBar(errorTxt);
  }

  @override
  void onDataFetchedSuccess(ChatThreadList response) async {
    this._messageThreadLists = response.messageThreadList;
    setState(() {
      isLoading = false;
    });
  }

  void _getUserData() {
    print("getUserData");
    if (!firebaseMessage) {
      setState(() {
        isLoading = true;
      });
    }
    var db = new DatabaseHelper();
    db.getUser().then((dynamic user) {
      _user = user;
      print('$firebaseMessage');
      firebaseMessage ? messageHandle() : _presenter.getChatList(_user.id);
    });
  }

  void firebaseMessageRec() {}

  void messageHandle() {
    print("messagehandle");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatDetailsScreen(
                threadModel: new ThreadModel(
                    _user.id,
                    _user.fullName,
                    _user.pic,
                    String.fromCharCode(notificationResponse.senderId),
                    notificationResponse.senderName,
                    notificationResponse.profilePicture,
                    String.fromCharCode(notificationResponse.threadId)))));
  }
}
