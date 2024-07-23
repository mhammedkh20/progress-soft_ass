part of 'auth_bloc.dart';
//

abstract class AuthEvent {}

class ChangeAgeEvent extends AuthEvent {
  final int age;
  ChangeAgeEvent({required this.age});
}

class ChangeGenderEvent extends AuthEvent {
  final String gender;
  ChangeGenderEvent({required this.gender});
}

class RequestOTPCodeEvent extends AuthEvent {
  final String phone;
  final String password;
  final String name;

  RequestOTPCodeEvent(
      {required this.phone, required this.password, required this.name});
}

class RegisterDataOnFirebaseEvent extends AuthEvent {
  final BuildContext context;
  final String smsCode;
  final UserModel userModel;
  final String verificationId;

  RegisterDataOnFirebaseEvent({
    required this.context,
    required this.userModel,
    required this.verificationId,
    required this.smsCode,
  });
}

class LoginEvent extends AuthEvent {
  final BuildContext context;
  final String phoneNumber;
  final String password;

  LoginEvent(
      {required this.context,
      required this.phoneNumber,
      required this.password});
}

class GetLocationDetaisEvent extends AuthEvent {}
