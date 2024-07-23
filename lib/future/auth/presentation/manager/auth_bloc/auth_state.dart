part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthChangeAge extends AuthState {}

class AuthChangeGender extends AuthState {}

// ! Request Code
class AuthRequestCodeLoading extends AuthState {}

class AuthRequestCodeSuccess extends AuthState {
  final String verificationId;
  final UserModel userModel;

  AuthRequestCodeSuccess(this.verificationId, this.userModel);
}

class AuthRequestCodeFailuer extends AuthState {
  final String? message;
  AuthRequestCodeFailuer(this.message);
}

// ! Registerd Data On Firebase
class AuthRegisterdLoading extends AuthState {}

class AuthRegisterdSuccess extends AuthState {}

class AuthRegisterdFailuer extends AuthState {
  final String message;
  AuthRegisterdFailuer(this.message);
}

// ! Login
class AuthLoginLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {}

class AuthLoginFailuer extends AuthState {
  final String message;
  AuthLoginFailuer(this.message);
}

class UserIsNotRegister extends AuthState {}

// ! Location Details
class AuthGetLocationLoading extends AuthState {}

class AuthGetLocationSuccess extends AuthState {}

class AuthGetLocationFailuer extends AuthState {
  final String message;
  AuthGetLocationFailuer(this.message);
}
