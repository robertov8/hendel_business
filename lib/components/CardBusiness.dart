import 'package:flutter/material.dart';

class CardBusiness extends StatelessWidget {
  final String logo;
  final String title;
  final List categories;
  final String subtitle;
  final int size;

  CardBusiness(
      {this.logo, this.title, this.categories, this.subtitle, this.size});

  @override
  Widget build(BuildContext context) {
    String _categories = this.categories.map((e) => '${e['name']}').join(', ');

    return Card(
      color: Colors.white,
      elevation: 2,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 5,
              right: 8,
            ),
            child: Image(height: 70, image: NetworkImage(logo)),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              bottom: 20,
                            ),
                            child: Text(
                              _categories,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              subtitle,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ]),
                  ),
                  Row(
                    children: [
                      Container(
                        color: Colors.redAccent,
                        height: 50,
                        width: 40,
                        margin: const EdgeInsets.only(
                          right: 4,
                        ),
                        child: Center(
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 4.0,
                              ),
                              child: Text(
                                '$size',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              '...',
                              style: TextStyle(color: Colors.white),
                            )
                          ]),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
