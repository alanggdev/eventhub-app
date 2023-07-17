import 'package:eventhub_app/features/auth/domain/entities/user.dart';
import 'package:eventhub_app/features/auth/domain/repositories/auth_user_repository.dart';

class GoogleLoginUseCase {
  final AuthUserRepository authUserRepository;

  GoogleLoginUseCase(this.authUserRepository);

  Future<User> execute() async {
    return await authUserRepository.googleLogin();
  }
}
