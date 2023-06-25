import 'package:eventhub_app/features/auth/domain/entities/register_user.dart';

abstract class AuthUserRepository {
  Future<String> registerUser(RegisterUser registerUserData);
}