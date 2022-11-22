import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;
import 'package:flutter_screenutil/flutter_screenutil.dart';

bool isThatAndroid = defaultTargetPlatform == TargetPlatform.android;

class CustomCircularProgress extends StatelessWidget {
  final Color color;

  const CustomCircularProgress(this.color, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RSizedBox(
      width: 50.w,
      child: Transform.scale(
        scale: 0.50,
        child: ClipOval(
          child: isThatAndroid
              ? CircularProgressIndicator(
                  strokeWidth: 6.w,
                  color: color,
                )
              : CupertinoActivityIndicator(color: color),
        ),
      ),
    );
  }
}

class ThineCircularProgress extends StatelessWidget {
  final Color? color;
  const ThineCircularProgress({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isThatAndroid
          ? CircularProgressIndicator(
              strokeWidth: 2.w, color: color ?? Theme.of(context).focusColor)
          : CupertinoActivityIndicator(
              color: color ?? Theme.of(context).focusColor),
    );
  }
}
