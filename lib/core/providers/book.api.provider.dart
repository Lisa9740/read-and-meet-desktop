import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../models/book.dart';
import '../api.conf.dart';


class BookApiProvider with ChangeNotifier{
  final String? authToken;
  BookApiProvider({this.authToken});
  final successCode = 200;

  getBooks() async{
    String url = "${ApiConf.baseUrl}/book/list";
    var headers = await ApiConf.getHeaders(authToken);
    try {
      var response = await http.get(Uri.parse(url), headers: headers);
      print("testbooks ${response.body}");
      return parseResponse(response);
    } catch (e) {
      print(e);
      return List<Book>.empty();
    }
  }

  List<Book> parseResponse(http.Response response) {
    final responseString = response.body;
    try {
      if (response.statusCode == successCode) {
        return BookFromJson(responseString);
      }
      throw Exception('failed to load books ');
    }catch(e){
      print(e);
      throw Exception('failed to load request');
    }
  }
}