import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:eventhub_app/features/auth/data/models/register_user_model.dart';
import 'package:eventhub_app/features/auth/domain/entities/register_user.dart';
import 'package:eventhub_app/keys.dart';

abstract class AuthUserDataSource {
  Future<String> registerUser(RegisterUser registerUserData);
}

class AuthUserDataSourceImpl extends AuthUserDataSource {
  @override
  Future<String> registerUser(RegisterUser registerUserData) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.https(authServerURI, '/auth/register/');

    dynamic body = RegisterUserModel.fromEntityToJson(registerUserData);

    var response =
        await http.post(url, body: convert.jsonEncode(body), headers: headers);

    if (response.statusCode == 201) {
      return 'User created';
    } else if (response.statusCode == 400) {
      var error = convert.jsonDecode(response.body);

      print(error);

      // Verfy if username error exists
      if (error['username'] != null) {
        if (error['username'][0] ==
            'A user with that username already exists.') {
          return 'Usuario o email ya existente.';
        } else {
          throw Exception('User registration failed. Try later.');
        }
      } 
      
      // Verfy if email error exists
      if (error['email'] != null) {
        if (error['email'][0] ==
            'A user is already registered with this e-mail address.') {
          return 'Usuario o email ya existente.';
        } else {
          throw Exception('User registration failed. Try later.');
        }
      } 
      
      // Verfy if pass error exists
      if (error['password1'] != null) {
         return 'Contraseña no válida. Intente otra.';
      } else {
        throw Exception('User registration failed. Try later.');
      }

    } else {
      throw Exception('Server error.');
    }
  }
}
