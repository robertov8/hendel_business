import 'package:business/components/CardBusiness.dart';
import 'package:flutter/material.dart';
import 'package:business/services/company_service.dart';
import 'package:business/services/response/CompanyResponse.dart';

class CardCategory extends StatelessWidget {
  final int id;
  final String image;
  final String name;
  final String tags;

  final BuildContext context;

  CardCategory({this.id, this.image, this.name = '', this.tags, this.context});

  void _pushCompaniesByCategory() async {
    List<CompanyResponse> companiesResponse =
        await CompanyService().getCompanies();
    List<CompanyResponse> companies = [];

    for (CompanyResponse i in companiesResponse) {
      var categoriesMatch = i.categories.where((el) {
        return el['id'] == id;
      });

      if (categoriesMatch.isNotEmpty) {
        companies.add(i);
      }
    }

    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: Text(name)),
          body: Padding(
            padding: EdgeInsets.only(top: 8),
            child: ListView(
              children: companies.map((CompanyResponse c) {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: _pushCompaniesByCategory,
            child: ClipRRect(
                borderRadius: new BorderRadius.circular(5.0),
                child: Image(
                  height: 60,
                  image: NetworkImage(image),
                )),
          ),
          Center(
            child: Text(name, style: TextStyle(fontWeight: FontWeight.w400)),
          )
        ],
      ),
    );
  }
}
