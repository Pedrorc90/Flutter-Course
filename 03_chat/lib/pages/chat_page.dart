import 'dart:io';

import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {


  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isWriting = false;

  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text('Te', style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.blue.shade100,
              maxRadius: 14,
            ),
            SizedBox(height: 3),
            Text('Melissa Flores', style: TextStyle(color: Colors.black87, fontSize: 12))
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
                                  uid: '123', animationController: 
                                  AnimationController( vsync: this, duration: Duration( milliseconds: 200 ) )
                                  );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _isWriting = false;
    });

  }

  @override
  void dispose() {
    //TODO: Off del socket

    for( ChatMessage message in _messages ){
      message.animationController.dispose();
    }

    super.dispose();
  }
}