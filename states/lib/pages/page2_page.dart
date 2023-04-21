// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class Page2Page extends StatelessWidget {
  const Page2Page({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.blue,
              onPressed: () {},
              child: Text('Establish User', style: TextStyle( color: Colors.white )),
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {},
              child: Text('Change Age', style: TextStyle( color: Colors.white )),
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {},
              child: Text('Add Profession', style: TextStyle( color: Colors.white )),
            )
          ],
        )
     ),
   );
  }
}