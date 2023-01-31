import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uber/core/resources/color_manager.dart';
import 'package:uber/core/resources/styles_manager.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomOutlinedButton(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: outlinedStyle(),
      onPressed: onPressed,
      child: Text(
        text,
        style: getNormalStyle(fontSize: 17),
      ),
    );
  }
}

ButtonStyle outlinedStyle() {
  return OutlinedButton.styleFrom(
    fixedSize: Size(300.w, 45.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0.r),
    ),
    side: BorderSide(width: 1.w, color: ColorManager.black45),
  );
}
