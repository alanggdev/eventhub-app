import 'package:eventhub_app/features/auth/data/datasources/auth_user_remote.dart';
import 'package:eventhub_app/features/auth/data/repositories/auth_user_repository_impl.dart';
import 'package:eventhub_app/features/auth/domain/usecases/login_user.dart';
import 'package:eventhub_app/features/auth/domain/usecases/register_user.dart';

class UseCaseConfig {
  AuthUserDataSourceImpl? authUserDataSourceImpl;
  AuthUserRepositoryImpl? authUserRepositoryImpl;
  RegisterUserUseCase? registerUserUseCase;
  LoginUserUseCase? loginUserUseCase;

  UseCaseConfig() {
    authUserDataSourceImpl = AuthUserDataSourceImpl();
    authUserRepositoryImpl = AuthUserRepositoryImpl(authUserDataSource: authUserDataSourceImpl!);
    registerUserUseCase = RegisterUserUseCase(authUserRepositoryImpl!);
    loginUserUseCase = LoginUserUseCase(authUserRepositoryImpl!);
  }
}