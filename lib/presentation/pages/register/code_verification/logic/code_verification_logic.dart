import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber/config/routes/route_app.dart';
import 'package:uber/core/functions/toast_show.dart';
import 'package:uber/presentation/cubit/firebaseAuthCubit/firebase_auth_cubit.dart';
import 'package:uber/presentation/pages/kind_of_register/kind_of_register.dart';

class CodeVerificationLogic extends GetxController {
  final verificationController = TextEditingController().obs;
  late String mobilePhone;
  CodeVerificationLogic(this.mobilePhone);

  final RxString otpCode = "".obs;

  bool get enableNextButton => otpCode.value.length == 6;
  onPressedVerify(BuildContext context) async {
    if (enableNextButton) {
      await FirebaseAuthCubit.get(context).submitOTP(otpCode.value);
      otpCode.value="";
    }
  }
  nextButtonListener(context, state) {
    if (state is OTPSubmitted) {
      Go.to(GetPersonalInfo(
          userId: state.userUid, phoneNumber: mobilePhone));
    } else if (state is CubitAuthFailed) {
      ToastShow.reformatToast(context, state.error);
    }
  }
}
