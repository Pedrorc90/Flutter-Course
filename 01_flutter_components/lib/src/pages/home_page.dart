import 'package:flutter/material.dart';
import 'package:flutter_components/src/providers/menu_provider.dart';
import 'package:flutter_components/src/utils/icon_string_util.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Components')
      ),
      body: _myList(),
    );
  }

  Widget _myList() {
    return FutureBuilder(
      future: menuProvider.loadData(),
      initialData: [],
      builder: ( BuildContext context, AsyncSnapshot<List<dynamic>> snapshot ) {
         return ListView(
          children: _createListItems( snapshot.data??[], context ),
        ); 
      },
    );
  }

  List<Widget> _createListItems(List<dynamic> data, BuildContext context) {

    final List<Widget> options = [];

    data.forEach((opt) {
      final widgetTemp = ListTile(
        title: Text( opt['texto'] ),
        leading: getIcon(opt['icon']),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: (){
          
          /* Traditional way to navigate to other page */
          // final route = MaterialPageRoute(
          //   builder: ( context ) => AlertPage()
          // );
          // Navigator.push(context, route);  
          Navigator.pushNamed(context, opt['ruta']); 
          /* The name of the route should be defined in the MaterialApp of the application
              under routes field */
        },
      );
      options..add(widgetTemp)
             ..add(Divider());
     });

     return options;

     

  }
}