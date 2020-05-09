import 'package:flutter_test/flutter_test.dart';
import 'package:business/app/app_module.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:get_it/get_it.dart';
import 'package:business/app/controller/company_controller.dart';
import 'package:business/app/controller/category_controller.dart';

main() {
  initModule(AppModule());

  setUpAll(() {
    GetIt getIt = GetIt.I;
    getIt.registerSingleton<CompanyController>(CompanyController());
    getIt.registerSingleton<CategoryController>(CategoryController());
  });

  test('loading company', () async {
    final CompanyController controller = GetIt.I.get<CompanyController>();

    expect(controller.companies.length, 0);

    await controller.getDataCompanies();

    expect(controller.companies.length, greaterThan(0));
  });

  test('loading company by category', () async {
    final CategoryController categoryController =
        GetIt.I.get<CategoryController>();
    final CompanyController companyController =
        GetIt.I.get<CompanyController>();

    expect(categoryController.categories.length, 0);

    await categoryController.getCategories();
    var category = categoryController.categories[0];

    var companiesByCategory =
        companyController.getCompaniesByCategory(category.id);

    expect(companiesByCategory.length, greaterThan(0));
  });
}
