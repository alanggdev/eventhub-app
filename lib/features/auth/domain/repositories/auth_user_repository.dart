import 'package:eventhub_app/features/auth/domain/entities/login_user.dart';
import 'package:eventhub_app/features/auth/domain/entities/register_provider.dart';
import 'package:eventhub_app/features/auth/domain/entities/register_user.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';

abstract class AuthUserRepository {
  Future<String> registerUser(RegisterUser registerUserData);
  Future<User> loginUser(LoginUser loginUserData);
  Future<String> registerProvider(RegisterProvider registerProviderData);
  Future<User> googleLogin();
  Future<User> updateUser(User userData, RegisterUser registerUserData);
}