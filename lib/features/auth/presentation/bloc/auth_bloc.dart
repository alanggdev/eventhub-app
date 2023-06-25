import 'package:eventhub_app/features/auth/domain/entities/register_user.dart';
import 'package:eventhub_app/features/auth/domain/usecases/register_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUserUseCase registerUserUseCase;

  AuthBloc({required this.registerUserUseCase}) : super(InitialState()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is CreateUser) {
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
