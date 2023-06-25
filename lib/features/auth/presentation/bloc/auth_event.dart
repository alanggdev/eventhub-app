part of 'auth_bloc.dart';

abstract class AuthEvent {}

class UnloadState extends AuthEvent {
  final User unload;

  UnloadState({required this.unload});
}

class SignInUser extends AuthEvent {
  final String email, password;

  SignInUser({required this.email, required this.password});
}

class CreateUser extends AuthEvent {
  final String username, fullname, email, password;
  final bool isprovider;

  CreateUser(
      {required this.username,
      required this.fullname,
      required this.email,
      required this.password,
      required this.isprovider});
}
