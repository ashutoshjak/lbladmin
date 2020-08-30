//class Book {
//  int id;
//  String bookName;
//  String authorName;
//
//  Book({this.id, this.bookName, this.authorName});
//
//  Book.fromJson(Map<String, dynamic> json) {
//    id = json['id'];
//    bookName = json['book_name'];
//    authorName = json['author_name'];
//  }
//
//}

class Book {
  int id;
  String bookName;
  String authorName;
  String shelfNo;
  String shelfImage;
  String rowNo;
  String columnNo;
  String bookImage;
  String bookQuantity;

  Book({this.id,
    this.bookName,
    this.authorName,
    this.shelfNo,
    this.shelfImage,
    this.rowNo,
    this.columnNo,
    this.bookImage,
    this.bookQuantity});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookName = json['book_name'];
    authorName = json['author_name'];
    shelfNo = json['shelf_no'];
    shelfImage = json['shelf_image'];
    rowNo = json['row_no'];
    columnNo = json['column_no'];
    bookImage = json['book_image'];
    bookQuantity = json['book_quantity'];
  }
}