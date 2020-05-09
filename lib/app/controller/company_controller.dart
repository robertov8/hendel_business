import 'package:mobx/mobx.dart';
import 'package:business/app/services/response/CompanyResponse.dart';
import 'package:business/app/services/company_service.dart';

part 'company_controller.g.dart';

class CompanyController = CompanyControllerBase with _$CompanyController;

abstract class CompanyControllerBase with Store {
  @observable
  bool loading = false;

  @observable
  List<CompanyResponse> companies = [];

  @action
  Future<Null> getDataCompanies() async {
    loading = true;
    List<CompanyResponse> companiesResponse = await CompanyService().getCompanies();
    companies.addAll(companiesResponse);
    loading = false;
  }

  @action
  List<CompanyResponse> getCompaniesByCategory(int id) {
    List<CompanyResponse> companiesFiltered = [];

    companies.forEach((CompanyResponse company) {
      var categoriesMatch = company.categories.where((category) {
        return category['id'] == id;
      });

      if (categoriesMatch.isNotEmpty) {
        companiesFiltered.add(company);
      }
    });

    return companiesFiltered;
  }
}
