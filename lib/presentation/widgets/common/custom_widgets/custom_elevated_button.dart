import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uber/core/resources/color_manager.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final bool withoutPadding;
  final double circularRadius;
  const CustomElevatedButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.circularRadius = 10.0,
    this.withoutPadding = false,
    this.backgroundColor = ColorManager.veryLightGrey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: outlinedStyle(),
      onPressed: onPressed,
      child: Padding(
        padding: REdgeInsets.all(withoutPadding ? 0 : 4.5).r,
        child: child,
      ),
    );
  }

  ButtonStyle outlinedStyle() {
    return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(circularRadius.r),
      ),
      backgroundColor: backgroundColor,
    );
  }
}
