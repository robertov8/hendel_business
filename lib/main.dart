import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:business/app/menu_bottom.dart';
import 'package:business/app/controller/company_controller.dart';
import 'package:business/app/controller/category_controller.dart';

void main() {
  GetIt getIt = GetIt.I;
  getIt.registerSingleton<CompanyController>(CompanyController());
  getIt.registerSingleton<CategoryController>(CategoryController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hendel Business',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MenuBottom(),
    );
  }
}
