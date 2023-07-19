import 'package:eventhub_app/features/auth/domain/entities/register_user.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';
import 'package:eventhub_app/features/auth/domain/repositories/auth_user_repository.dart';

class UpdateUserUseCase {
  final AuthUserRepository authUserRepository;

  UpdateUserUseCase(this.authUserRepository);

  Future<User> execute(User userData, RegisterUser registerUserData) async {
    return await authUserRepository.updateUser(userData, registerUserData);
  }
}
