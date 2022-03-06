import 'dart:convert';


String profileToJson(List<Profile> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

List<Profile> profileFromJson(String str) => List<Profile>.from(json.decode(str).map((x) => Profile.fromJson(x)));

class Profile {
  final int? id;
  final String? photo;
  final String? description;
  final isVisible;
  final String? bookLiked;

  Profile({
    required this.id,
    required this.photo,
    required this.description,
    required this.isVisible,
    required this.bookLiked,

  });

  static final empty = Profile(
      id: 0,
      photo: "",
      description: "",
      isVisible: 0,
      bookLiked: ""
  );

  factory Profile.fromJson(Map<String, dynamic> json) {
    // Map<String, dynamic> json = jsonDecode(data);
    return Profile(
      id: json['id'],
      photo: json['photo'],
      description: json['description'],
      isVisible: json['is_visible'],
      bookLiked: json['book_liked'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'photo': photo,
      'description': description,
      'isVisible': isVisible,
      'bookLiked': bookLiked,
    };
  }
}