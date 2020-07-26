import 'package:flutter/material.dart';
import 'package:shoplink_test/pages/profile/container.dart';
import 'package:shoplink_test/pages/search/container.dart';

import 'chart/container.dart';
import 'home/container.dart';
import 'more/container.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 5,
      child: Scaffold(
        body: TabBarView(children: <Widget>[
          Home(),
          Search(),
          Chart(),
          Profile(),
          More(),
        ]),
        bottomNavigationBar: new Material(
            color: Colors.white,
            child: new TabBar(
              tabs: <Widget>[
                new Tab(
                    icon: Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    child: Text("Home", style: TextStyle(color: Colors.black))),
                new Tab(
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    child:
                        Text("Search", style: TextStyle(color: Colors.black))),
                new Tab(
                    icon: Icon(
                      Icons.chat,
                      color: Colors.black,
                    ),
                    child:
                        Text("Chart", style: TextStyle(color: Colors.black))),
                new Tab(
                    icon: Icon(
                      Icons.people,
                      color: Colors.black,
                    ),
                    child:
                        Text("Profile", style: TextStyle(color: Colors.black))),
                new Tab(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    child: Text("More", style: TextStyle(color: Colors.black))),
              ],
            )),
      ),
    ));
  }
}
