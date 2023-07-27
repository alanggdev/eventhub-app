import 'package:eventhub_app/features/auth/domain/usecases/delete_user.dart';
import 'package:eventhub_app/features/auth/domain/usecases/update_full_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/features/auth/domain/entities/register_user.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';
import 'package:eventhub_app/features/auth/domain/entities/login_user.dart';
import 'package:eventhub_app/features/auth/domain/entities/register_provider.dart';
import 'package:eventhub_app/features/auth/domain/usecases/logout.dart';

import 'package:eventhub_app/features/auth/domain/usecases/register_user.dart';
import 'package:eventhub_app/features/auth/domain/usecases/login_user.dart';
import 'package:eventhub_app/features/auth/domain/usecases/google_login.dart';
import 'package:eventhub_app/features/auth/domain/usecases/register_provider.dart';
import 'package:eventhub_app/features/auth/domain/usecases/update_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final DeleteUserUseCase deleteUserUseCase;
  final UpdateFullNameUseCase updateFullNameUseCase;
  final LogOutUseCase logOutUseCase;
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
      required this.updateUserUseCase,
      required this.logOutUseCase,
      required this.updateFullNameUseCase,
      required this.deleteUserUseCase})
      : super(InitialState()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is DeleteUser) {
          try {
            emit(UpdatingUser());
            String status = await deleteUserUseCase.execute(event.username);
            emit(UserDeleted(status: status));
          } catch (error) {
            emit(Error(error: error.toString()));
          }
        } else if (event is UpdateName) {
          try {
            emit(UpdatingUser());
            User user = await updateFullNameUseCase.execute(event.user, event.fullName);
            emit(UserUpdated(user: user));
          } catch (error) {
            emit(Error(error: error.toString()));
          }
        } else if (event is LogOut) {
          await logOutUseCase.execute(event.user);
        } else if (event is CompleteProviderGoogleLogIn) {
          // Complete google log in with provider user
          try {
            emit(CreatingGoogleProvider());
            await updateUserUseCase.execute(event.userData, event.registerData).then((userData) async {
              String providerCreationStatus = await registerProviderUseCase.execute(event.registerProviderData);
              emit (GoogleProviderCreated(providerCreationStatus: providerCreationStatus, user: userData));
            },);
          } catch (error) {
            emit(Error(error: error.toString()));
          }
        } else  if (event is CompleteGoogleLogIn) {
          // Complete google log in with standard user
          try {
            emit(CompletingGoogleLogIn());
            User user = await updateUserUseCase.execute(event.userData, event.registerData);
            emit(GoogleLogInCompleted(user: user));
          } catch (error) {
            emit(Error(error: error.toString()));
          }
        } else if (event is GoogleLogIn) {
          // Log in via google account
          try {
            emit(ConnectingGoogle());
            User user = await googleLoginUseCase.execute();
            emit(GoogleConnected(user: user));
          } catch (error) {
            emit(Error(error: error.toString()));
          }
        } else if (event is CreateProvider) {
          // Create a new provider via email account
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
          // Unload useer logged in
          emit(UserLoggedIn(user: event.unload));
        } else if (event is SignInUser) {
          // Log in via email account
          try {
            emit(LoggingInUser());
            LoginUser loginUserData = LoginUser(email: event.email, password: event.password);
            User user = await loginUserUseCase.execute(loginUserData);
            emit(UserLoggedIn(user: user));
          } catch (error) {
            emit(Error(error: error.toString()));
          }
        } else if (event is CreateUser) {
          // Create user via email account
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
