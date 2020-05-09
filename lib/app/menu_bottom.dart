import 'package:flutter/material.dart';
import 'package:business/app/pages/home_page.dart';

class MenuBottom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MenuBottomState();
}

class MenuBottomState extends State<MenuBottom> {
  BottomNavigationBarItem bottomNavigationItem({String title, IconData icon}) {
    return BottomNavigationBarItem(
      title: Text(title),
      icon: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Color.fromRGBO(255, 105, 85, 1),
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        items: <BottomNavigationBarItem>[
          bottomNavigationItem(title: 'Lojas', icon: Icons.store),
          bottomNavigationItem(title: '...', icon: Icons.person_pin),
          bottomNavigationItem(title: '...', icon: Icons.chrome_reader_mode),
          bottomNavigationItem(title: 'Perfil', icon: Icons.person),
        ],
      ),
    );
  }
}
