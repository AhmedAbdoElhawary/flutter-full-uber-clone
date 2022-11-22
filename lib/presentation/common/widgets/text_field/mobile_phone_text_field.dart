import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uber/core/resources/color_manager.dart';
import 'package:uber/core/resources/styles_manager.dart';
import 'package:uber/presentation/common/widgets/text_field/custom_text_field.dart';

class MobilePhoneTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  const MobilePhoneTextField(
      {required this.controller, required this.hint, Key? key})
      : super(key: key);

  @override
  State<MobilePhoneTextField> createState() => _MobilePhoneTextFieldState();
}

class _MobilePhoneTextFieldState extends State<MobilePhoneTextField> {
  @override
  Widget build(BuildContext context) {
    return RSizedBox(
      width: double.infinity,
      child: CustomTextField(
        controller: widget.controller,
        hint: widget.hint,
        prefixIcon: prefixIcon(),
        textInputType: TextInputType.phone,
      ),
    );
  }

  Padding prefixIcon() {
    return Padding(
      padding:  REdgeInsets.only(bottom: 1.0, right: 5, left: 15),
      child: Text("+20",
          style: getMediumStyle(color: ColorManager.black, fontSize: 16)),
    );
  }
}
