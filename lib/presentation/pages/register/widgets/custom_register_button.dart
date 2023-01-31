import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uber/core/resources/color_manager.dart';
import 'package:uber/core/resources/styles_manager.dart';

class CustomRegisterButton extends StatefulWidget {
  final String nameOfButton;
  final bool isItDone;
  final bool blueColor;
  final bool isThatSignIn;
  final AsyncCallback onPressed;
  const CustomRegisterButton(
      {Key? key,
      required this.isItDone,
      this.blueColor = true,
      this.isThatSignIn = false,
      required this.nameOfButton,
      required this.onPressed})
      : super(key: key);

  @override
  State<CustomRegisterButton> createState() => _CustomRegisterButtonState();
}

class _CustomRegisterButtonState extends State<CustomRegisterButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        return await widget.onPressed();
      },
      child: Padding(
        padding: REdgeInsets.symmetric(
            horizontal: 20, vertical: widget.isThatSignIn ? 0 : 20),
        child: Container(
            margin: REdgeInsetsDirectional.all(3.0),
            padding: REdgeInsetsDirectional.all(15.0),
            width: double.infinity,
            decoration: containerStyle(),
            child: widget.isItDone ? textOfButton() : circularProgress()),
      ),
    );
  }

  Padding textOfButton() {
    return Padding(
      padding: REdgeInsetsDirectional.all(1.5),
      child: Center(
        child: Text(
          widget.nameOfButton,
          style: getNormalStyle(color: ColorManager.white),
        ),
      ),
    );
  }

  Widget circularProgress() {
    return Center(
      child: RSizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
              color: ColorManager.white, strokeWidth: 2.w)),
    );
  }

  BoxDecoration containerStyle() {
    return BoxDecoration(
      color: !widget.blueColor
          ? ColorManager.lightBlue
          : (widget.isItDone ? ColorManager.blue : ColorManager.lightBlue),
      borderRadius: BorderRadius.circular(10.0.r),
      boxShadow: [
        BoxShadow(
          color: ColorManager.grey.withOpacity(.2),
          blurRadius: 5,
          spreadRadius: 5,
          offset: const Offset(0.0, 1.0),
        ),
      ],
    );
  }
}
