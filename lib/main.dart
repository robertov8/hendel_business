import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:business/app/controller/company_controller.dart';
import 'package:business/app/controller/category_controller.dart';
import 'package:business/app/app_module.dart';

void main() {
  GetIt getIt = GetIt.I;
  getIt.registerSingleton<CompanyController>(CompanyController());
  getIt.registerSingleton<CategoryController>(CategoryController());

  runApp(ModularApp(
    module: AppModule(),
  ));
}
