import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert Page')
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Show alert'),
          color: Colors.blue,
          textColor: Colors.white,
          shape: StadiumBorder(),
          onPressed: (){_showAlert(context);},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context, 
      barrierDismissible: true, 
      builder: (BuildContext context) { 
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
          ),
          title: Text ('Alert title'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('This is the content of the alert'),
              FlutterLogo( size: 100.0 )
            ],
          ),
          actions: [
            FlatButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: Text('Cancel')
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: Text('Ok')
            ),
          ],
        );
      }
    );
  }
}