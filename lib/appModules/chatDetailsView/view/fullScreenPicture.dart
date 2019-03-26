import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
// import 'package:flutter/services.dart';

class FullScreenPicture extends StatelessWidget {
  final String photoUrl;

  FullScreenPicture({Key key, @required this.photoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: null,
      body: new Image.network(
        photoUrl,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
