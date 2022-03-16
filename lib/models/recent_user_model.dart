import 'dart:core';

class RecentUser {
  String? icon, name, role, email;
  List? posts;
   var date;

  RecentUser(
      {this.icon, this.name, required this.date, required this.posts, this.role, this.email});

  RecentUser.fromJson(Map<String, dynamic> json) {
    icon = json['userPicture'];
    name = json['name'];
    date = json['createdAt'];
    posts = json['posts'];
    role = "Utilisateurs";
    email = json['email'];
  }

}

List recentUsers = [
  RecentUser(
    icon: "assets/icons/xd_file.svg",
    name: "Deniz Çolak",
    role: "Software Architect",
    email: "de***ak@huawei.com",
    date: DateTime(01-03-2021),
    posts: [],
  ),
  RecentUser(
    icon: "assets/icons/Figma_file.svg",
    name: "S*** Ç****",
    role: "Software Engineer",
    email: "se****k1@google.com",
    date:  DateTime(01-03-2021),
    posts: [],
  ),
  RecentUser(
    icon: "assets/icons/doc_file.svg",
    name: "N***** D****",
    role: "Solution Architect",
    email: "ne****tr@google.com",
    date:  DateTime(01-03-2021),
    posts: [],
  ),
  RecentUser(
    icon: "assets/icons/sound_file.svg",
    name: "B***** K****",
    role: "Project Manager",
    email: "bu****lk@google.com",
    date:  DateTime(01-03-2021),
    posts: [],
  ),
  RecentUser(
    icon: "assets/icons/media_file.svg",
    name: "A**** S**** K****",
    role: "Line Manager",
    email: "ah****az@google.com",
    date: DateTime(23-02-2021),
    posts: [],
  ),
  RecentUser(
    icon: "assets/icons/pdf_file.svg",
    name: "T***** S****",
    role: "UI/UX Designer",
    email: "te****cu@google.com",
    date:  DateTime(01-03-2021),
    posts: [],
  ),
  RecentUser(
    icon: "assets/icons/excle_file.svg",
    name: "K***** D****",
    role: "Business Analyst",
    email: "ke****an@gmail.com",
    date:  DateTime(01-03-2021),
    posts: [],
  ),
];
