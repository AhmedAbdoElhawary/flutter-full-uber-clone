import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uber/core/utility/constant.dart';

class AppearanceOfSearchListLogic extends GetxController {
  final RxDouble _positionInTop = 130.h.obs;
  final RxDouble _startTapPoint = 0.0.obs;
  final RxBool _displayRidersMenu = false.obs;
  final draggableScrollableController = DraggableScrollableController().obs;
  final Rx<double> _opacityOfAppBar = 0.0.obs;
  final Rx<Color> colorOfAppBar = Colors.black.withOpacity(0).obs;

  @override
  void onInit() {
    _animateColorOfAppBar();
    super.onInit();
  }

  _animateColorOfAppBar() {
    draggableScrollableController.value.addListener(() {
      double pixels = draggableScrollableController.value.pixels;
      double opacity = ((pixels - 350) / 405).abs();
      if (opacity > 1) opacity = 1;
      _opacityOfAppBar.value = opacity;
      colorOfAppBar.value = Paint().color = Colors.black.withOpacity(opacity);
    });
  }

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
    showTheFlyingSuggestionsList(appear: appear);
  }

  /// taping start
  void onListPointerDown(PointerDownEvent details) {
    _startTapPoint.value = details.position.dy;
  }

  void stepDownRidersMenu() {
    draggableScrollableController.value.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.bounceInOut);
  }

  double _additionSpace(Offset position) => position.dy - _startTapPoint.value;

  void showRidersMenu({bool appear = true}) {
    _displayRidersMenu.value = appear;
    showTheFlyingSuggestionsList(appear: !appear);
    update(["update"]);
  }

  void showTheFlyingSuggestionsList({bool appear = true}) {
    _positionInTop.value = appear ? 130.h : sizeOfScreen.height;
    update(["pointer"]);
  }

  void _disAppearTheKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
  }

  bool get disAppearTheResult => sizeOfScreen.height == getPositionInTop;
  double get getPositionInTop => _positionInTop.value;
  double get getOpacityOfAppBar => _opacityOfAppBar.value;
  bool get getDisplayRidersMenu => _displayRidersMenu.value;
}
