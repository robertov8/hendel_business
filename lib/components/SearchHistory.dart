import 'package:flutter/material.dart';

class SearchHistory extends StatelessWidget {
  final String name;
  final Function onSearch;
  final Function onDelete;

  SearchHistory({this.name, this.onSearch, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
//      width: double.infinity,
      child: InkWell(
        onTap: () => onSearch(name),
        child: ListTile(
          leading: Icon(
            Icons.refresh,
            color: Colors.grey,
          ),
          title: Text(name),
          trailing: InkWell(
            onTap: () => onDelete(name),
            child: Icon(
              Icons.clear,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
