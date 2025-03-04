import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:business/app/components/CardBusiness.dart';
import 'package:business/app/components/CardCategory.dart';
import 'package:business/app/controller/category_controller.dart';
import 'package:business/app/controller/company_controller.dart';
import 'package:business/app/services/response/CategoryResponse.dart';
import 'package:business/app/services/response/CompanyResponse.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final companyController = GetIt.I.get<CompanyController>();
  final categoryController = CategoryController();

  @override
  void initState() {
    super.initState();

    _getData();
  }

  Future<Null> _getData() async {
    companyController.getDataCompanies();
    categoryController.getCategories();
  }

  void _pushCompaniesByCategory({int id, String name}) async {
    List<CompanyResponse> companiesFiltered =
        companyController.getCompaniesByCategory(id);

    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: Text(name)),
          body: Padding(
            padding: EdgeInsets.only(top: 8),
            child: ListView(
              children: companiesFiltered.map((CompanyResponse c) {
                return CardBusiness(
                  logo: c.logo,
                  title: c.fantasyName,
                  categories: c.categories,
                  subtitle: c.description,
                  size: c.size,
                );
              }).toList(),
            ),
          ),
        );
      }),
    );
  }

  void _pushSearchPage() {
    // Navigator.pushNamed(context, '/search');
    Modular.to.pushNamed('/search');
  }

  Widget _customScrollView() {
    return CustomScrollView(slivers: [
      SliverAppBar(
        backgroundColor: Colors.white,
        floating: true,
        pinned: false,
        stretch: true,
        forceElevated: true,
        leading: InkWell(
          onTap: () => _pushSearchPage(),
          child: Icon(
            Icons.search,
            color: Color.fromRGBO(255, 105, 85, 1),
          ),
        ),
        title: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => _pushSearchPage(),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: 20,
              left: 0,
              bottom: 20,
              right: 20,
            ),
            child: Text(
              'Pesquisar',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Observer(builder: (_) {
          return categoryController.loading
              ? CircularProgressIndicator()
              : Container(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: categoryController.categories
                        .map((CategoryResponse item) {
                      return CardCategory(
                        id: item.id,
                        image: item.image,
                        name: item.name,
                        onTap: _pushCompaniesByCategory,
                      );
                    }).toList(),
                  ),
                );
        }),
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Lojas',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            ),
          ),
        ]),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int i) {
            return CardBusiness(
              logo: companyController.companies[i].logo,
              title: companyController.companies[i].fantasyName,
              categories: companyController.companies[i].categories,
              subtitle: companyController.companies[i].description,
              size: companyController.companies[i].size,
            );
          },
          childCount: companyController.companies.length,
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Observer(builder: (_) {
          return companyController.loading
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(255, 105, 85, 1),
                    ),
                  ),
                )
              : _customScrollView();
        }),
      ),
    );
  }
}
