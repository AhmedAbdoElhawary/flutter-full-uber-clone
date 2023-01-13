import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber/data/models/place_suggestion/places_suggestions.dart';

class SearchDestinationLogic extends GetxController {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  final Rx<FocusNode> whereFromFocusNode = FocusNode().obs;
  final Rx<FocusNode> whereToFocusNode = FocusNode().obs;

  final Rx<Prediction?> whereFrom = Rxn<Prediction?>();
  final Rx<Prediction?> whereTo = Rxn<Prediction?>();
  final Rx<bool?> isWhereFromSelected = Rxn<bool?>();

  @override
  void onInit() {
    _focusNodesListener();
    super.onInit();
  }

  _focusNodesListener() {
    whereFromFocusNode.value.addListener(() {
      if (!whereFromFocusNode.value.hasFocus) {
        fromController.text =
            whereFrom.value?.structuredFormatting?.mainText ?? "";
      }
    });
    whereToFocusNode.value.addListener(() {
      if (!whereToFocusNode.value.hasFocus) {
        toController.text = whereTo.value?.structuredFormatting?.mainText ?? "";
      }
    });
  }

  bool get isStartAndEndComplete =>
      whereTo.value != null && whereFrom.value != null;

  void selectAllTextInFrom() {
    int lengthOfValue = fromController.text.length;
    fromController.selection =
        TextSelection(baseOffset: 0, extentOffset: lengthOfValue);
  }

  void selectAllTextInTo() {
    int lengthOfValue = toController.text.length;
    toController.selection =
        TextSelection(baseOffset: 0, extentOffset: lengthOfValue);
  }

  void onSelectedSuggestionPlace(Prediction? suggestionPlace) {
    if (isWhereFromSelected.value == null) return;
    if (isWhereFromSelected.value!) {
      whereFrom.value = suggestionPlace;
      fromController.text =
          whereFrom.value?.structuredFormatting?.mainText ?? "";
    } else {
      whereTo.value = suggestionPlace;
      toController.text = whereTo.value?.structuredFormatting?.mainText ?? "";
    }

    // TODO: from and to complete so move to and draw the lines
    if (isStartAndEndComplete) return;

    if (isWhereFromSelected.value!) {
      whereToFocusNode.value.requestFocus();
      isWhereFromSelected.value = false;
    } else {
      whereFromFocusNode.value.requestFocus();
      isWhereFromSelected.value = true;
    }
  }
}
