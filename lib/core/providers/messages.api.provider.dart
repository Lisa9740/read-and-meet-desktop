import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../models/chat.message.dart';
import '../api.conf.dart';

class ChatMessageApiProvider with ChangeNotifier {
  final String? authToken;
  ChatMessageApiProvider({this.authToken});
  final successCode = 200;

  List<ChatMessage> messages = [];

  Future<List<ChatMessage>> getMessages() async {
    try {
      var headers = await ApiConf.getHeaders(authToken);
      String url = "${ApiConf.baseUrl}/chat/messages";
      var response = await http.get(Uri.parse(url), headers: headers);
      List<ChatMessage> message =  parseResponse(response);
      print("messages: $message");
      return message;
    } catch (e) {

      print("Une erreur est survenue lors de la récupération des messages ! $e");
      return List<ChatMessage>.empty();
    }
  }


  List<ChatMessage> parseResponse(http.Response response) {
    final responseString = response.body;
    try {
      if (response.statusCode == successCode) {
        notifyListeners();
        return messagesFromJson(responseString);
      }
      throw Exception('failed to load message');
    }catch(e){
      print(e);
      throw Exception('failed to load request');
    }
  }

}