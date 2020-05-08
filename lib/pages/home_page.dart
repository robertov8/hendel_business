import 'package:business/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:business/services/company_service.dart';
import 'package:business/services/category_service.dart';
import 'package:business/services/response/CompanyResponse.dart';
import 'package:business/services/response/CategoryResponse.dart';
import 'package:business/components/CardBusiness.dart';
import 'package:business/components/CardCategory.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  List<CompanyResponse> _companies = [];
  List<CategoryResponse> _categories = [];

  @override
  void initState() {
    super.initState();

    _getDataCompanies();
    _getCategories();
  }

  Future<Null> _getDataCompanies() async {
    List<CompanyResponse> companies = await CompanyService().getCompanies();

    setState(() {
      this._companies.addAll(companies);
    });
  }

  Future<Null> _getCategories() async {
    List<CategoryResponse> categories =
        await CategoriesService().getCategories();

    setState(() {
      this._categories.addAll(categories);
    });
  }

  void _pushCompaniesByCategory({int id, String name}) async {
    List<CompanyResponse> companiesFiltered = [];

    for (CompanyResponse i in _companies) {
      var categoriesMatch = i.categories.where((el) {
        return el['id'] == id;
      });

      if (categoriesMatch.isNotEmpty) {
        companiesFiltered.add(i);
      }
    }

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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchPage(),
      ),
    );
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
          onTap: () => _pushSearchPage(),
          child: Container(
            width: double.infinity,
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
        child: Container(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _categories.map((CategoryResponse item) {
              return CardCategory(
                  id: item.id,
                  image: item.image,
                  name: item.name,
                  onTap: _pushCompaniesByCategory);
            }).toList(),
          ),
        ),
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
              logo: _companies[i].logo,
              title: _companies[i].fantasyName,
              categories: _companies[i].categories,
              subtitle: _companies[i].description,
              size: _companies[i].size,
            );
          },
          childCount: _companies.length,
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this._categories.isNotEmpty
          ? _customScrollView()
          : Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(255, 105, 85, 1),
                ),
              ),
            ),
    );
  }
}
