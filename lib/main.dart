import 'package:flutter/material.dart';
import 'package:programmingfactsandjokes/src/app.dart';

void main() {
//  var app = App();
  // No MaterialLocalizations found.
  // App widgets require MaterialLocalizations to be provided by a Localizations widget ancestor.

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Text',
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: App(),
    );
  }
}
