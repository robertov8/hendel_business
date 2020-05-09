import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:business/app/app_widget.dart';
import 'package:business/app/menu_bottom.dart';
import 'package:business/app/pages/search_page.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => MenuBottom()),
        Router('/search', child: (_, args) => SearchPage()),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
