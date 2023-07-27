part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LogOut extends AuthEvent {
  final User user;

  LogOut({required this.user});
}

class CompleteProviderGoogleLogIn extends AuthEvent {
  final User userData;
  final RegisterUser registerData;
  final RegisterProvider registerProviderData;

  CompleteProviderGoogleLogIn({required this.userData, required this.registerData, required this.registerProviderData});
}

class CompleteGoogleLogIn extends AuthEvent {
  final User userData;
  final RegisterUser registerData;

  CompleteGoogleLogIn({required this.userData, required this.registerData});
}

class GoogleLogIn extends AuthEvent {}

class CreateProvider extends AuthEvent {
  final RegisterUser registerUserData;
  final RegisterProvider registerProviderData;

  CreateProvider({required this.registerProviderData, required this.registerUserData});
}

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
