class Book {
  int id;
  String bookName;
  String authorName;

  Book({this.id, this.bookName, this.authorName});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookName = json['book_name'];
    authorName = json['author_name'];
  }

}