import 'package:eventhub_app/features/auth/domain/entities/login_user.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';
import 'package:eventhub_app/features/auth/domain/repositories/auth_user_repository.dart';

class LoginUserUseCase {
  final AuthUserRepository authUserRepository;

  LoginUserUseCase(this.authUserRepository);

  Future<User> execute(LoginUser loginUserData) async {
    return await authUserRepository.loginUser(loginUserData);
  }
}
