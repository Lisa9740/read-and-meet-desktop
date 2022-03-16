import 'dart:convert';


String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

class User{
  int id;
  String email;
  String name;
  String userPicture;
  int profileId;
  String gender;
  String age;
  List posts;
  var createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.userPicture,
    required this.age,
    required this.gender,
    required this.profileId,
    required this.posts,
    required this.createdAt
  });

  static final empty = User(
      id: 0,
      name: "",
      email: "",
      gender: "",
      age: "" ,
      userPicture: "",
      profileId: 0,
      posts: [],
      createdAt: new DateTime.now()
  );

  factory User.fromJson( Map<String, dynamic> json) {
    if (json['user'] != null) {
      return User(
          id: json['user']['id'],
          email: json['user']['email'],
          name: json['user']['name'],
          age: json['user']['age'],
          gender: json['user']['gender'],
          userPicture: json['user']['user_picture'],
          profileId: json['user']['profile_id'],
          posts: json['user']['posts'],
          createdAt: json['user']['created_at']
      );
    }
    return User(
        id: json['id'],
        email: json['email'],
        name: json['name'],
        age : json['age'],
        gender: json['gender'],
        userPicture: json['user_picture'],
        profileId: json['profile_id'],
        posts: json['posts'],
        createdAt: json['created_at']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'age': age,
      'genre' : gender,
      'userPicture': userPicture,
      'account': profileId,
      'posts': posts,
      'createdAt' : createdAt.toString()
    };
  }
}