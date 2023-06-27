import 'package:eventhub_app/features/auth/data/models/login_user_model.dart';
import 'package:eventhub_app/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:eventhub_app/features/auth/data/models/register_user_model.dart';
import 'package:eventhub_app/features/auth/domain/entities/register_user.dart';
import 'package:eventhub_app/keys.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';
import 'package:eventhub_app/features/auth/domain/entities/login_user.dart';

abstract class AuthUserDataSource {
  Future<String> registerUser(RegisterUser registerUserData);
  Future<User> loginUser(LoginUser loginUserData);
}

class AuthUserDataSourceImpl extends AuthUserDataSource {
  @override
  Future<String> registerUser(RegisterUser registerUserData) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.http(serverURI, '/auth/register/');

    dynamic body = RegisterUserModel.fromEntityToJson(registerUserData);

    var response =
        await http.post(url, body: convert.jsonEncode(body), headers: headers);

    if (response.statusCode == 201) {
      return 'User created';
    } else if (response.statusCode == 400) {
      var error = convert.jsonDecode(response.body);

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
        throw Exception('User registration failed. Try later');
      }

    } else {
      throw Exception('Server error');
    }
  }

  @override
  Future<User> loginUser(LoginUser loginUserData) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.http(serverURI, '/auth/login/');
    
    dynamic body = LoginUserModel.fromEntityToJson(loginUserData);

    var response =
        await http.post(url, body: convert.jsonEncode(body), headers: headers);

    if (response.statusCode == 200) {
      var jsonDecoded = convert.jsonDecode(response.body);
      return UserModel.fromJson(jsonDecoded);
    } else if (response.statusCode == 400) {
      var error = convert.jsonDecode(response.body);
      if (error['non_field_errors'][0] == 'Unable to log in with provided credentials.') {
        Map<String, dynamic> json = {'access': 'bad credentials', 'refresh': 'bad credentials', 'user': 'error'};
        return UserModel.fromJson(json);
      } else {
        throw Exception('User login failed. Try later');
      }
    } else {
      throw Exception('Server error');
    }
  }
}
