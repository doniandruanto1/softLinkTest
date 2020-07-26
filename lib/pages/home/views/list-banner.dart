import 'package:flutter/material.dart';

class ListBanner extends StatelessWidget {

  final listBanner;

  ListBanner({ this.listBanner });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        height: MediaQuery.of(context).size.height / 4.5,
        child: Stack(children: <Widget>[
          ListView.separated(
              separatorBuilder: (context, i) => Padding(
                    padding: EdgeInsets.all(10),
                  ),
              addAutomaticKeepAlives: true,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: listBanner.length,
              itemBuilder: (context, i) {
                final item = listBanner[i];
                return Container(
                    child: Column(children: <Widget>[
                  Container(
                    height: 140,
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
}
