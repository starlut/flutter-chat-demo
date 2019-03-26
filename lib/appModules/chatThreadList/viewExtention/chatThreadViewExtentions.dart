import 'package:flutter/material.dart';

import 'package:flutter_chat_demo/dataModels/responseModels/chatThreadListResponse.dart';
import 'package:flutter_chat_demo/dataModels/models/threadModel.dart';
import 'package:flutter_chat_demo/dataModels/dbModel/user.dart';
import 'package:flutter_chat_demo/appModules/chatDetailsView/view/chatDetailsView.dart';

class ChatThreadListCard extends StatelessWidget {
  final List<MessageThread> messageThreads;
  final User user;

  ChatThreadListCard({Key key, this.messageThreads, this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: messageThreads.length,
          padding: const EdgeInsets.only(top: 20.0),
          itemBuilder: (context, index) {
            return Card(
                clipBehavior: Clip.antiAlias,
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          '${messageThreads[index].lastMessage}',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                        subtitle: Text(
                          '${messageThreads[index].lastMessageTime}',
                          style: new TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        leading: Column(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              radius: 35.0,
                              child: Text(
                                'User',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        onTap: () => _onTapItem(context, messageThreads[index]),
                      ),
                    ],
                  ),
                ));
          }),
    );
  }

  void _onTapItem(BuildContext context, MessageThread post) {
    // Scaffold.of(context)
    // .showSnackBar(new SnackBar(content: new Text(post.toString())));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatDetailsScreen(
                threadModel: new ThreadModel(user.id, user.fullName, user.pic,
                    post.otherId, "otherName", "otherPic", post.threadId))));
  }
}

// import 'package:flutter/material.dart';

// import 'package:flutter_chat_demo/dataModels/responseModels/chatThreadListResponse.dart';
// import 'package:flutter_chat_demo/dataModels/models/threadModel.dart';
// import 'package:flutter_chat_demo/dataModels/dbModel/user.dart';
// import 'package:flutter_chat_demo/appModules/chatDetailsView/view/chatDetailsView.dart';

// class ChatThreadListCard extends StatelessWidget {
//   final List<MessageThread> messageThreads;
//   User user;

//   ChatThreadListCard({Key key, this.messageThreads, this.user}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: SafeArea(
//             child: Scaffold(
//       body: Container(
//           child: ListView.builder(
//               itemCount: messageThreads.length,
//               padding: const EdgeInsets.only(top: 20.0),
//               itemBuilder: (context, index) {
//                 return ChatCard(
//                   messageThread: messageThreads[index],
//                   user: user,
//                 );
//               })),
//     )));
//   }
// }

// class ChatCard extends StatelessWidget {
//   final MessageThread messageThread;
//   final User user;

//   ChatCard({Key key, this.messageThread, this.user}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         clipBehavior: Clip.antiAlias,
//         // TODO: Adjust card heights (103)
//         elevation: 2,
//         child: Container(
//           padding: EdgeInsets.all(8),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               ListTile(
//                 title: Text(
//                   '${messageThread.lastMessage}',
//                   style: TextStyle(
//                     fontSize: 22.0,
//                     color: Colors.deepOrangeAccent,
//                   ),
//                 ),
//                 subtitle: Text(
//                   '${messageThread.lastMessageTime}',
//                   style: new TextStyle(
//                     fontSize: 18.0,
//                     fontStyle: FontStyle.italic,
//                   ),
//                 ),
//                 leading: Column(
//                   children: <Widget>[
//                     CircleAvatar(
//                       backgroundColor: Colors.blueAccent,
//                       radius: 35.0,
//                       child: Text(
//                         'User',
//                         style: TextStyle(
//                           fontSize: 22.0,
//                           color: Colors.white,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 onTap: () => _onTapItem(context, messageThread),
//               ),
//               // TODO: Center items on the card (103)
//             ],
//           ),
//         ));
//   }

//   void _onTapItem(BuildContext context, MessageThread post) {
//     // Scaffold.of(context)
//         // .showSnackBar(new SnackBar(content: new Text(post.toString())));
//         Navigator.push(context, MaterialPageRoute(
//             builder: (context) => ChatDetailsScreen(threadModel: new ThreadModel(
//                   user.id,
//                   user.fullName,
//                   user.pic,
//                   "otherId",
//                   "otherName",
//                   "otherPic",
//                   post.threadId
//                 )
//               ),
//           ),);
//   }
// }
