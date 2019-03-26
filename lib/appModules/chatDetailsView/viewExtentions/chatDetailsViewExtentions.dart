import 'package:flutter/material.dart';

class ChatDetailsList extends StatefulWidget {
  final List<String> chatLists;

  ChatDetailsList({Key key, @required this.chatLists}) : super(key: key);

  _ChatDetailsListState createState() => _ChatDetailsListState(chatLists);
}

class _ChatDetailsListState extends State<ChatDetailsList> {
  List<String> chatLists;

  _ChatDetailsListState(this.chatLists);

  @override
  void initState() {
    super.initState();

    // _presenter.getChatList(threadModel.threadId);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8),
            clipBehavior: Clip.antiAlias,
            elevation: 2,
            child: Container(
              padding: EdgeInsets.all(8),
              child: builOtherChat(index),
            ),
          );
        },
    );
  }

  Widget buildOwnChat(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
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
                            "Name",
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                          FadeInImage.assetNetwork(
                            placeholder: 'animation/loading.gif',
                            image: 'https://picsum.photos/250?image=9',
                            // width: 150,
                            // height: 150,
                          ),
                          Text(
                            "8:33 am",
                            style: TextStyle(fontSize: 8),
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
                      image: 'https://picsum.photos/250?image=9',
                      width: 50,
                      height: 50,
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
                      image: 'https://picsum.photos/250?image=9',
                      width: 50,
                      height: 50,
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
                            "Name",
                            style: TextStyle(fontSize: 13),
                          ),
                          Text(
                            "content content content content content content content content content content content content content content content ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "8:33 am",
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
}
