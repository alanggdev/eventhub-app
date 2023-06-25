import 'package:eventhub_app/features/auth/domain/entities/register_user.dart';
import 'package:eventhub_app/features/auth/domain/repositories/auth_user_repository.dart';

class RegisterUserUseCase {
  final AuthUserRepository authUserRepository;

  RegisterUserUseCase(this.authUserRepository);

  Future<String> execute(RegisterUser registerUserData) async {
    return await authUserRepository.registerUser(registerUserData);
  }
}
