import 'package:business/services/response/CompanyResponse.dart';
import 'package:flutter/material.dart';
import 'package:business/components/CardBusiness.dart';
import 'package:business/services/company_service.dart';

class HomePage extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
  final _service = CompanyService();

  List<CompanyResponse> _companies = [];

  @override
  void initState() {
    super.initState();

    getData();
  }

  Future<Null> getData() async {
    List<CompanyResponse> companies = await _service.getCompanies();

    setState(() {
      this._companies.addAll(companies);
    });
  }

  Widget _buildBusiness() {
    return Container(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _companies.length,
        itemBuilder: (BuildContext context, int i) {
          return Container(
            child: CardBusiness(
              logo: _companies[i].logo,
              title: _companies[i].fantasyName,
              categories: _companies[i].categories,
              subtitle: _companies[i].description,
              size: _companies[i].size,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[],
      ),
      body: _buildBusiness(),
    );
  }
}
