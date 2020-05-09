import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:business/app/controller/company_controller.dart';
import 'package:business/app/controller/history_controller.dart';
import 'package:business/app/components/SearchHistory.dart';
import 'package:business/app/components/CardBusiness.dart';
import 'package:business/app/services/response/CompanyResponse.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final companyController = GetIt.I.get<CompanyController>();
  final historyController = HistoryController();

  final _searchText = TextEditingController();

  @override
  void initState() {
    super.initState();

    historyController.getHistory();
  }

  @override
  void dispose() {
    _searchText.dispose();
    super.dispose();
  }

  Future<void> _saveRequestSearch(String text) async {
    historyController.saveRequestSearch(text);
    _searchText.clear();

    _onSearch(text);
  }

  void _onSearch(String text) {
    String term = text.toLowerCase();
    List<CompanyResponse> companiesFiltered = [];

    companyController.companies.forEach((CompanyResponse company) {
      if (company.fantasyName.toLowerCase().contains(term)) {
        companiesFiltered.add(company);
        return;
      }

      var categoriesMatch = company.categories.where((el) {
        return el['name'].toLowerCase().contains(term);
      });

      if (categoriesMatch.isNotEmpty) {
        companiesFiltered.add(company);
      }
    });

    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: Text(text)),
          body: Padding(
            padding: EdgeInsets.only(top: 8),
            child: ListView(
              children: companiesFiltered.map((CompanyResponse company) {
                return CardBusiness(
                  logo: company.logo,
                  title: company.fantasyName,
                  categories: company.categories,
                  subtitle: company.description,
                  size: company.size,
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
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          controller: _searchText,
          onSubmitted: _saveRequestSearch,
          decoration: const InputDecoration(
            hintText: 'Pesquisar',
            border: InputBorder.none,
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      body: Container(
        child: Card(
          margin: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Text(
                  'Pesquisas Recentes',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Observer(builder: (_) {
                return FutureBuilder<List>(
                  future: historyController.history,
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const CircularProgressIndicator();
                      default:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          if (snapshot.data.isEmpty) {
                            return Text('');
                          }

                          return Flexible(
                            child: ListView(
                              shrinkWrap: true,
                              children: snapshot.data
                                  .map(
                                    (history) => SearchHistory(
                                      name: history,
                                      onSearch: _onSearch,
                                      onDelete:
                                          historyController.removeRequestSearch,
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                        }
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
