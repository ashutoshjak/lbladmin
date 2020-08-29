import 'package:flutter/material.dart';
import 'package:lbladmin/models/book.dart';
import 'package:http/http.dart' as http;
import 'package:lbladmin/pages/addbook.dart';

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
                        BookDetailPage(suggestionList[index]))
                );
              }
          );
        });

  }
}

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
