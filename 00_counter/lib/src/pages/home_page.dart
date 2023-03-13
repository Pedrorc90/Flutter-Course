import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {

  /* Should be final because we are under a statelesswidget */
  final TextStyle textStyle = new TextStyle(fontSize: 25);
  final counter = 10;

  @override
  Widget build(BuildContext context) {
    /* Scaffold is a widget which contains different elements predefined to show in a page */
    return Scaffold(
      /* Bar placed at the top */
      appBar: AppBar(
        title: Text('Title'),
        centerTitle: true,
      ),
      /* Body of the page */
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text('Clicks number:', style: textStyle),
            Text('$counter', style: textStyle),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.add ),
        onPressed: (){
          print('Hello World');
        },
      )
    );
  }

}