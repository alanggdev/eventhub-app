import 'package:eventhub_app/features/auth/data/datasources/auth_user_remote.dart';
import 'package:eventhub_app/features/auth/domain/entities/register_user.dart';
import 'package:eventhub_app/features/auth/domain/repositories/auth_user_repository.dart';

class AuthUserRepositoryImpl implements AuthUserRepository {
  final AuthUserDataSource authUserDataSource;

  AuthUserRepositoryImpl({required this.authUserDataSource});

  @override
  Future<String> registerUser(RegisterUser registerUserData) async {
    return await authUserDataSource.registerUser(registerUserData);
  }
}