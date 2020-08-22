import 'dart:convert';
import 'dart:async';
import 'package:lbladmin/models/requestbook.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lbladmin/search/requestbooksearch.dart';

class SearchBook extends SearchDelegate {

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text(""); //Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
   return Container();

  }
}
