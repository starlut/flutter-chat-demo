import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/appModules/login/view/loginScreen.dart';
import 'package:flutter_chat_demo/appModules/chatThreadList/view/chatThreadListView.dart';
import 'package:flutter_chat_demo/appModules/settings/settingsView.dart';
import 'package:flutter_chat_demo/appModules/splash/view/splashScreen.dart';

void main() {
  runApp(MaterialApp(
    // Start the app with the "/" named route. In our case, the app will start
    // on the FirstScreen Widget
    initialRoute: '/',
    routes: {
      // When we navigate to the "/" route, build the FirstScreen Widget
      '/': (context) => SplashScreen(),
        // When we navigate to the "/second" route, build the SecondScreen Widget
      '/login': (context) => LoginScreen(),
      '/home': (context) => ChatThreadScreen(),
      '/settings': (context) => Settings(),
    }
      // home: SplashScreen(),
  ));
}
