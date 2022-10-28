import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/domain/use_cases/auth/log_out.dart';
import 'package:uber/domain/use_cases/auth/submit_otp.dart';
import 'package:uber/domain/use_cases/auth/submit_phone_umber.dart';
part 'firebase_auth_state.dart';

class FirebaseAuthCubit extends Cubit<FirebaseAuthCubitState> {
  final VerifyMobilePhoneUseCase _submitPhoneNumUseCase;
  final SubmitOtpPhoneUseCase _submitOtpPhoneUseCase;
  final LogOutUseCase _logOutUseCase;
  String? userUid;

  FirebaseAuthCubit(this._submitPhoneNumUseCase, this._submitOtpPhoneUseCase,
      this._logOutUseCase)
      : super(CubitInitial());

  static FirebaseAuthCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> submitPhoneNumber(String mobilePhone) async {
    emit(MobilePhoneVerifying());
    await _submitPhoneNumUseCase(params: mobilePhone).then((userUid) {
      emit(MobilePhoneVerified(userUid));
      this.userUid = userUid;
    }).catchError((e) {
      emit(CubitAuthFailed(e.toString()));
    });
  }
  Future<void> submitOTP(String otpCode) async {
    emit(OTPSubmitting());
    await _submitOtpPhoneUseCase(params: otpCode).then((userUid) {
      emit(OTPSubmitted(userUid));
      this.userUid = userUid;
    }).catchError((e) {
      emit(CubitAuthFailed(e.toString()));
    });
  }
  Future<void> logOut(String mobilePhone) async {
    emit(AuthLoggingOut());
    await _logOutUseCase(params: null).then((_) {
      emit(AuthLoggedOut());
    }).catchError((e) {
      emit(CubitAuthFailed(e.toString()));
    });
  }
}
