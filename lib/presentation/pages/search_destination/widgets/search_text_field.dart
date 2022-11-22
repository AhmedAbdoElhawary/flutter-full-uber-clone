import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uber/core/resources/color_manager.dart';
import 'package:uber/core/resources/styles_manager.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const SearchTextField(
      {Key? key, required this.controller, required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: ColorManager.teal,
      style: getNormalStyle(color: ColorManager.black, fontSize: 16),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: getNormalStyle(color: ColorManager.lightGrey, fontSize: 17),
        fillColor: ColorManager.veryLowOpacityGrey,
        filled: true,
        isDense: true,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide.none),
        contentPadding: REdgeInsets.symmetric(horizontal: 10, vertical: 7),
      ),
    );
  }
}
