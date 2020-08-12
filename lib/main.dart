import 'package:flutter/material.dart';
import 'package:shoplink_test/pages/login/container.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    title: "shopLink_testing",
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TabController tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Login();    
  }
}
