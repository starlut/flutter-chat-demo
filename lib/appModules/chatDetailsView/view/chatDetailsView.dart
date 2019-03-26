import 'package:flutter/material.dart';
import 'dart:ui';
// import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_chat_demo/dataModels/models/threadModel.dart';
import 'package:flutter_chat_demo/appModules/chatDetailsView/presenter/chatDetailsPresenter.dart';
import 'package:flutter_chat_demo/const/valueConstants.dart';
import 'package:flutter_chat_demo/dataModels/responseModels/chatDetailsResponse.dart';
import 'package:flutter_chat_demo/appModules/chatDetailsView/view/fullScreenPicture.dart';
import 'package:flutter_chat_demo/dataModels/responseModels/userReponse.dart';
import 'package:flutter_chat_demo/dataModels/responseModels/notificationResponse.dart';

class ChatDetailsScreen extends StatefulWidget {
  final ThreadModel threadModel;

  ChatDetailsScreen({Key key, @required this.threadModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _ChatDetailsScreenState(threadModel);
  }
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen>
    implements ChatDetailsScreenContatct {
  BuildContext _ctx;
  ThreadModel threadModel;
  ChatDetailsPresenter _presenter;
  ScrollController _scrollController;
  TextEditingController textEditingController;
  final FocusNode focusNode = new FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _sendingMessage = false;
  NotificationResponse notificationResponse;

  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  List<MessageList> messageList;
  var isLoading = false;

  _ChatDetailsScreenState(this.threadModel);

  @override
  void initState() {
    super.initState();

    _presenter = new ChatDetailsPresenter(this);

    _scrollController = new ScrollController();
    textEditingController = new TextEditingController();
    focusNode.addListener(onFocusChange);

    isLoading = true;

    _presenter.getOtherUserInfo(threadModel.otherId);
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      // setState(() {
      //   isShowSticker = false;
      // });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Chat Demo App"),
      ),
      body: WillPopScope(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : buildChat(),
            Align(
              alignment: Alignment.bottomCenter,
              child: buildInput(),
            ),
          ],
        ),
        onWillPop: onBackPress,
      ),
    );
  }

  Future<bool> onBackPress() {
    return Future.value(true);
  }

  void _scrollToBottom() {
    // SchedulerBinding.instance.addPersistentFrameCallback((_) {
    //   _scrollController.animateTo(
    //     0,
    //     duration: const Duration(milliseconds: 300),
    //     curve: Curves.easeInOut,
    //   );
    // });
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.image),
                onPressed: selectFile,
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.add_circle),
                onPressed: selectFile,
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),
          // Edit text
          Flexible(
              child: Container(
            child: new ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 50.0,
              ),
              child: new Scrollbar(
                child: new SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  child: new TextField(
                    maxLines: null,
                    style: TextStyle(color: primaryColor, fontSize: 15.0),
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(color: greyColor),
                    ),
                    controller: textEditingController,
                  ),
                ),
              ),
            ),
          )),

          // Button send message
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => sendMessage(
                    textEditingController.text, CONTENT_TYPE_MESSAGE),
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50,
      decoration: new BoxDecoration(
          border:
              new Border(top: new BorderSide(color: greyColor2, width: 0.5)),
          color: Colors.white),
    );
  }

  void sendMessage(String content, String type) {
    if (content.length > 0) {
      content = content.trim();
      if (type == CONTENT_TYPE_MESSAGE) {
        MessageList sendMessage = new MessageList(
            contentType: type,
            content: content,
            title: "",
            own: true,
            time: DateTime.now().toString());
        messageList.insert(0, sendMessage);
      }
      setState(() {
        _sendingMessage = true;
        buildChat();
        _scrollToBottom();
        textEditingController.clear();
      });

      _presenter.sendMessage(
          content,
          CONTENT_TYPE_MESSAGE,
          int.tryParse(threadModel.ownId),
          int.tryParse(threadModel.otherId),
          int.tryParse(threadModel.threadId),
          "");
    }
  }

  void selectFile() async {
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
              onTap: () => () {
                    // String filePath = FilePicker.getFilePath(type: FileType.CAMERA, ).toString();
                    // print(filePath);
                  }),
          new ListTile(
            leading: new Icon(Icons.photo_album),
            title: new Text('Photos'),
            onTap: () => () {},
          ),
        ],
      );
    });
    // showBottomSheet<void>(context: _ctx,
    // builder: (BuildContext context) {
    //   return new Row(
    //     children: <Widget>[
    //       new FlatButton.icon(onPressed: () {}, icon: Icon(Icons.picture_in_picture), label: Text("gallery"),),
    //       new FlatButton.icon(onPressed: () {}, icon: Icon(Icons.camera), label: Text("camera"),),
    //     ],
    //   );
    // });
  }

  Widget buildChat() {
    return Flexible(
      child: ListView.builder(
        itemCount: messageList.length,
        controller: _scrollController,
        reverse: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {
              buldInfoDialog(index);
            },
            child: Card(
              margin: EdgeInsets.all(8),
              clipBehavior: Clip.antiAlias,
              elevation: 2,
              child: Container(
                padding: EdgeInsets.all(8),
                child: buildChatList(index),
              ),
            ),
          );
        },
      ),
    );
  }

  void buldInfoDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return SimpleDialog(
          title: Text("Message details"),
          titlePadding: const EdgeInsets.all(24.0),
          children: <Widget>[
            Material(
              child: FadeInImage.assetNetwork(
                height: 350.0,
                placeholder: 'animation/loading.gif',
                image: '$BASE_URL/' + threadModel.otherPic,
              ),
              borderRadius: BorderRadius.all(Radius.circular(45.0)),
              clipBehavior: Clip.hardEdge,
            ),
            Text("Sent from: " + threadModel.otherName),
            Text("Time: " + formatTime(messageList[index].time))
          ],
          contentPadding: const EdgeInsets.all(16.0),
        );
      },
    );
  }

  String formatTime(String time) {
    return time;
  }

  Widget buildChatList(index) {
    if (index == 0 && _sendingMessage) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (messageList[index].own) {
        return buildOwnChat(index);
      }
      return builOtherChat(index);
    }
  }

  Widget buildOwnChat(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            threadModel.ownName,
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                          buildChatBody(index),
                          Text(
                            messageList[index].time,
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    FadeInImage.assetNetwork(
                      placeholder: 'animation/loading.gif',
                      image: BASE_URL + threadModel.ownPic,
                      width: 75.0,
                      height: 75.0,
                    ),
                  ],
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Column builOtherChat(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeInImage.assetNetwork(
                      placeholder: 'animation/loading.gif',
                      image: BASE_URL + threadModel.otherPic,
                      width: 75.0,
                      height: 75.0,
                    ),
                  ],
                ),
                Expanded(
                    child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            threadModel.otherName,
                            style: TextStyle(fontSize: 13),
                          ),
                          buildChatBody(index),
                          Text(
                            messageList[index].time,
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    )
                  ],
                ))
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget buildChatBody(int index) {
    if (messageList[index].contentType == CONTENT_TYPE_MESSAGE) {
      return Text(
        messageList[index].content,
        style: TextStyle(fontSize: 18),
      );
    } else if (messageList[index].contentType == CONTENT_TYPE_PICTURE) {
      String pictureUrl = BASE_URL + '/' + messageList[index].content;
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FullScreenPicture(
                        photoUrl: pictureUrl,
                      )));
        },
        child: FadeInImage.assetNetwork(
          placeholder: 'animation/loading.gif',
          image: '$BASE_URL/' + messageList[index].content,
        ),
      );
    } else if (messageList[index].contentType == CONTENT_TYPE_FILE) {
      return Column(
        children: <Widget>[
          Text(
            messageList[index].title,
            style: TextStyle(fontSize: 18),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text("Download"),
          )
        ],
      );
    }
  }

  @override
  void onDataFetchedSuccess(List<MessageList> asdf) {
    messageList = asdf;

    setState(() {
      isLoading = false;
    });

    // _scrollToBottom();
  }

  @override
  void onDateFetchedError(String errorText) {}

  @override
  void onMessageSendStatus(bool status) {
    if (status) {
      //do the last message pull api call
      _scaffoldKey.currentState
          .showSnackBar(new SnackBar(content: new Text("Message sent")));
    } else {
      _scaffoldKey.currentState
          .showSnackBar(new SnackBar(content: new Text("Message sent error")));
    }
    setState(() {
      _sendingMessage = false;
    });
  }

  @override
  void onUserDataFetched(UserInfo userinfo) {
    threadModel.otherId = userinfo.uid;
    threadModel.otherName = userinfo.fullName;
    threadModel.otherPic = userinfo.picture;
    _presenter.getChatList(threadModel.threadId, threadModel.ownId);
  }

  @override
  void onLastMessageDataFetched(List<MessageList> list) {
    print(list);
    setState(() {
      messageList.insertAll(0, list);
      buildChat();
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
