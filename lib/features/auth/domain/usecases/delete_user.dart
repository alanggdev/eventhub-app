import 'package:eventhub_app/features/auth/domain/repositories/auth_user_repository.dart';

class DeleteUserUseCase {
  final AuthUserRepository authUserRepository;

  DeleteUserUseCase(this.authUserRepository);

  Future<String> execute(String username) async {
    return await authUserRepository.deleteUser(username);
  }
}
