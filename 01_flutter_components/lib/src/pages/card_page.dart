import 'package:flutter/material.dart';


class CardPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards')
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: [
          _cardType1(),
          SizedBox(height:30.0),
          _cardType2(),
          SizedBox(height:30.0),
          _cardType2(),
          SizedBox(height:30.0),
          _cardType2(),
          SizedBox(height:30.0),
          _cardType2(),
          SizedBox(height:30.0),
          _cardType2(),
          SizedBox(height:30.0),
        ],
      ),
    );
  }

  Widget _cardType1() {

    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0))
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.photo_album, color: Colors.blue,),
            title: Text('I am the title of this card'),
            subtitle: Text('Here we are with the description that we are implementing to show properly the description'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                onPressed: () {}, 
                child: Text('Cancel')
              ),
              FlatButton(
                onPressed: () {}, 
                child: Text('Ok')
              ),
            ],
          )
        ],
      ),
    );

  }

  Widget _cardType2() {

    final card = Container(
      // clipBehavior: Clip.antiAlias,

      child: Column(
        children: [
          FadeInImage(  
            image: NetworkImage('https://images.unsplash.com/photo-1484591974057-265bb767ef71?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80'),
            placeholder: AssetImage('assets/jar-loading.gif'),
            fadeInDuration: Duration(milliseconds: 2000),
            height: 300.0,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('I have no idea what write here'),
          )
          
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 10.0)
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: card),
    );
  }
}