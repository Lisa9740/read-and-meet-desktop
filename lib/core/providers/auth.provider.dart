import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ram_admin/core/api.conf.dart';
import 'package:ram_admin/core/utils/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.conf.dart';
import '../utils/shared.pref.dart';



class AuthApiProvider with ChangeNotifier{
  String? token;

  login(String email, String password) async {
    Map<String, String> headers = {"Content-Type": "application/json; charset=UTF-8"};
    try{
      http.Response response = await http.post(Uri.parse("${ApiConf.baseUrl}/connexion"),
          headers: headers,
          body: jsonEncode({"email": email, "password": password}));
      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse["user"] != null) {
        token = jsonResponse["token"];

       await  Storage().save('user', jsonResponse["user"]);
        await Storage().save('token', token);
        return jsonResponse;
      }else {
        return null;
      }
    } catch(e){
      print(e);
      throw Exception('failed to login to main api');
    }
  }


  void logout() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var headers = await ApiConf.getHeaders(token);
    await http.get(Uri.parse("${ApiConf.baseUrl}/logout"), headers: headers);
    _prefs.remove('token');
    _prefs.remove('profile');
    _prefs.remove('user');
    return;
  }

}