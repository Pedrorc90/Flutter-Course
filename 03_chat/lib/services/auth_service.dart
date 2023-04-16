

import 'dart:convert';

import 'package:chat/global/environment.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/user.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {

  User? user;
  bool _authenticating = false;

  // Create storage
  final _storage = FlutterSecureStorage();

  bool get authenticating => _authenticating;
  set authenticating( bool value ) { 
    _authenticating = value;
    notifyListeners();
  }

  // Static token getters
  static Future<String?> getToken() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }


  Future<bool> login( String email, String password ) async {

    authenticating = true;

    final data = {
      'email'     : email,
      'password'  : password
    };

    final uri = Uri.parse('${ Environment.apiUrl }/login');
    final resp = await http.post(uri ,
      body: jsonEncode(data),
      headers: { 'Content-Type' : 'application/json' }
    );
    authenticating = false;
    if ( resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson( resp.body );
      user = loginResponse.user;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      return false;
    }


  }

  
  Future register( String name, String email, String password ) async {

    authenticating = true;

    final data = {
      'name'      : name,
      'email'     : email,
      'password'  : password
    };
    final uri = Uri.parse('${ Environment.apiUrl }/login/new');
    final resp = await http.post(uri, 
      headers: { 'Content-Type' : 'application/json' },
      body: jsonEncode(data)
    );
    authenticating = false;
    if ( resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson( resp.body );
      user = loginResponse.user;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }

  }

  Future<bool> isLoggedIn() async {
    final token  = await _storage.read( key: 'token' );

    final uri = Uri.parse('${ Environment.apiUrl }/login/renew');
    
    final resp = await http.get( uri, headers: { 'Content-Type' : 'application/json', 'x-token' : token.toString() } );

    if ( resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson( resp.body );
      await _saveToken(loginResponse.token);
      return true;
    } else {
      logout();
      return false;
    }
    
  }

  Future _saveToken( String token ) async => await _storage.write( key: 'token', value: token );
  Future logout() async => await _storage.delete(key: 'token');
  


}