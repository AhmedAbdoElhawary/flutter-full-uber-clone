part of '../firebaseAuthCubit/firebase_auth_cubit.dart';

abstract class FirebaseAuthCubitState {}

class CubitInitial extends FirebaseAuthCubitState {}

class MobilePhoneVerifying extends FirebaseAuthCubitState {}

class MobilePhoneVerified extends FirebaseAuthCubitState {
  String? userUid;
  MobilePhoneVerified(this.userUid);
}

class OTPSubmitting extends FirebaseAuthCubitState {}

class OTPSubmitted extends FirebaseAuthCubitState {
  String userUid;
  OTPSubmitted(this.userUid);
}

class AuthLoggingOut extends FirebaseAuthCubitState {}

class AuthLoggedOut extends FirebaseAuthCubitState {}

class CubitAuthFailed extends FirebaseAuthCubitState {
  final String error;
  CubitAuthFailed(this.error);
}
