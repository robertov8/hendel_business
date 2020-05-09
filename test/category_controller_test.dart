import 'package:business/app/app_module.dart';
import 'package:business/app/controller/category_controller.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

main() {
  initModule(AppModule());

  setUpAll(() {
    GetIt getIt = GetIt.I;
    getIt.registerSingleton<CategoryController>(CategoryController());
  });

  test('loading categories', () async {
    final CategoryController controller = GetIt.I.get<CategoryController>();

    expect(controller.categories.length, 0);

    await controller.getCategories();

    expect(controller.categories.length, greaterThan(0));
  });
}
