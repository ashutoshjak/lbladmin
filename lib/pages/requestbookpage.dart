import 'dart:convert';
import 'dart:async';
import 'package:lbladmin/models/requestbook.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class RequestBook extends StatefulWidget {
  @override
  _RequestBookState createState() => _RequestBookState();
}

class _RequestBookState extends State<RequestBook> {


  String url2 = "http://192.168.100.7/LibraryBookLocator/public/api/requestbooks";

  Future<List<RequestsBook>> fetchRequestBook() async {
    final response = await http.get(url2);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<dynamic> body = jsonDecode(response.body);

      List<RequestsBook> requestbooks = body
          .map(
            (dynamic item) => RequestsBook.fromJson(item),
      )
          .toList();

      return requestbooks;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRequestBook();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Book"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.brown[100],
      body: FutureBuilder(
        future: fetchRequestBook(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder:(BuildContext context, int index) {
                  return ListTile(
                      title: Text(snapshot.data[index].bookName),
                      subtitle: Text(snapshot.data[index].authorName),
                      onTap: (){
                        Navigator.push(context,
                            new MaterialPageRoute(builder: (context) => RequestBookDetailPage(snapshot.data[index]))
                        );

                      }

                  );
                }

            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class RequestBookDetailPage extends StatelessWidget {

  final RequestsBook book;

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








//old body

//body: FutureBuilder(
//future: fetchRequestBook(),
//builder: (BuildContext context, AsyncSnapshot<List<RequestsBook>> snapshot) {
//if (snapshot.hasData) {
//List<RequestsBook> requestbooks = snapshot.data;
//return ListView(
//children: requestbooks
//    .map(
//(RequestsBook requestbook) => ListTile(
//title: Text(requestbook.bookName),
//subtitle: Text(requestbook.authorName),
//
//),
//)
//    .toList(),
//);
//} else {
//return Center(child: CircularProgressIndicator());
//}
//},
//),