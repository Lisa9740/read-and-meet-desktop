import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ram_admin/core/api.conf.dart';
import 'package:ram_admin/core/utils/storage.dart';
import 'package:ram_admin/models/profile.dart';
import 'package:ram_admin/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/shared.pref.dart';

//import '../common/utils/shared.pref.dart';

class UserApiProvider with ChangeNotifier{
  final String? authToken;
  UserApiProvider({this.authToken});

  final successCode = 200;
  User currentUser = User.empty;
  User otherUser = User.empty;
  Profile currentProfile = Profile.empty;
  List<User> users = [];

  Future<User> getCurrent() async{
    var data = await Storage().get("user");
    if (data != null){
      var user = jsonDecode(data);
      currentUser = User.fromJson(user);
      notifyListeners();
      return currentUser;
    }
    return User.empty;
  }

  Future<Profile> getCurrentProfile() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var data = _prefs.getString("profile");
    if (data != null){
      var user = jsonDecode(data);
      currentProfile = Profile.fromJson(user);
      notifyListeners();
      return currentProfile;
    }
    return Profile.empty;
  }


  Future changeAvatar(image) async {
    String url = "${ApiConf.baseUrl}/user/update/avatar";
    try {
      var token = await SharedPref.getToken();

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(ApiConf.getAuthorizationHeaders(token));

      request.fields["image"] = image.path;
      request.fields["url"] = ApiConf.mainBaseUrl;

      http.MultipartFile multipartFile = http.MultipartFile("image", File(image.path).readAsBytes().asStream(),
          File(image.path).lengthSync(), filename: image.path.split("/").last);

      request.files.add(multipartFile);

      var res = await request.send();
      var responsed = await http.Response.fromStream(res);
      if (res.statusCode == 200) {
        var user = jsonDecode(responsed.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove("user");
        await SharedPref.updateUserInfo(jsonEncode({"user": user}));
        print(user);

        print("Image Uploaded");
      } else {
        print("Upload Failed");
      }

      return res;
    } catch (e) {
      return List<User>.empty();
    }
  }



  Future<User> getById(id) async{
    try {
      var header = await ApiConf.getHeaders(authToken);
      http.Response response = await http.get(Uri.parse("${ApiConf.baseUrl}/user/$id"), headers: header);
      if (response.statusCode == successCode) {
        var data = jsonDecode(response.body);
        otherUser = User.fromJson(data);
        notifyListeners();
        return User.fromJson(data);
      }
      return User.empty;
    }catch(e){
      throw Exception();
    }
  }

  Future<List<User>> fetchUsers() async {
    var headers = await ApiConf.getHeaders(authToken);
    String url = "${ApiConf.baseUrl}/users";
    try {
      var response = await http.get(Uri.parse(url), headers: headers);
      return parseResponse(response);
    } catch (e) {
      return List<User>.empty();
    }
  }


  Future<List<User>> parseResponse(http.Response response) async {
    final responseString = response.body;
    if (response.statusCode == successCode) {
      users = userFromJson(responseString);
      notifyListeners();
      return userFromJson(responseString);
    } else {
      throw Exception('failed to load users');
    }
  }
}