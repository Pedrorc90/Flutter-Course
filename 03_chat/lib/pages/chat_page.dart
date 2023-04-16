import 'dart:io';

import 'package:chat/models/messages_response.dart';
import 'package:chat/models/user.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChatPage extends StatefulWidget {

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {


  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isWriting = false;
  ChatService? chatService;
  SocketService? socketService;
  AuthService? authService;

  List<ChatMessage> _messages = [];


  @override
  void initState() {
    super.initState();
    chatService   = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService   = Provider.of<AuthService>(context, listen: false);

    socketService?.socket.on('message-personal', _listenMessage );

    _loadHistory( chatService?.userTo?.uid );
  }

    void _loadHistory(String? uid) async {
      
      List<Message>? chat = await chatService?.getChat(uid);

      final history = chat?.map((m) => ChatMessage(
        text: m.message, 
        uid: m.from, 
        animationController: AnimationController( vsync: this, duration: Duration( milliseconds: 0 ) )..forward()
       ));

       setState(() {
         _messages.insertAll(0, history ?? []);
       });


  }

  void _listenMessage( dynamic payload ) {
    ChatMessage newMessage = ChatMessage(
      text: payload['message'], 
      uid: payload['from'], 
      animationController: AnimationController( vsync: this, duration: Duration( milliseconds: 300 ) )
    );
    setState(() {
      _messages.insert(0, newMessage);
    });
    newMessage.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {

    final User? userTo = chatService?.userTo;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              maxRadius: 14,
              child: Text(userTo?.name.substring(0,2) ?? '', style: TextStyle(fontSize: 12)),
            ),
            SizedBox(height: 3),
            Text(userTo?.name ?? '', style: TextStyle(color: Colors.black87, fontSize: 12))
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: ( _, i ) => _messages[i],
                reverse: true
              )
            ),
            Divider(height: 1),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      )
   );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric( horizontal: 8 ),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: ( text ) {
                  setState(() {
                    _isWriting = text.trim().isNotEmpty;
                    //if ( text.trim().length > 0 )
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Send message',
                ),
                focusNode: _focusNode,
              )
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS 
                ? CupertinoButton(
                    onPressed: _isWriting ? () => _handleSubmit( _textController.text ) : null, 
                    child: Text('Send'),
                  )
                : Container(
                  margin: EdgeInsets.symmetric( horizontal: 4 ),
                  child: IconTheme(
                    data: IconThemeData( color: Colors.blue.shade400 ),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon(Icons.send),
                      onPressed: _isWriting ? () => _handleSubmit( _textController.text ) : null,
                    ),
                  ),
                )
            )
          ],
        )
      )
    );
  }

  _handleSubmit( String text ) {
    if ( text.isEmpty ) return;
    _textController.clear();
    _focusNode.requestFocus();


    final newMessage = ChatMessage(text: text, 
                                  uid: authService?.user?.uid ?? '', animationController: 
                                  AnimationController( vsync: this, duration: Duration( milliseconds: 200 ) )
                                  );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _isWriting = false;
    });

    socketService?.emit('message-personal', {
      'from'    : authService?.user?.uid,
      'to'      : chatService?.userTo?.uid,
      'message' : text
    });

  }

  @override
  void dispose() {
    //TODO: Off del socket

    for( ChatMessage message in _messages ){
      message.animationController.dispose();
    }

    socketService?.socket.off('message-personal');
    super.dispose();
  }
  

}