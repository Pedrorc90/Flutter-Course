import 'package:band_names/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class StatusPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Server status: ${ socketService.serverStatus }')
          ],
        )
     ),
     floatingActionButton: FloatingActionButton(
      child: Icon(Icons.message),
      elevation: 5,
      onPressed: () {
          socketService.socket.emit('emit-message', {'name': 'Flutter', 'message': 'Hello from flutter'});
      },
     ),
   );
  }

  
}