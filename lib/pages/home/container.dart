import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoplink_test/config/api.dart';
import 'package:shoplink_test/models/landingPage.dart' as Models;
import 'package:shoplink_test/models/pref.dart';
import 'package:http/http.dart' as http;
import 'package:shoplink_test/pages/home/views/list-banner.dart';
import 'package:shoplink_test/pages/home/views/list-categories.dart';
import 'package:shoplink_test/pages/home/views/list-featured.dart';
import 'package:shoplink_test/pages/home/views/list-manufactures.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final listBanner = List<Models.Banner>();
  final listFeature = List<Models.Feature>();
  final listCategories = List<Models.Categories>();
  final listManufactures = List<Models.Manufactures>();
  TabController tabController;

  var loading = false;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(PrefModel.token);

    if (token != '') {
      fetchHomeData(token);
    } else {
      print('Oops, token  required!');
    }
  }

  fetchHomeData(token) async {
    setState(() {
      loading = true;
    });

    final response = await http
        .get(BaseUrl.apiHome, headers: {'Authorization': 'Bearer ' + token});

    final data = jsonDecode(response.body);
    var banner = data['banner'];
    var featured = data['featured'];
    var categories = data['categories'];
    var manufacture = data['manufacture'];

    banner.forEach((value) {
      final items = new Models.Banner(value["image"], value["url"]);
      listBanner.add(items);
    });

    featured.forEach((value) {
      final item = new Models.Feature(
          value['image'], value['name'], value['price'], value['id']);

      listFeature.add(item);
    });

    categories.forEach((value) {
      final item = new Models.Categories(value['name']);
      listCategories.add(item);
    });

    manufacture.forEach((value) {
      final item = new Models.Manufactures(value['name'], value['image']);

      listManufactures.add(item);
    });

    setState(() {
      loading = false;
    });
  }
  
  textManufactur() {
    return Container(
        child: Row(children: <Widget>[
      Container(
        color: Colors.blue,
        width: 20,
        height: 20,
      ),
      Padding(
        padding: EdgeInsets.only(left: 10, top: 10),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Manufactures",
              style: TextStyle(color: Colors.black, fontSize: 22),
            )),
      ),
    ]));
  }

  textCategories() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(children: <Widget>[
          Container(
            color: Colors.blue,
            width: 20,
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Categories",
                  style: TextStyle(color: Colors.black, fontSize: 22),
                )),
          ),
        ]));
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          icon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {},
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.chat_bubble_outline), onPressed: () {}),
                IconButton(icon: Icon(Icons.notifications), onPressed: () {})
              ],
            ),
            preferredSize: Size.fromRadius(0)),
      ),
      body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              ListBanner(listBanner: listBanner),
              ListFeatured(listFeatured: listFeature),
              textCategories(),
              ListCategories(listCategories: listCategories),
              textManufactur(),
              ListManufactures(listManufactures: listManufactures),
            ],
          )),
    );
  }
}