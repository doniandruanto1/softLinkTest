import 'package:flutter/material.dart';

import 'pages/login.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    title: "shopLink_test",
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Login();
  }
}