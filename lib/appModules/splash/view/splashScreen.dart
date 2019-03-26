import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter_chat_demo/db/dbHelper.dart';
import 'package:flutter_chat_demo/appModules/chatThreadList/view/chatThreadListView.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_chat_demo/dataModels/dbModel/user.dart';
import 'package:flutter_chat_demo/appModules/splash/presenter/splashScreenPresenter.dart';
import 'package:flutter_chat_demo/dataModels/responseModels/notificationResponse.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin
    implements SplashScreenContact {
  AnimationController _animationController;
  Animation<double> _animation;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  User _user;
  SplashPresenter _presenter;
  NotificationResponse notificationResponse;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _presenter = new SplashPresenter(this);

    _animation.addListener(() => this.setState(() {}));
    _animationController.forward();

    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

    var db = new DatabaseHelper();
    db.isLoggedIn().then((dynamic isLoggedin) {
      if (isLoggedin) {
        // Navigator.pushReplacementNamed(context, "/home");
        firebaseMessaging.getToken().then((token) {
          print(token);
          _getUserData(token);
        });
      } else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Container(
          //     child: Image.asset(
          //   'images/splashscreenbg.png',
          //   fit: BoxFit.cover,
          // )),
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlutterLogo(
                      size: _animation.value * 100.0,
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Text(
                      "MingUp",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }

  void _getUserData(String token) {
    var db = new DatabaseHelper();
    db.getUser().then((dynamic user) {
      _user = user;

      _presenter.storeToken(_user.id, token);
    });
  }

  @override
  void onTokenStoreSuccess() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ChatThreadScreen()));
  }

  @override
  void onTokenStoreFailed() {}
}
