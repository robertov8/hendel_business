import 'package:mobx/mobx.dart';
import 'package:business/services/response/CategoryResponse.dart';
import 'package:business/services/category_service.dart';

part 'category_controller.g.dart';

class CategoryController = CategoryControllerBase with _$CategoryController;

abstract class CategoryControllerBase with Store {
  @observable
  bool loading = false;

  @observable
  List<CategoryResponse> categories = [];

  @action
  Future<Null> getCategories() async {
    loading = true;

    List<CategoryResponse> categoriesResponse =
    await CategoriesService().getCategories();

    categories.addAll(categoriesResponse);

    loading = false;
  }
}
