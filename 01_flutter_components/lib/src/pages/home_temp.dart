import 'package:flutter/material.dart';


class HomePageTemp extends StatelessWidget {

  final options = ['Uno', 'Dos', 'Tres', 'Cuatro', 'Cinco'];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Components Temp')
      ),
      body: ListView(
        children: _createItems()
      ),
    );
  }

  List<Widget> _createItems() {

    return options.map((item)  {
      return Column(
        children: [
          ListTile(
            title: Text(item + '!'),
            subtitle: Text('Whatever'),
            leading: Icon(Icons.account_balance_wallet),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              
            },
          ),
          Divider()
        ],
      );
    }).toList();

  }

}