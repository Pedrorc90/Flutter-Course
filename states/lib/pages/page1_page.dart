// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';


class Page1Page extends StatelessWidget {
  const Page1Page({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 1'),
      ),
      body: InfoUser(),
     floatingActionButton: FloatingActionButton( 
      child: Icon( Icons.accessible_sharp ),
      onPressed: () => Navigator.pushNamed(context, 'page2') ),
   );
  }
}

class InfoUser extends StatelessWidget {
  const InfoUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('General', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold )),
          Divider(),

          ListTile( title: Text('Name: ') ),
          ListTile( title: Text('Age: ') ),

          Text('Jobs', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold )),
          Divider(),

          ListTile( title: Text('Profession 1') ),
          ListTile( title: Text('Profession 1') ),

        ],
      )
    );
  }
}