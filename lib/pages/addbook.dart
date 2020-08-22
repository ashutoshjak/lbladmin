import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lbladmin/models/book.dart';

class AddBook extends StatefulWidget {
  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {


  bool _isLoading = false;

  final _book_name = TextEditingController();
  final _author_name = TextEditingController();


  String url1 = "http://192.168.100.7/LibraryBookLocator/public/api/books";

  Future<List<Book>> fetchBook() async {
    final response = await http.get(url1);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<dynamic> body = jsonDecode(response.body);

      List<Book> books = body
          .map(
            (dynamic item) => Book.fromJson(item),
      )
          .toList();

      return books;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }




  @override
  void initState() {
    super.initState();
    fetchBook();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Book"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        backgroundColor: Colors.brown[100],
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child:  Icon(Icons.add,),
          onPressed: ShowDialog



        ),


      body: FutureBuilder(
        future: fetchBook(),
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
                            new MaterialPageRoute(builder: (context) => BookDetailPage(snapshot.data[index]))
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


//  ListView(
//  children: books
//      .map(
//  (Book book) => ListTile(
//  title: Text(book.bookName),
//  subtitle: Text(book.authorName),
////                      onTap: (){
////                        Navigator.push(context,
////                            new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[book.id]))
////                        );
////
////                      }
//
//  ),
//  )
//      .toList(),
//  );

//===========ADD BOOK POPUP

  void ShowDialog(){
    showDialog(context: context,
    builder:(BuildContext context){
      return AlertDialog(
        title: Text("Add Book"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                //key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    TextFormField(
                      controller: _book_name,
                      style: TextStyle(color: Color(0xFF000000)),
                      cursorColor: Color(0xFF9b9b9b),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.library_books,
                          color: Colors.grey,
                        ),
                        hintText: "Book Name",
                        hintStyle: TextStyle(
                            color: Color(0xFF9b9b9b),
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),

                    ),
                    TextFormField(
                      controller: _author_name,
                      style: TextStyle(color: Color(0xFF000000)),
                      cursorColor: Color(0xFF9b9b9b),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        hintText: "Author Name",
                        hintStyle: TextStyle(
                            color: Color(0xFF9b9b9b),
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
//                                TextFormField(
//                                  style: TextStyle(color: Color(0xFF000000)),
//                                  cursorColor: Color(0xFF9b9b9b),
//                                  keyboardType: TextInputType.text,
//                                  decoration: InputDecoration(
//                                    prefixIcon: Icon(
//                                      Icons.check_box_outline_blank,
//                                      color: Colors.grey,
//                                    ),
//                                    hintText: "Shelf No",
//                                    hintStyle: TextStyle(
//                                        color: Color(0xFF9b9b9b),
//                                        fontSize: 15,
//                                        fontWeight: FontWeight.normal),
//                                  ),
//
//                                ),
//                                TextFormField(
//                                  style: TextStyle(color: Color(0xFF000000)),
//                                  cursorColor: Color(0xFF9b9b9b),
//                                  keyboardType: TextInputType.text,
//                                  decoration: InputDecoration(
//                                    prefixIcon: Icon(
//                                      Icons.add_location,
//                                      color: Colors.grey,
//                                    ),
//                                    hintText: "Row No",
//                                    hintStyle: TextStyle(
//                                        color: Color(0xFF9b9b9b),
//                                        fontSize: 15,
//                                        fontWeight: FontWeight.normal),
//                                  ),
//
//                                ),
//                                TextFormField(
//                                  style: TextStyle(color: Color(0xFF000000)),
//                                  cursorColor: Color(0xFF9b9b9b),
//                                  keyboardType: TextInputType.text,
//                                  decoration: InputDecoration(
//                                    prefixIcon: Icon(
//                                      Icons.add_location,
//                                      color: Colors.grey,
//                                    ),
//                                    hintText: "Column No",
//                                    hintStyle: TextStyle(
//                                        color: Color(0xFF9b9b9b),
//                                        fontSize: 15,
//                                        fontWeight: FontWeight.normal),
//                                  ),
//
//                                ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FlatButton(
                          child: Text(_isLoading? 'Proccessing...' : 'AddBook',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(color: Colors.white),),
                          color: Colors.red,

                          shape: new RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(20.0)),
                          onPressed: addData
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        )
      );
    }

    );
  }

//===========ADD BOOK POPUP




//==============ADD DATA fucntion

  void addData() async {
    setState(() {
      _isLoading = true;
    });

    String url = "http://10.0.2.2/LibraryBookLocator/public/api/book";
    //192.168.100.7 myip
    await http
        .post(url,
        headers: {'Accept': 'application/json'},
        body: ({
          "book_name": _book_name.text,
          "author_name": _author_name.text,
        }))
        .then((response) {
      if (response.statusCode == 201) {
        success();
      } else {
        failed();
      }
    });

    setState(() {
      _isLoading = false;
    });
  }

  void success() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Book Added"),
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

  void failed() {
//    var context;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Could not add "),
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
}

//==============ADD DATA fucntion

//Detailpage
class BookDetailPage extends StatelessWidget {

  final Book book;

  BookDetailPage(this.book);

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




