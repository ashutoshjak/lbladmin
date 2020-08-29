import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lbladmin/models/book.dart';
import 'package:lbladmin/search/booksearch.dart';


class AddBook extends StatefulWidget {
  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {


  bool _isLoading = false;

  bool isLoading=false;



  final _book_name = TextEditingController();
  final _author_name = TextEditingController();


  String url1 = "http://192.168.100.7/LibraryBookLocator/public/api/books";

//  Future<List<Book>> fetchBook() async {
//    final response = await http.get(url1);
//
//    if (response.statusCode == 200) {
//      // If the server did return a 200 OK response,
//      // then parse the JSON.
//      List<dynamic> body = jsonDecode(response.body);
//
//      List<Book> books = body
//          .map(
//            (dynamic item) => Book.fromJson(item),
//      )
//          .toList();
//
//      return books;
//    } else {
//      // If the server did not return a 200 OK response,
//      // then throw an exception.
//      throw Exception('Failed to load ');
//    }
//  }
//
//
//  @override
//  void initState() {
//    super.initState();
//    fetchBook();
//  }

//new old body
//body: FutureBuilder(
//future: fetchBook(),
//builder: (BuildContext context, AsyncSnapshot snapshot) {
//if (snapshot.hasData) {
//return ListView.builder(
//itemCount: snapshot.data.length,
//itemBuilder:(BuildContext context, int index) {
//return ListTile(
//title: Text(snapshot.data[index].bookName),
//subtitle: Text(snapshot.data[index].authorName),
//onTap: (){
//Navigator.push(context,
//new MaterialPageRoute(builder: (context) => RequestBookDetailPage(snapshot.data[index]))
//);
//
//}
//
//);
//}
//
//);
//} else {
//return Center(child: CircularProgressIndicator());
//}
//},
//),


  Future<List<Book>> fetchBook() async {
    try {
      final response = await http.get(url1);
      if (response.statusCode == 200) {
        List<Book> book = parseRequestBooks(response.body);
        return book;
      } else {
        throw Exception("error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  List<Book> parseRequestBooks(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    {
      return parsed
          .map<Book>((json) => Book.fromJson(json))
          .toList();
    }
  }

  List<Book> book = List();

  @override
  void initState() {
    super.initState();
    isLoading = true;
    fetchBook().then((booksFromServer) {
      setState(() {
        isLoading = false;
        book = booksFromServer;
      });
    });
  }



  Future<void> _getData() async {
     setState(() {
      fetchBook();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Book"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search),onPressed: (){

              showSearch(context: context, delegate: SearchBook(book));

            })
          ],
          backgroundColor: Colors.red,
        ),
        backgroundColor: Colors.brown[100],
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child:  Icon(Icons.add,),
          onPressed: ShowDialog

        ),


        body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : RefreshIndicator(
          onRefresh: _getData,
          child: ListView.builder (
            itemCount: book == null ? 0 : book.length,
            itemBuilder: (BuildContext context, index) {
              return Card(
                color: Colors.brown[100],
                child: ListTile(
                    title: Text(book[index].bookName),
                    subtitle: Text(book[index].authorName),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
//                        IconButton(
//                            icon: Icon(Icons.delete),
//                            onPressed: () {
//                              setState(() {
//                                deleteBook(book[index]);
//                              });
//                            }
//                        ),
//                        IconButton(
//                            icon: Icon(Icons.update),
//                            onPressed: () {
//                             ShowUpdateDialog(book[index]);
//                            }
//                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  BookDetailPage(book[index])));
                    }
                ),
              );
            },
          ),
        )
    );

  }




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
                          onPressed: (){
                            setState(() {
                              addData();
                            });
                          }
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


//  void ShowUpdateDialog(Book book){
//    showDialog(context: context,
//        builder:(BuildContext context){
//          return AlertDialog(
//              title: Text("Update Book"),
//              content: SingleChildScrollView(
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Form(
//                      //key: _formKey,
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//
//                          TextFormField(
//                            controller: _book_name,
//                            style: TextStyle(color: Color(0xFF000000)),
//                            cursorColor: Color(0xFF9b9b9b),
//                            keyboardType: TextInputType.text,
//                            decoration: InputDecoration(
//                              prefixIcon: Icon(
//                                Icons.library_books,
//                                color: Colors.grey,
//                              ),
//                              hintText: "Book Name",
//                              hintStyle: TextStyle(
//                                  color: Color(0xFF9b9b9b),
//                                  fontSize: 15,
//                                  fontWeight: FontWeight.normal),
//                            ),
//
//                          ),
//                          TextFormField(
//                            controller: _author_name,
//                            style: TextStyle(color: Color(0xFF000000)),
//                            cursorColor: Color(0xFF9b9b9b),
//                            keyboardType: TextInputType.text,
//                            decoration: InputDecoration(
//                              prefixIcon: Icon(
//                                Icons.person,
//                                color: Colors.grey,
//                              ),
//                              hintText: "Author Name",
//                              hintStyle: TextStyle(
//                                  color: Color(0xFF9b9b9b),
//                                  fontSize: 15,
//                                  fontWeight: FontWeight.normal),
//                            ),
//                          ),
////                                TextFormField(
////                                  style: TextStyle(color: Color(0xFF000000)),
////                                  cursorColor: Color(0xFF9b9b9b),
////                                  keyboardType: TextInputType.text,
////                                  decoration: InputDecoration(
////                                    prefixIcon: Icon(
////                                      Icons.check_box_outline_blank,
////                                      color: Colors.grey,
////                                    ),
////                                    hintText: "Shelf No",
////                                    hintStyle: TextStyle(
////                                        color: Color(0xFF9b9b9b),
////                                        fontSize: 15,
////                                        fontWeight: FontWeight.normal),
////                                  ),
////
////                                ),
////                                TextFormField(
////                                  style: TextStyle(color: Color(0xFF000000)),
////                                  cursorColor: Color(0xFF9b9b9b),
////                                  keyboardType: TextInputType.text,
////                                  decoration: InputDecoration(
////                                    prefixIcon: Icon(
////                                      Icons.add_location,
////                                      color: Colors.grey,
////                                    ),
////                                    hintText: "Row No",
////                                    hintStyle: TextStyle(
////                                        color: Color(0xFF9b9b9b),
////                                        fontSize: 15,
////                                        fontWeight: FontWeight.normal),
////                                  ),
////
////                                ),
////                                TextFormField(
////                                  style: TextStyle(color: Color(0xFF000000)),
////                                  cursorColor: Color(0xFF9b9b9b),
////                                  keyboardType: TextInputType.text,
////                                  decoration: InputDecoration(
////                                    prefixIcon: Icon(
////                                      Icons.add_location,
////                                      color: Colors.grey,
////                                    ),
////                                    hintText: "Column No",
////                                    hintStyle: TextStyle(
////                                        color: Color(0xFF9b9b9b),
////                                        fontSize: 15,
////                                        fontWeight: FontWeight.normal),
////                                  ),
////
////                                ),
//                          Padding(
//                            padding: const EdgeInsets.all(10.0),
//                            child: FlatButton(
//                                child: Text(_isLoading? 'Proccessing...' : 'UpdateBook',
//                                  textDirection: TextDirection.ltr,
//                                  style: TextStyle(color: Colors.white),),
//                                color: Colors.red,
//
//                                shape: new RoundedRectangleBorder(
//                                    borderRadius:
//                                    new BorderRadius.circular(20.0)),
//                                onPressed: (){
//                                  setState(() {
//                                    updateBook(book);
//                                  });
//                                }
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//
//                  ],
//                ),
//              )
//          );
//        }
//
//    );
//  }
//








//===========ADD BOOK POPUP




//==============ADD DATA fucntion

  void addData() async {
    setState(() {
      _isLoading = true;
    });

    String url = "http://192.168.100.7/LibraryBookLocator/public/api/book";
    //192.168.100.7 myip
    //emulator ip 10.0.2.2
    await http
        .post(url,
        headers: {'Accept': 'application/json'},
        body: ({
          "book_name": _book_name.text,
          "author_name": _author_name.text,
        }))
        .then((response) {
      Navigator.push(context, MaterialPageRoute(
          builder: (context)=>AddBook()
      ));
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


//  void deleteBook(Book book) async{
//
//    String url3 = "http://192.168.100.7/LibraryBookLocator/public/api/deletebook/${book.id}";
//
//      final response = await http.get(url3);
//      if (response.statusCode == 200) {
//        showDialog(
//          context: context,
//          builder: (BuildContext context) {
//            // return object of type Dialog
//            return AlertDialog(
//              title: new Text("deleted:${book.bookName}"),
//              actions: <Widget>[
//                // usually buttons at the bottom of the dialog
//                new FlatButton(
//                  child: new Text("Close"),
//                  onPressed: () {
//                    Navigator.of(context).pop();
//                  },
//                ),
//              ],
//            );
//          },
//        );
//      }
//  }


//  void updateBook(Book book) async{
//
//    String url3 = "http://192.168.100.7/LibraryBookLocator/public/api/updatebook/${book.id}";
//
//    await http
//        .post(url3,
//        headers: {'Accept': 'application/json'},
//        body: ({
//          "book_name": _book_name.text,
//          "author_name": _author_name.text,
//        }))
//        .then((response) {
//      if (response.statusCode == 200) {
//        showDialog(
//          context: context,
//          builder: (BuildContext context) {
//            // return object of type Dialog
//            return AlertDialog(
//              title: new Text("Updated "),
//              actions: <Widget>[
//                // usually buttons at the bottom of the dialog
//                new FlatButton(
//                  child: new Text("Close"),
//                  onPressed: () {
//                    Navigator.of(context).pop();
//                  },
//                ),
//              ],
//            );
//          },
//        );
//      } else {
//        showDialog(
//          context: context,
//          builder: (BuildContext context) {
//            // return object of type Dialog
//            return AlertDialog(
//              title: new Text("Not updated"),
//              actions: <Widget>[
//                // usually buttons at the bottom of the dialog
//                new FlatButton(
//                  child: new Text("close"),
//                  onPressed: () {
//                    Navigator.of(context).pop();
//                  },
//                ),
//              ],
//            );
//          },
//        );
//      }
//    });
//  }
//

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

  final _book_name = TextEditingController();
  final _author_name = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {

    void updateBook(Book book) async{


      String url3 = "http://192.168.100.7/LibraryBookLocator/public/api/updatebook/${book.id}";

      await http
          .post(url3,
          headers: {'Accept': 'application/json'},
          body: ({
            "book_name": _book_name.text,
            "author_name": _author_name.text,
          }))
          .then((response) {
        if (response.statusCode == 200) {
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=>AddBook()
          ));
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: new Text("Updated : ${book.bookName}"),
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
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: new Text("Not updated"),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      });
    }



    void deleteBook(Book book) async{

      String url3 = "http://192.168.100.7/LibraryBookLocator/public/api/deletebook/${book.id}";

      final response = await http.get(url3);
      if (response.statusCode == 200) {
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>AddBook()
        ));
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("deleted : ${book.bookName}   "),
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

    void ShowUpdateDialog(Book book){
      showDialog(context: context,
          builder:(BuildContext context){
            return AlertDialog(
                title: Text("Update Book"),
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
                                  child: Text(_isLoading? 'Proccessing...' : 'UpdateBook',
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(color: Colors.white),),
                                  color: Colors.red,

                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                      new BorderRadius.circular(20.0)),
                                  onPressed: (){
                                    updateBook(book);
                                  }
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
                          padding: const EdgeInsets.fromLTRB(
                              95.0, 10.0, 0, 10.0),
                          child: Text(
                            'Author Name: ${book.authorName}', style: TextStyle(
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
                      RaisedButton(
                        color: Colors.grey,
                        child: Text('Update',style: TextStyle(
                            color: Colors.white
                        ),
                        ),
                        onPressed: (){
                          ShowUpdateDialog(book);
                        },
                      ),
                      RaisedButton(
                        color: Colors.red,
                        child: Text('Delete',style: TextStyle(
                            color: Colors.white
                        ),
                        ),
                        onPressed: (){
                          deleteBook(book);
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
