import 'package:eventhub_app/features/auth/domain/entities/user.dart';
import 'package:eventhub_app/features/auth/domain/repositories/auth_user_repository.dart';

class UpdateFullNameUseCase {
  final AuthUserRepository authUserRepository;

  UpdateFullNameUseCase(this.authUserRepository);

  Future<User> execute(User userData, String fullName) async {
    return await authUserRepository.updateFullName(userData, fullName);
  }
}
