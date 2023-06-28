part of 'auth_bloc.dart';

abstract class AuthState {}

class InitialState extends AuthState {}

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