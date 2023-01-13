import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uber/core/utility/constant.dart';

class AppearanceOfSearchListLogic extends GetxController {

  final RxDouble _positionInTop = 130.h.obs;
  final RxDouble _startTapPoint = 0.0.obs;

  /// taping update
  void onListPointerMove(PointerMoveEvent details, BuildContext context) {
    _disAppearTheKeyboard(context);
    _positionInTop.value = 130.h;
    double additionSpace = _additionSpace(details.position);
    if (additionSpace >= 0) _positionInTop.value += additionSpace;
    update(["pointer"]);
  }

  /// taping end
  void onListPointerUp(PointerUpEvent details) {
    bool appear = _additionSpace(details.position) < 100;
    _positionInTop.value = 130.h;
    changeTheAppearing(disAppear: !appear);
  }

  /// taping start
  void onListPointerDown(PointerDownEvent details) {
    _startTapPoint.value = details.position.dy;
  }

  double _additionSpace(Offset position) => position.dy - _startTapPoint.value;

  void changeTheAppearing({required bool disAppear}) {
    _positionInTop.value = disAppear ? sizeOfScreen.height : 130.h;
    update(["pointer"]);
  }

  void _disAppearTheKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
  }

  bool get disAppearTheResult => sizeOfScreen.height == getPositionInTop;
  double get getPositionInTop => _positionInTop.value;
}

