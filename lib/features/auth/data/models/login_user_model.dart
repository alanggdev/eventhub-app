import 'package:eventhub_app/features/auth/domain/entities/login_user.dart';

class LoginUserModel extends LoginUser {
  LoginUserModel({
    required String email,
    required String password,
  }) : super(
          email: email,
          password: password,
        );

  static Map<String, dynamic> fromEntityToJson(LoginUser data) {
    return {
      'email': data.email,
      'password': data.password,
    };
  }
}
