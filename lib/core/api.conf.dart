
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:ram_admin/core/utils/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiConf {
  //static String baseUrl = "http://readandmeet-backend.barret-alison-dev.xyz/api";
// static String baseUrl ="http://rad-backend.barret-alison-dev.xyz/api";
 //static String mainBaseUrl ="http://rad-backend.barret-alison-dev.xyz";
 static String mainBaseUrl ="http:///127.0.0.1:8000";
 static String baseUrl ="http://127.0.0.1:8000/api";

  static String socketUrl = "http://10.0.2.2:6000";
//  static String socketUrl = "http://rad-backend-ws.barret-alison-dev.xyz";


 static getBaseUrl(){
    if (defaultTargetPlatform != TargetPlatform.android){
        return  "http://127.0.0.1:8000/api";
    }else {
      return "http://10.0.2.2:8000/api";
    }
  }
  // get token from localStorage;
  static getToken() async{
    var token  = await Storage().get('token');
    return token;
  }

  static getAuthorizationHeaders(token) {
   return {"Authorization" : 'Bearer $token'};
  }

  static getHeaders(token)  async {
    Map<String, String> headers = {"Content-Type": "application/json; charset=UTF-8"};
    token = await getToken();
    if (token != null){
      var formattedToken = token;
      var basicToken = 'Bearer $formattedToken';
      headers = {HttpHeaders.authorizationHeader: basicToken,
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Credentials": 'true', // Required for cookies, authorization headers with HTTPS,
        "Access-Control-Allow-Methods": "POST, OPTIONS, GET"
      };
      return headers;
    }
    return headers;
  }

  static getMultiPartHeaders(token)  async {
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };
    token = await getToken();
    if (token != null){
      var formattedToken = token;
      var basicToken = 'Bearer $formattedToken';
      headers = {HttpHeaders.authorizationHeader: basicToken,
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Credentials": 'true', // Required for cookies, authorization headers with HTTPS,
        "Access-Control-Allow-Methods": "POST, OPTIONS, GET"
      };
      return headers;
    }
    return headers;
  }
}