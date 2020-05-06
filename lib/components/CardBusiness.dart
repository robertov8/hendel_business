import 'package:flutter/material.dart';

class CardBusiness extends StatelessWidget {
  final String title;
  final String categories;
  final String subtitle;

  CardBusiness({this.title, this.categories, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: Container(child: FlutterLogo(size: 50.0))),
            Expanded(
              flex: 3,
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5, bottom: 15),
                              child: Text(
                                categories,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(subtitle),
                          ]),
                    ),
                    Container(child: FlutterLogo(size: 30.0))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
