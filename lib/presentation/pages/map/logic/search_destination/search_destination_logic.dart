import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchDestinationLogic extends GetxController {
  final RxBool _disAppear = false.obs;
  final RxDouble _positionInTop = 130.h.obs;
  void onListPointerMove(PointerMoveEvent details) {
    double y = details.position.dy;
    double temp = y > 128.h ? y : _positionInTop.value;
    _positionInTop.value = temp;
    update(["pointer"]);
  }

  void onListPointerUp(PointerUpEvent details, BuildContext context) {
    _positionInTop.value = 130.h;
    changeTheAppearing(true);
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
  }

  bool get getDisAppear => _disAppear.value;
  double get getPositionInTop => _positionInTop.value;
  void changeTheAppearing(bool value) {
    _disAppear.value = value;
    update(["pointer"]);
  }
}
