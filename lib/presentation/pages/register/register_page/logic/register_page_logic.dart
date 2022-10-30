import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber/config/routes/route_app.dart';
import 'package:uber/core/functions/toast_show.dart';
import 'package:uber/presentation/cubit/firebaseAuthCubit/firebase_auth_cubit.dart';
import 'package:uber/presentation/pages/register/code_verification/view/code_verification.dart';

class RegisterPageController extends GetxController {
  final Rx<TextEditingController> phoneController = TextEditingController().obs;

  onPressedContinue(BuildContext context) async {
    String mobilePhone = phoneController.value.text;
    if (mobilePhone.length < 11) {
      ToastShow.toast(context, "The mobile phone is not valid.");
    } else {
      await FirebaseAuthCubit.get(context).submitPhoneNumber(mobilePhone);
      Go.to(CodeVerificationPage(mobilePhone: phoneController.value.text));
    }
  }
}
