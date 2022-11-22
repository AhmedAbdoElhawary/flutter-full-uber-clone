
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uber/core/resources/color_manager.dart';

class CircleWithBoxShadow extends StatelessWidget {
  final Widget child;
  const CircleWithBoxShadow({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 4,
          blurRadius: 5,
          offset: Offset.fromDirection(0),
        ),
      ], shape: BoxShape.circle, color: ColorManager.white),
      padding: REdgeInsets.all(10),
      child: child,
    );
  }
}
