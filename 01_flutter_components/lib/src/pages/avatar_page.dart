import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avatar Page'),
        actions: [
          Container(
            padding: EdgeInsets.all(5.0),
            child: CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage('https://media.npr.org/assets/img/2018/11/12/gettyimages-615970090_slide-ccaf8044e851e59fd8fd78a184d2d4104dd04f84.jpg'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              child: Text('PR'),
              backgroundColor: Colors.brown,
            ),
          )
        ],
      ),
      body: Center(
        child: FadeInImage(
          fadeInDuration: Duration(milliseconds: 200),
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage('https://media.npr.org/assets/img/2018/11/12/gettyimages-615970090_slide-ccaf8044e851e59fd8fd78a184d2d4104dd04f84.jpg'),
        ),
      ),
    );
  }
}