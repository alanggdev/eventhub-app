part of 'auth_bloc.dart';

abstract class AuthState {}

class InitialState extends AuthState {}

class CreatingGoogleProvider extends AuthState {}
class GoogleProviderCreated extends AuthState {
  final String providerCreationStatus;
  final User user;

  GoogleProviderCreated({required this.providerCreationStatus, required this.user});
}

class CompletingGoogleLogIn extends AuthState {}
class GoogleLogInCompleted extends AuthState {
  final User user;

  GoogleLogInCompleted({required this.user});
}

class ConnectingGoogle extends AuthState {}
class GoogleConnected extends AuthState {
  final User user;

  GoogleConnected({required this.user});
}

class CreatingProvider extends AuthState {}
class ProviderCreated extends AuthState {
  final String providerCreationStatus;

  ProviderCreated({required this.providerCreationStatus});
}

class LoggingInUser extends AuthState {}
class UserLoggedIn extends AuthState {
  final User user;

  UserLoggedIn({required this.user});
}

class CreatingUser extends AuthState {}
class UserCreated extends AuthState {
  final String userCreationStatus;

  UserCreated({required this.userCreationStatus});
}

class Error extends AuthState {
  final String error;

  Error({required this.error});
}