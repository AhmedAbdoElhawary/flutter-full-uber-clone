import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uber/core/resources/color_manager.dart';
import 'package:uber/core/resources/styles_manager.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget? prefixIcon;
  final TextInputType? textInputType;
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.hint,
      this.prefixIcon,
      this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      controller: controller,
      cursorColor: ColorManager.black,
      inputFormatters: [
        LengthLimitingTextInputFormatter(prefixIcon == null ? 15 : 11)
      ],
      style: getMediumStyle(color: Theme.of(context).focusColor, fontSize: 16),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: getMediumStyle(color: ColorManager.grey, fontSize: 17),
        fillColor: ColorManager.veryLightGrey,
        filled: true,
        prefixIcon: prefixIcon,
        prefixIconConstraints:
            prefixIcon != null ? BoxConstraints(maxWidth: 60.w) : null,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0.r),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0.r),
            borderSide: BorderSide(color: ColorManager.black, width: 2.w)),
        contentPadding:
             REdgeInsets.symmetric(horizontal: 10, vertical: 15).r,
      ),
    );
  }
}
