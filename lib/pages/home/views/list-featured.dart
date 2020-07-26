import 'package:flutter/material.dart';

class ListFeatured extends StatelessWidget {
  final listFeatured;

  ListFeatured({this.listFeatured});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        height: MediaQuery.of(context).size.height / 6,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
            separatorBuilder: (context, i) => Padding(
                  padding: EdgeInsets.only(left: 18, right: 18),
                ),
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: listFeatured.length,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              final item = listFeatured[i];
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
                        padding: EdgeInsets.all(5),
                        child: Image.network(
                          item.image,
                          height: 70,
                          width: 70,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.name,
                            style: TextStyle(fontWeight: FontWeight.w200),
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
                            style: TextStyle(fontWeight: FontWeight.w500),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ));
            }));
  }
}
