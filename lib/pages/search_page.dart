import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:business/components/SearchHistory.dart';

class SearchPage extends StatefulWidget {
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
      return prefs.getStringList('history');
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
  }

  void _onSearch(String text) {
    print('_onSearch $text');
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

                        return ListView(
                          shrinkWrap: true,
                          children: snapshot.data
                              .map((history) => SearchHistory(
                                    name: history,
                                    onSearch: _onSearch,
                                    onDelete: _removeRequestSearch,
                                  ))
                              .toList(),
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
