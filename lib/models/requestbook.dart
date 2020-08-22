class RequestsBook {
  int id;
  String bookName;
  String authorName;

  RequestsBook({this.id, this.bookName, this.authorName});

  RequestsBook.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookName = json['book_name'];
    authorName = json['author_name'];
  }
}