import 'package:flutter/material.dart';
import 'package:lbladmin/models/requestbook.dart';
import 'package:http/http.dart' as http;
import 'package:lbladmin/pages/requestbookpage.dart';



class SearchRequestBook extends SearchDelegate {


  List<RequestsBook> requbook;

  SearchRequestBook(this.requbook);


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
        ? requbook
        : requbook
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
  final RequestsBook book;

  RequestBookDetailPage(this.book);



  @override
  Widget build(BuildContext context) {

    void Deleted() {

      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("deleted: ${book.bookName} "),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void deleteRequestBook(RequestsBook book) async {
      String url3 = "http://192.168.100.7/LibraryBookLocator/public/api/deleterequestbook/${book.id}";

      final response = await http.get(url3);
      if (response.statusCode == 200) {
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>RequestBook()
        ));
        Deleted();

      }


    }

    return Scaffold(
      appBar: AppBar(
        title: Text(book.bookName),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.brown[100],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Row(
                      children: <Widget>[


                        Padding(
                          padding: const EdgeInsets.fromLTRB(95.0, 10.0, 0, 10.0),
                          child: Text('Author Name: ${book.authorName}',style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                          ),),
                        ),


                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
//                      RaisedButton(
//                        color: Colors.grey,
//                        child: Text('Update',style: TextStyle(
//                            color: Colors.white
//                        ),),
//                      ),
                      RaisedButton(
                        color: Colors.red,
                        child: Text('Delete',style: TextStyle(
                            color: Colors.white
                        ),
                        ),
                        onPressed: (){
                          deleteRequestBook(book);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );


  }



}

