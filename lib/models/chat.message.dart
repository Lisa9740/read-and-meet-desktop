import 'dart:convert';

import 'package:flutter/cupertino.dart';


String messagesToJson(List<ChatMessage> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

List<ChatMessage> messagesFromJson(String str) => List<ChatMessage>.from(json.decode(str).map((x) => ChatMessage.fromJson(x)));

class ChatMessage extends ChangeNotifier{
  int  id;
  String messageContent;
  int authorId;
  var receiverId;
  var chatId;
  var datetime;



  ChatMessage({required this.id, required this.chatId, required this.messageContent, required this.authorId, required this.receiverId, required this.datetime});

  factory ChatMessage.fromJson(Map<String, dynamic> parsedJson) {
    return ChatMessage(id: parsedJson['id'], chatId: parsedJson['chat_id'], messageContent: parsedJson['message_txt'], authorId: parsedJson['user_id'], receiverId: parsedJson['receiver_id'], datetime: parsedJson['created_at']);
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chatId': chatId,
      'authorId': authorId,
      'receiverId': receiverId,
      'messageContent' : messageContent,
      'datetime' : datetime
    };
  }
}

class ChatMessageList {
  List items = [];

  toJSONEncodable() {
    return items.map((item) {
      return item;
    }).toList();
  }
}