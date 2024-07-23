import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:progress_soft_ass/core/storage/pref/shared_pref_controller.dart';
import 'package:progress_soft_ass/future/auth/domin/auth_repo.dart';
import 'package:progress_soft_ass/future/auth/models/countries.dart';
import 'package:progress_soft_ass/future/auth/models/country_model.dart';
import 'package:progress_soft_ass/future/auth/models/user_model.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _authFirestore = FirebaseFirestore.instance;
  final AuthRepo repo;

  AuthBloc(this.repo) : super(AuthChangeAge()) {
    on<ChangeAgeEvent>(_onChangeAge);
    on<ChangeGenderEvent>(_onChangeGender);
    on<RequestOTPCodeEvent>(_requestCode);
    on<RegisterDataOnFirebaseEvent>(_registerDataOnFirebase);
    on<LoginEvent>(_login);
    on<GetLocationDetaisEvent>(_getCurrentLocation);
  }

  int age = 10;
  void _onChangeAge(ChangeAgeEvent event, emit) {
    age = event.age;
    emit(AuthChangeAge());
  }

  String gender = "male";
  void _onChangeGender(ChangeGenderEvent event, emit) {
    gender = event.gender;
    emit(AuthChangeGender());
  }

  Future _requestCode(RequestOTPCodeEvent event, emit) async {
    emit(AuthRequestCodeLoading());
    final Completer<void> completer = Completer<void>();
    log((countryCode ?? "+970") +
        (event.phone.length == 10
            ? event.phone.substring(1, 10)
            : event.phone));
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: (countryCode ?? "+970") +
            (event.phone.length == 10
                ? event.phone.substring(1, 10)
                : event.phone),
        verificationCompleted: (PhoneAuthCredential phoneAuthCre) {
          emit(
            AuthRequestCodeSuccess(
              phoneAuthCre.verificationId!,
              UserModel(
                  age: age,
                  id: _authFirestore.collection("users").doc().id,
                  gender: gender,
                  phoneNumber: event.phone,
                  password: event.password,
                  countryCode: countryCode ?? "+970",
                  name: event.name),
            ),
          );
          completer.complete("signedUp");
        },
        verificationFailed: (FirebaseAuthException error) {
          emit(AuthRequestCodeFailuer(error.message));
          completer.complete();
        },
        codeAutoRetrievalTimeout: (String s) {},
        codeSent: (String? verificationId, int? resendToken) {
          emit(
            AuthRequestCodeSuccess(
              verificationId!,
              UserModel(
                  age: age,
                  id: _authFirestore.collection("users").doc().id,
                  gender: gender,
                  phoneNumber: event.phone,
                  password: event.password,
                  countryCode: countryCode ?? "+970",
                  name: event.name),
            ),
          );
          completer.complete("verified");
        },
      );
      await completer.future;
    } catch (e) {
      emit(AuthRequestCodeFailuer(e.toString()));
    }
  }

  Future _registerDataOnFirebase(
      RegisterDataOnFirebaseEvent event, emit) async {
    try {
      emit(AuthRegisterdLoading());
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.smsCode,
      );

      User? user = (await _auth.signInWithCredential(credential)).user;
      if (user != null) {
        await _authFirestore.collection("users").add(event.userModel.toMap());
        emit(AuthRegisterdSuccess());
      } else {
        emit(
          AuthRegisterdFailuer(
              AppLocalizations.of(event.context)!.there_is_error),
        );
      }
    } catch (e) {
      emit(AuthRegisterdFailuer(e.toString()));
    }
  }

  Future _login(LoginEvent event, emit) async {
    emit(AuthLoginLoading());
    QuerySnapshot query = await _authFirestore
        .collection('users')
        .where('phone_number', isEqualTo: event.phoneNumber)
        .get();
    print(query.docs.length);

    if (query.docs.length == 0) {
      emit(UserIsNotRegister());
      return;
    }
    UserModel? userModel = checkUserIsFound(query.docs, event.phoneNumber);
    if (userModel != null) {
      if (userModel.password == event.password) {
        await SharedPrefController().setPhoneNumber(event.phoneNumber);
        await SharedPrefController().setCountryCode(userModel.countryCode);
        emit(AuthLoginSuccess());
      } else {
        emit(AuthLoginFailuer(
            AppLocalizations.of(event.context)!.password_is_incorrect));
      }
    } else {
      emit(UserIsNotRegister());
    }
  }

  UserModel? checkUserIsFound(
      List<QueryDocumentSnapshot> users, String phoneNumber) {
    for (int i = 0; i < users.length; i++) {
      UserModel user = UserModel.fromDocumentSnapshot(users[i]);
      if (user.phoneNumber == phoneNumber) {
        return user;
      }
    }
    return null;
  }

  CountryModel? countryModel;
  String? countryCode;
  Future _getCurrentLocation(GetLocationDetaisEvent event, emit) async {
    emit(AuthGetLocationLoading());
    (await repo.getCurrentLocationDetails()).fold(
      (l) {
        emit(AuthGetLocationFailuer(l));
      },
      (r) {
        countryModel = r;
        countryCode =
            "+${countryList.firstWhere((element) => element.isoCode == r.isoCode, orElse: () => countryList.first).phoneCode!}";
        emit(AuthGetLocationSuccess());
      },
    );
  }
}
