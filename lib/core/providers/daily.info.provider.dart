import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:ram_admin/core/providers/user.provider.dart';
import 'package:ram_admin/models/chat.message.dart';
import 'package:ram_admin/models/user.dart';

import '../../models/book.dart';
import '../../models/daily_info_model.dart';
import '../constants/color_constants.dart';
import 'book.api.provider.dart';
import 'messages.api.provider.dart';


class DailyInfoProvider with ChangeNotifier{
  final String? authToken;
  DailyInfoProvider({this.authToken});

  final successCode = 200;
  //List<DailyInfoModel> dailyInfo = [];


  Future<DailyInfoModel> userDailyInfo(List<User> users) async{
    return DailyInfoModel.fromJson({
      "title" : "Utilisateurs",
      "volumeData": users.length,
      "icon": FlutterIcons.user_alt_faw5s,
      "totalStorage": "+ %20",
      "color": primaryColor,
      "percentage": 35,
      "colors": [
        Color(0xff23b6e6),
        Color(0xff02d39a),
      ],
      "spots": List<FlSpot>.empty()
    });
  }

  bookDailyInfo(List<Book> books) {
    return DailyInfoModel.fromJson({
      "title": "Livres ajouté(s)",
      "volumeData": books.length,
      "icon": FlutterIcons.heart_faw5s,
      "totalStorage": "",
      "color": Color(0xFFd50000),
      "percentage": 10,
      "colors": [Color(0xff93291E), Color(0xffED213A)],
      "spots":List<FlSpot>.empty()});
  }

  messagesDailyInfo(List<ChatMessage> messages)  {
    return DailyInfoModel.fromJson({
      "title": "Messages",
      "volumeData": messages.length,
      "icon": FlutterIcons.comment_alt_faw5s,
      "totalStorage": "+ %8",
      "color": Color(0xFFA4CDFF),
      "percentage": 10,
      "colors": [Color(0xff2980B9), Color(0xff6DD5FA)],
      "spots": List<FlSpot>.empty()});
  }

  Future<List<DailyInfoModel>> fetchDailyInfo(context) async {
    List<User> users =  await Provider.of<UserApiProvider>(context, listen: false).fetchUsers();
    List<ChatMessage> messages = await Provider.of<ChatMessageApiProvider>(context, listen: false).getMessages();
    List<Book> books = await Provider.of<BookApiProvider>(context, listen: false).getBooks();


    List<DailyInfoModel> dailyInfo = [];
    if (users.isNotEmpty) {
      for (int i = 0; i < 3; i++) {
        print("i $i");
        if (i == 0) {
          dailyInfo.add(await userDailyInfo(users));
        } else if (i == 1) {
          dailyInfo.add(await messagesDailyInfo(messages));
        } else {
          dailyInfo.add(await bookDailyInfo(books));
        }
      }
    }

    return dailyInfo;
  }



}