import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AddBook extends StatefulWidget {
  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {

  final _book_name = TextEditingController();
  final _author_name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("AddBook"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        backgroundColor: Colors.brown[100],
        body: Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        elevation: 4.0,
                        color: Colors.white,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Form(
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
                                      child: Text("Add Book",style: TextStyle(color: Colors.white),),
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
                        ),
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
  void addData() async {
    String url = "http://192.168.100.7/LibraryBookLocator/public/api/book";
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

