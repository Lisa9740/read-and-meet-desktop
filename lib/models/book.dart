import 'dart:convert';

String BookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

List<Book> BookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

class Book{
  final int? id;
  final String title;
  final String description;
  final String author;
  final String? cover;
  final price;
  final int? postId;

  Book({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.price,
    this.cover,
    this.postId,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        author: json['author'],
        cover: json['cover'],
        price: json['price'],
        postId: json['post_id']

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title':title,
      'description': description,
      'author': author,
      'cover' : cover,
      'price' : price,
      'postId' : postId
    };
  }
}