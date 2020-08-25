import 'package:flutter/material.dart';
import 'package:lbladmin/models/book.dart';

class SearchBook extends SearchDelegate {

   List<Book> boo;

   SearchBook(this.boo);


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
    final suggestionList = query.isEmpty
        ? boo
        : boo
        .where((element) =>
        element.bookName.toString().toLowerCase().startsWith(query))
        .toList();

    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(suggestionList[index].bookName),
              subtitle: Text(suggestionList[index].authorName),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) =>
                        RequestBookDetailPage(suggestionList[index]))
                );
              }
          );
        });

  }
}

class RequestBookDetailPage extends StatelessWidget {
  final Book book;

  RequestBookDetailPage(this.book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.bookName),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.brown[100],
      body: Center(
        child: Container(
          child: Text(book.authorName),
        ),
      ),
    );
  }
}
