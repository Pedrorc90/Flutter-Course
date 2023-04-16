


import 'package:chat/models/users_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:chat/models/user.dart';
import 'package:chat/global/environment.dart';
class UsersService {

  Future<List<User>> getUsers() async {

    try {
      final uri = Uri.parse('${ Environment.apiUrl }/users');
      String? token = await AuthService.getToken();
      final res = await http.get(uri, 
        headers: {
          'Content-Type': 'application/json',
          'x-token'     : '$token'
        }
      );

      final usersResponse = usersResponseFromJson( res.body );

      return usersResponse.users;


    } catch( e ) {
      return [];
    }
  }

}