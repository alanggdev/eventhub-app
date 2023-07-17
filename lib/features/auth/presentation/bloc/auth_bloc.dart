import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/features/auth/domain/entities/register_user.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';
import 'package:eventhub_app/features/auth/domain/entities/login_user.dart';
import 'package:eventhub_app/features/auth/domain/entities/register_provider.dart';

import 'package:eventhub_app/features/auth/domain/usecases/register_user.dart';
import 'package:eventhub_app/features/auth/domain/usecases/login_user.dart';
import 'package:eventhub_app/features/auth/domain/usecases/google_login.dart';
import 'package:eventhub_app/features/auth/domain/usecases/register_provider.dart';
import 'package:eventhub_app/features/auth/domain/usecases/update_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UpdateUserUseCase updateUserUseCase;
  final GoogleLoginUseCase googleLoginUseCase;
  final RegisterProviderUseCase registerProviderUseCase;
  final LoginUserUseCase loginUserUseCase;
  final RegisterUserUseCase registerUserUseCase;

  AuthBloc(
      {required this.registerUserUseCase,
      required this.loginUserUseCase,
      required this.registerProviderUseCase,
      required this.googleLoginUseCase,
      required this.updateUserUseCase})
      : super(InitialState()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is CompleteGoogleLogIn) {
          try {
            emit(CompletingGoogleLogIn());
            User user = await updateUserUseCase.execute(event.userData, event.registerData);
            emit(GoogleLogInCompleted(user: user));
          } catch (error) {
            emit(Error(error: error.toString()));
          }
        } else if (event is GoogleLogIn) {
          try {
            emit(ConnectingGoogle());
            User user = await googleLoginUseCase.execute();
            emit(GoogleConnected(user: user));
          } catch (error) {
            emit(Error(error: error.toString()));
          }
        } else if (event is CreateProvider) {
          try {
            emit(CreatingProvider());
            await registerUserUseCase.execute(event.registerUserData).then((value) async {
                String providerCreationStatus = await registerProviderUseCase.execute(event.registerProviderData);
                emit(ProviderCreated(providerCreationStatus: providerCreationStatus));
              }
            );
          } catch (error) {
            emit(Error(error: error.toString()));
          }
        } else if (event is UnloadState) {
          emit(UserLoggedIn(user: event.unload));
        } else if (event is SignInUser) {
          try {
            emit(LoggingInUser());
            LoginUser loginUserData = LoginUser(email: event.email, password: event.password);
            User user = await loginUserUseCase.execute(loginUserData);
            emit(UserLoggedIn(user: user));
          } catch (error) {
            emit(Error(error: error.toString()));
          }
        } else if (event is CreateUser) {
          try {
            emit(CreatingUser());
            RegisterUser registerUserData = RegisterUser(
                username: event.username,
                fullname: event.fullname,
                email: event.email,
                password: event.password,
                isprovider: event.isprovider);
            String userCreationStatus = await registerUserUseCase.execute(registerUserData);
            emit(UserCreated(userCreationStatus: userCreationStatus));
          } catch (error) {
            emit(Error(error: error.toString()));
          }
        }
      },
    );
  }
}
