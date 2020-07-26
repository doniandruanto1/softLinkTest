import 'package:flutter/material.dart';

class ListCategories extends StatelessWidget {

  final listCategories;

  ListCategories({ this.listCategories });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      height: MediaQuery.of(context).size.height / 8,
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
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                    ),
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
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
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Colors.white),
                  child: Center(
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.orange,
                        ),
                        onPressed: () {}),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "See all",
                          ),
                        ]))
              ],
            ),
          )
        ],
      ),
    );
  }
}