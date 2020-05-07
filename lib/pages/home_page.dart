import 'package:flutter/material.dart';
import 'package:business/services/company_service.dart';
import 'package:business/services/category_service.dart';
import 'package:business/services/response/CompanyResponse.dart';
import 'package:business/services/response/CategoryResponse.dart';
import 'package:business/components/CardBusiness.dart';
import 'package:business/components/CardCategory.dart';

class HomePage extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
  List<CompanyResponse> _companies = [];
  List<CategoryResponse> _categories = [];

  @override
  void initState() {
    super.initState();

    getDataCompanies();
    getCategories();
  }

  Future<Null> getDataCompanies() async {
    List<CompanyResponse> companies = await CompanyService().getCompanies();

    setState(() {
      this._companies.addAll(companies);
    });
  }

  Future<Null> getCategories() async {
    List<CategoryResponse> categories =
        await CategoriesService().getCategories();

    setState(() {
      this._categories.addAll(categories);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            floating: true,
            pinned: false,
            stretch: true,
            title: TextField(),
          ),
          SliverToBoxAdapter(
            child: Container(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _categories.map((CategoryResponse item) {
                    return CardCategory(
                      image: item.image,
                      name: item.name,
                    );
                  }).toList(),
                )),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                // color: Colors.red,
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
        ],
      ),
    );
  }
}
