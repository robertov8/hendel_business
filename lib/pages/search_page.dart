import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:business/components/SearchHistory.dart';
import 'package:business/components/CardBusiness.dart';
import 'package:business/services/response/CompanyResponse.dart';

class SearchPage extends StatefulWidget {
  final List<CompanyResponse> companies;

  SearchPage({this.companies});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<List> _history;

  final _searchText = TextEditingController();

  @override
  void initState() {
    super.initState();

    _history = _prefs.then((SharedPreferences prefs) {
      return prefs.getStringList('history') ?? [];
    });
  }

  @override
  void dispose() {
    _searchText.dispose();
    super.dispose();
  }

  Future<void> _saveRequestSearch(String text) async {
    final SharedPreferences prefs = await _prefs;
    final history = prefs.getStringList('history') ?? [];

    history.add(text);

    setState(() {
      _history = prefs.setStringList('history', history).then((bool success) {
        return history.reversed.toList();
      });

      _searchText.clear();
    });

    _onSearch(text);
  }

  void _onSearch(String text) {
    String term = text.toLowerCase();
    List<CompanyResponse> companiesFiltered = [];

    widget.companies.forEach((CompanyResponse company) {
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

  void _removeRequestSearch(String text) async {
    final SharedPreferences prefs = await _prefs;
    final history = prefs.getStringList('history') ?? [];

    history.remove(text);

    setState(() {
      _history = prefs.setStringList('history', history).then((bool success) {
        return history.reversed.toList();
      });
    });
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
              FutureBuilder<List>(
                future: _history,
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
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
                                .map((history) => SearchHistory(
                                      name: history,
                                      onSearch: _onSearch,
                                      onDelete: _removeRequestSearch,
                                    ))
                                .toList(),
                          ),
                        );
                      }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
