import 'package:contador/src/pages/counter_page.dart';
import 'package:flutter/material.dart';

/* Stateless Widget of application */
class MyApp extends StatelessWidget {

  /* We need to override the build method from stateless widget in 
     order to set our current widget*/
  @override
  Widget build( context ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      /* We can use Center Widget in order to center whatever element */
      home: Center(
        child: CounterPage()
      )
    );
  }

}