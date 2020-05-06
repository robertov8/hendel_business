import 'package:flutter/material.dart';
import 'package:business/components/CardBusiness.dart';

class HomePage extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
  List<Widget> _business = <Widget>[];

  Widget _buildBusiness() {
    for (var i in [0, 1, 2, 3 ,4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]) {
      _business.add(CardBusiness(
        title: 'Entry $i',
        categories: 'Entry $i, Entry $i, Entry $i',
        subtitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. $i'
      ));
    }

    print(_business);

    return ListView(padding: const EdgeInsets.all(8), children: _business);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[],
      ),
      body: Center(
        child: _buildBusiness(),
      ),
      backgroundColor: const Color(0xffdbdadb),
    );
  }
}
