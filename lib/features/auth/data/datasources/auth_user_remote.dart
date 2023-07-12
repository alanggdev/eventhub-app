import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:eventhub_app/keys.dart';

import 'package:eventhub_app/features/auth/domain/entities/register_user.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';
import 'package:eventhub_app/features/auth/domain/entities/login_user.dart';

import 'package:eventhub_app/features/auth/domain/entities/register_provider.dart';
import 'package:eventhub_app/features/auth/data/models/login_user_model.dart';
import 'package:eventhub_app/features/auth/data/models/user_model.dart';
import 'package:eventhub_app/features/auth/data/models/register_user_model.dart';
import 'package:eventhub_app/features/auth/data/models/register_provider_model.dart';

import 'package:eventhub_app/features/provider/domain/entities/service.dart';

abstract class AuthUserDataSource {
  Future<String> registerUser(RegisterUser registerUserData);
  Future<User> loginUser(LoginUser loginUserData);
  Future<String> registerProvider(RegisterProvider registerProviderData);
}

class AuthUserDataSourceImpl extends AuthUserDataSource {
  @override
  Future<String> registerUser(RegisterUser registerUserData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse('$serverURL/auth/register/');

    dynamic body = RegisterUserModel.fromEntityToJson(registerUserData);

    var response =
        await http.post(url, body: convert.jsonEncode(body), headers: headers);

    if (response.statusCode == 201) {
      var data = convert.jsonDecode(response.body);
      await prefs.setInt('userid', data['user']['pk']);
      return 'User created';
    } else if (response.statusCode == 400) {
      var error = convert.jsonDecode(response.body);

      // Verfy if username error exists
      if (error['username'] != null) {
        if (error['username'][0] ==
            'A user with that username already exists.') {
          throw Exception('Usuario o email ya existente.');
        } else {
          throw Exception('User registration failed. Try later.');
        }
      }

      // Verfy if email error exists
      if (error['email'] != null) {
        if (error['email'][0] ==
            'A user is already registered with this e-mail address.') {
          throw Exception('Usuario o email ya existente.');
        } else {
          throw Exception('User registration failed. Try later.');
        }
      }

      // Verfy if pass error exists
      if (error['password1'] != null) {
        throw Exception('Contraseña no válida. Intente otra.');
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
    var url = Uri.parse('$serverURL/auth/login/');

    dynamic body = LoginUserModel.fromEntityToJson(loginUserData);

    var response =
        await http.post(url, body: convert.jsonEncode(body), headers: headers);

    if (response.statusCode == 200) {
      var jsonDecoded = convert.jsonDecode(response.body);
      return UserModel.fromJson(jsonDecoded);
    } else if (response.statusCode == 400) {
      var error = convert.jsonDecode(response.body);
      if (error['non_field_errors'][0] ==
          'Unable to log in with provided credentials.') {
        Map<String, dynamic> json = {
          'access': 'bad credentials',
          'refresh': 'bad credentials',
          'user': 'error'
        };
        return UserModel.fromJson(json);
      } else {
        throw Exception('User login failed. Try later');
      }
    } else {
      throw Exception('Server error');
    }
  }

  @override
  Future<String> registerProvider(RegisterProvider registerProviderData) async {
    // Get user id
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userid = prefs.getInt('userid');
    await prefs.remove('userid');

    // Register provider
    List<MultipartFile> imageMultipartFiles = [];
    for (File file in registerProviderData.imagesList!) {
      MultipartFile multipartFile = await MultipartFile.fromFile(file.path);
      imageMultipartFiles.add(multipartFile);
    }

    final formData = RegisterProviderModel.fromEntityToJson(registerProviderData, imageMultipartFiles, userid!);
    final dio = Dio();
    final response = await dio.post('$serverURL/providers/', data: formData);

    if (response.statusCode == 201) {
      await registerServices(registerProviderData.services!, response.data['providerId']);
      return 'Provider created';
    } else {
      throw Exception('Server error');
    }
  }

  Future<String> registerServices(List<Service> services, int providerid) async {
    List<MultipartFile> imageMultipartFiles = [];
    List<dynamic> servicesToUpload = [];
    for (Service service in services) {
      for (File file in service.images!) {
        MultipartFile multipartFile = await MultipartFile.fromFile(file.path);
        imageMultipartFiles.add(multipartFile);
      }
      dynamic body = {
        "providerId": providerid,
        "name": service.name,
        "description": service.description,
        "tags": service.tags,
        "amountImages": service.images?.length
      };
      servicesToUpload.add(body);
    }

    final formData = FormData.fromMap({
      'services': servicesToUpload,
      'images' : imageMultipartFiles
    });

    final dio = Dio();
    final response = await dio.post('$serverURL/services/', data: formData);

    if (response.statusCode == 201) {
      return 'Services created';
    } else {
      throw Exception('Server error (providers)');
    }
  }
}
