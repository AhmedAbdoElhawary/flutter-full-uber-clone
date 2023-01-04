import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/domain/repositories/auth_repository.dart';
part 'firebase_auth_state.dart';

class FirebaseAuthCubit extends Cubit<FirebaseAuthCubitState> {
  final FirebaseAuthRepository _firebaseAuthRepository;
  String? userUid;

  FirebaseAuthCubit(this._firebaseAuthRepository) : super(CubitInitial());

  static FirebaseAuthCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> submitPhoneNumber(String mobilePhone) async {
    emit(MobilePhoneVerifying());
    await _firebaseAuthRepository
        .submitPhoneNumber(mobilePhone)
        .then((userUid) {
      emit(MobilePhoneVerified(userUid));
      this.userUid = userUid;
    }).catchError((e) {
      emit(CubitAuthFailed(e.toString()));
    });
  }

  Future<void> submitOTP(String otpCode) async {
    emit(OTPSubmitting());
    await _firebaseAuthRepository.submitOTP(otpCode).then((userUid) {
      emit(OTPSubmitted(userUid));
      this.userUid = userUid;
    }).catchError((e) {
      emit(CubitAuthFailed(e.toString()));
    });
  }

  Future<void> logOut(String mobilePhone) async {
    emit(AuthLoggingOut());
    await _firebaseAuthRepository.logOut().then((_) {
      emit(AuthLoggedOut());
    }).catchError((e) {
      emit(CubitAuthFailed(e.toString()));
    });
  }
}
