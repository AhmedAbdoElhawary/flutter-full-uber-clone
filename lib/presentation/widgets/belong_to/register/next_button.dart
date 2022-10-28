import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uber/core/resources/color_manager.dart';
import 'package:uber/core/resources/styles_manager.dart';
import 'package:uber/presentation/pages/register/code_verification.dart';

class NextButton extends StatelessWidget {
  final bool enableButton;
  final VoidCallback onPressed;
  final bool replaceWithLoadingIndicator;
  const NextButton(
      {Key? key,
      required this.enableButton,
      required this.onPressed,
      this.replaceWithLoadingIndicator = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: buildStyleFrom(
          padding: REdgeInsets.all(13),
          backgroundColor: enableButton ? ColorManager.black : null),
      onPressed: onPressed,
      child: Row(
        children: [
          if (replaceWithLoadingIndicator) ...[
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 4.1),
              child: RSizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(strokeWidth: 3.w)),
            ),
          ] else ...[
            Text(
              "Next",
              style: getBoldStyle(
                fontSize: 18,
                color: enableButton ? ColorManager.white : ColorManager.black,
              ),
            ),
          ],
          Icon(
            Icons.arrow_forward,
            size: 30.r,
            color: enableButton ? ColorManager.white : null,
          )
        ],
      ),
    );
  }
}
