import 'package:flutter/material.dart';

class CardCategory extends StatelessWidget {
  final String image;
  final String name;

  CardCategory({this.image, this.name = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {},
            child: ClipRRect(
                borderRadius: new BorderRadius.circular(5.0),
                child: Image(
                  height: 60,
                  image: NetworkImage(image),
                )),
          ),
          Center(
            child: Text(name, style: TextStyle(fontWeight: FontWeight.w400)),
          )
        ],
      ),
    );
  }
}
