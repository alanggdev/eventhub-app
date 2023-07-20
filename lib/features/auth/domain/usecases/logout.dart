import 'package:eventhub_app/features/auth/domain/entities/user.dart';
import 'package:eventhub_app/features/auth/domain/repositories/auth_user_repository.dart';

class LogOutUseCase {
  final AuthUserRepository authUserRepository;

  LogOutUseCase(this.authUserRepository);

  Future<String> execute(User user) async {
    return await authUserRepository.logOut(user);
  }
}
