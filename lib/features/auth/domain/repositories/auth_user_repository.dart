import 'package:eventhub_app/features/auth/domain/entities/login_user.dart';
import 'package:eventhub_app/features/auth/domain/entities/register_user.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';

abstract class AuthUserRepository {
  Future<String> registerUser(RegisterUser registerUserData);
  Future<User> loginUser(LoginUser loginUserData);
}