import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'flashScreen.dart';

void main() {
  runApp(MyApp());
}
// dung package google trainslate de dich ngon ngu nguoi dung
// dung package smartrefresh de keo tha refresh

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: FlashScreen(),
    );
  }
}

