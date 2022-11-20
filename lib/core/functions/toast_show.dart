import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber/core/resources/color_manager.dart';
import 'package:uber/core/resources/styles_manager.dart';

class ToastShow {
  static toast(BuildContext context, String toast) {
    FToast fToast = FToast();
    fToast.init(context);

    return fToast.showToast(
      child: Container(
          color: ColorManager.black,
          padding: REdgeInsets.all(8),
          child: Text(
            toast,
            style: getMediumStyle(fontSize: 17, color: ColorManager.white),
          )),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  static reformatToast(BuildContext context, String state) {
    String error;
    try {
      error = state.split(RegExp(r"]"))[1];
    } catch (e) {
      error = state;
    }
    if (kDebugMode) print("=========> $error !!!!!!the error in toast show!!!");

    ToastShow.toast(context, error);
  }
}
