import 'package:eventhub_app/features/auth/domain/entities/register_provider.dart';
import 'package:eventhub_app/features/auth/domain/repositories/auth_user_repository.dart';

class RegisterProviderUseCase {
  final AuthUserRepository authUserRepository;

  RegisterProviderUseCase(this.authUserRepository);

  Future<String> execute(RegisterProvider registerProviderData) async {
    return await authUserRepository.registerProvider(registerProviderData);
  }
}
