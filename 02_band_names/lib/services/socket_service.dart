

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket; // Include late to remove error in null-safety

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    // Dart client
    this._socket = IO.io('https://zero2-flutter-socket-io.onrender.com', {
      'transports': ['websocket'],
      'autoConnect': true
    });
    this._socket.onConnect(( _ ) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    this._socket.onDisconnect(( _ ) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

  }


}
