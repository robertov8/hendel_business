import 'package:dio/dio.dart';
import 'package:business/app/services/response/CompanyResponse.dart';
import 'package:business/app/services/service.dart';

class CompanyService extends Service {
  List<CompanyResponse> data = [];

  Future getCompanies() async {
    Response response = await dio.get('$baseURL/5eac692c3300003941dfe3d8');

    for (Map i in response.data['items']) {
      this.data.add(CompanyResponse.fromJson(i));
    }

    return this.data;
  }
}
