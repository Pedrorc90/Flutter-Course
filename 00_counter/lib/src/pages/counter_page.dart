import 'package:flutter/material.dart';


class CounterPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _CounterPageState();
  
}


class _CounterPageState extends State<CounterPage> {

  final TextStyle _textStyle = new TextStyle(fontSize: 25);
  int _counter = 0;

   @override
  Widget build(BuildContext context) {
    /* Scaffold is a widget which contains different elements predefined to show in a page */
    return Scaffold(
      /* Bar placed at the top */
      appBar: AppBar(
        title: Text('Stateful'),
        centerTitle: true,
      ),
      /* Body of the page */
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text('Clicks number:', style: _textStyle),
            Text('$_counter', style: _textStyle),
          ],
        )
      ),
      floatingActionButton: _createButtons()
    );
  }


  Widget _createButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(width: 30.0),
        FloatingActionButton(child: Icon(Icons.exposure_zero), onPressed: _reset),
        Expanded(child: SizedBox()),
        FloatingActionButton(child: Icon(Icons.remove), onPressed: _remove),
        SizedBox(width: 5.0),
        FloatingActionButton(child: Icon(Icons.add), onPressed: _add),
      ],
    );
  }


  void _add() {
    setState(() => _counter++);
  }

  void _remove() {
    setState(() => _counter--);
  }

  void _reset() {
    setState(() => _counter = 0);
  }

}