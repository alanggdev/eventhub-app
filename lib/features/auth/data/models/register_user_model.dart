import 'package:eventhub_app/features/auth/domain/entities/register_user.dart';

class RegisterUserModel extends RegisterUser {
  RegisterUserModel({
    required String username,
    required String fullname,
    required String email,
    required String password,
    required bool isprovider,
  }) : super(
            username: username,
            fullname: fullname,
            email: email,
            password: password,
            isprovider: isprovider);

  static Map<String, dynamic> fromEntityToJson(RegisterUser data) {
    return {
      'username': data.username,
      'full_name': data.fullname,
      'email': data.email,
      'password1': data.password,
      'password2': data.password,
      'is_provider': data.isprovider,
    };
  }
}
