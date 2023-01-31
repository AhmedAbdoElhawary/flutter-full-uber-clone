import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

/// currently, I don't use routes methods because there is a lot of run time errors.
/// I use normal Navigator because i don't know how to make Get.to without root.

class Go {
  static to(Widget page) => Get.to(page, transition: Transition.rightToLeft);

  static offAll(Widget page) =>
      Get.offAll(page, transition: Transition.rightToLeft);

  static back() => Get.back();
}
