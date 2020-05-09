import 'package:dio/dio.dart';
import 'package:business/app/services/service.dart';
import 'package:business/app/services/response/CategoryResponse.dart';

class CategoriesService extends Service {
  List<CategoryResponse> data = [];

  Future getCategories() async {
    Response response = await dio.get('$baseURL/5eac697c330000dc64dfe3db');

    for (Map i in response.data['items']) {
      this.data.add(CategoryResponse.fromJson(i));
    }

    return this.data;
  }
}
