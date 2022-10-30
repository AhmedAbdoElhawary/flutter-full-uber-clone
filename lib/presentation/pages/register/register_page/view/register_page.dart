import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uber/core/resources/color_manager.dart';
import 'package:uber/core/resources/strings_manager.dart';
import 'package:uber/core/resources/styles_manager.dart';
import 'package:uber/presentation/common_widgets/custom_elevated_button.dart';
import 'package:uber/presentation/common_widgets/text_field/mobile_phone_text_field.dart';
import 'package:uber/presentation/pages/register/register_page/logic/register_page_logic.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterPageController controller = Get.put(RegisterPageController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const NeverScrollableScrollPhysics(),
            child: buildColumn(context, controller)),
      ),
    );
  }

  Widget buildColumn(BuildContext context, RegisterPageController controller) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 15, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Enter your mobile number", style: getMediumStyle(fontSize: 22)),
          Padding(
            padding: REdgeInsets.symmetric(vertical: 10),
            child: MobilePhoneTextField(
                controller: controller.phoneController.value,
                hint: "0100 123 4567"),
          ),
          Padding(
            padding: REdgeInsets.symmetric(vertical: 10.0),
            child: CustomElevatedButton(
                backgroundColor: ColorManager.black,
                onPressed: () async => controller.onPressedContinue(context),
                child: Text(
                  "Continue",
                  style:
                      getMediumStyle(color: ColorManager.white, fontSize: 18),
                )),
          ),
          const OrText(),
          _ContinueWith(
              text: "Google", icon: Icons.local_airport, onPressed: () {}),
          _ContinueWith(
              text: "Apple", icon: Icons.apple_rounded, onPressed: () {}),
          _ContinueWith(
              text: "Facebook", icon: Icons.facebook_rounded, onPressed: () {}),
          const RSizedBox(height: 30),
          ...someText(),
          const RSizedBox(height: 70),
          const _PolicyTerms(),
        ],
      ),
    );
  }

  List<Widget> someText() => [
        Text(
          "By proceeding, you consent to get calls, whatsApp or ",
          style: getMediumStyle(fontSize: 14, color: ColorManager.grey),
        ),
        Padding(
          padding: REdgeInsets.symmetric(vertical: 6.0),
          child: Text(
            "SMS messages,including by automated means, from ",
            style: getMediumStyle(fontSize: 14, color: ColorManager.grey),
          ),
        ),
        Text(
          "Uber and its affiliates to the number provided.",
          style: getMediumStyle(fontSize: 14, color: ColorManager.grey),
        ),
      ];
}

class _ContinueWith extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  const _ContinueWith({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 5.0),
      child: CustomElevatedButton(
          withoutPadding: true,
          onPressed: onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30.r),
              const RSizedBox(width: 5),
              Text(
                "Continue with $text",
                style: getMediumStyle(fontSize: 18),
              ),
            ],
          )),
    );
  }
}

class _PolicyTerms extends StatelessWidget {
  const _PolicyTerms({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      softWrap: true,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      TextSpan(
        children: <TextSpan>[
          TextSpan(
              text:
                  "This site is protected by Ahmed Abdo Elhawary and the Google ",
              style: getMediumStyle(color: ColorManager.grey, fontSize: 14)),
          TextSpan(
              text: "Privacy policy, ", style: getMediumStyle(fontSize: 14)),
          TextSpan(
              text: "and ",
              style: getMediumStyle(color: ColorManager.grey, fontSize: 14)),
          TextSpan(
              text: "Terms of service ", style: getMediumStyle(fontSize: 14)),
          TextSpan(
              text: "apply.",
              style: getMediumStyle(color: ColorManager.grey, fontSize: 14)),
        ],
      ),
    );
  }
}

class OrText extends StatelessWidget {
  const OrText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        children: [
          Expanded(child: Divider(thickness: 0.5.h, color: ColorManager.grey)),
          const RSizedBox(width: 10),
          Text(
            StringsManager.or.tr,
            style: getMediumStyle(
                color: ColorManager.lowOpacityGrey, fontSize: 18),
          ),
          const RSizedBox(width: 10),
          Expanded(
            child: Divider(thickness: 0.5.h, color: ColorManager.grey),
          ),
        ],
      ),
    );
  }
}
