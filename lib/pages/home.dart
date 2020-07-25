import 'dart:convert';

// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoplink_test/config/api.dart';
import 'package:shoplink_test/models/landingPage.dart' as model;
import 'package:shoplink_test/models/pref.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final listBanner = List<model.Banner>();
  final listFeature = List<model.Feature>();
  final listCategories = List<model.Categories>();

  var loading = false;

  @override
  void initState() {
    getPref();
  }

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
    // var manufacture = data['manufacture'];
    banner.forEach((value) {
      final items = new model.Banner(value["image"], value["url"]);
      listBanner.add(items);
    });

    featured.forEach((value) {
      final item = new model.Feature(
          value['image'], value['name'], value['price'], value['id']);

      listFeature.add(item);
    });

    categories.forEach((value) {
      final item = new model.Categories(value['name']);
      listCategories.add(item);
    });

    setState(() {
      loading = false;
    });
  }

  slideBanner() {
    return Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        height: MediaQuery.of(context).size.height / 4,
        child: Stack(children: <Widget>[
          ListView.separated(
              separatorBuilder: (context, i) => Padding(
                    padding: EdgeInsets.all(10),
                  ),
              addAutomaticKeepAlives: true,
              reverse: true,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, i) {
                final item = listBanner[i];
                return Container(
                    child: Column(children: <Widget>[
                  Container(
                    height: 184,
                    width: 340,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                          item.image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ]));
              }),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton.extended(
              onPressed: () {
                // Add your onPressed code here!
              },
              label: Text(
                'SEE MORE',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.blue,
                size: 12,
              ),
              backgroundColor: Colors.white,
            ),
          )
        ]));
  }

  categoriesMenu() {
    return Container(
        padding: EdgeInsets.only(left:20,right:20),
        
        height: MediaQuery.of(context).size.height / 8.5,
            child: Row(
              children: <Widget>[
                ListView.separated(
                    separatorBuilder: (context, i) => Padding(
                          padding: EdgeInsets.all(18),
                        ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: listCategories.length,
                    itemBuilder: (context, i) {
                      final item = listCategories[i];
                      return Container(
                          child: Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    width: 66,
                                    height: 66,
                                    decoration:
                                        BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(100)),
                                          color: Colors.blue),
                                  ),
                                  Text(item.name)
                                ],
                              ),
                            ],
                          )
                        ],
                      ));
                    }),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        width: 66,
                        height: 66,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Colors.blue),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:<Widget>[
                            Text("See all"),
                          ]
                        )
                      )
                    ],
                  ),
                )
              ],
            ),
         
        );
  }

  featuredMenu() {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        height: MediaQuery.of(context).size.height / 5,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
            separatorBuilder: (context, i) => Padding(
                  padding: EdgeInsets.all(18),
                ),
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: listFeature.length,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              final item = listFeature[i];
              return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  width: 101,
                  height: 135,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.network(
                          item.image,
                          height: 87,
                          width: 87,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.name,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.price,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ));
            }));
  }

  textCategories() {
    return Container(
        margin: EdgeInsets.only(top: 5),
        child: Row(children: <Widget>[
          Container(
            color: Colors.blue,
            width: 20,
            height: 23,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Categories",
                  style: TextStyle(color: Colors.black, fontSize: 25),
                )),
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                slideBanner(),
                featuredMenu(),
                textCategories(),
                categoriesMenu(),
              ],
            )));
  }
}
