part of 'auth_bloc.dart';

abstract class AuthEvent {}

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
