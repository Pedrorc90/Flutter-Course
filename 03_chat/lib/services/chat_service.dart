
import 'package:chat/models/messages_response.dart';
import 'package:chat/models/user.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:chat/global/environment.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {

  User? userTo;


  Future<List<Message>> getChat( String? userId  ) async {
    
    final uri = Uri.parse('${ Environment.apiUrl }/messages/$userId');
    String? token = await AuthService.getToken();
    final res = await http.get( uri, 
      headers: { 
        'Content-Type' : 'application/json',
        'x-token'      : '$token'
      }
    );

    final messagesResponse = messagesResponseFromJson( res.body );

    return messagesResponse.messages;


  }

}

