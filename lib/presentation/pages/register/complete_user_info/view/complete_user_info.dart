import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uber/core/resources/styles_manager.dart';
import 'package:uber/presentation/common/widgets/text_field/custom_text_field.dart';
import 'package:uber/presentation/cubit/personal_info_cubit/personal_info_cubit_cubit.dart';
import 'package:uber/presentation/pages/register/code_verification/view/code_verification.dart';
import 'package:uber/presentation/pages/register/complete_user_info/logic/complete_user_logic.dart';
import 'package:uber/presentation/pages/register/widgets/next_button.dart';

class CompleteUserInfoPage extends StatelessWidget {
  final String userId;
  final String phoneNumber;

  const CompleteUserInfoPage(
      {Key? key, required this.userId, required this.phoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CompleteUserController controller= Get.put(CompleteUserController(userId: userId, phoneNumber: phoneNumber));
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Complete your information",
                  style: getNormalStyle(fontSize: 20)),
              const RSizedBox(height: 30),
              Row(
                children: [
                  Padding(
                    padding: REdgeInsets.only(right: 15.0),
                    child: SizedBox(
                        width: (width / 2) - 30,
                        child: CustomTextField(
                          controller: controller.firstNameController.value,
                          hint: "Enter first name",
                        )),
                  ),
                  Flexible(
                    child: SizedBox(
                      child: CustomTextField(
                        controller: controller.lastNameController.value,
                        hint: "Enter last name",
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: REdgeInsets.only(bottom: 35.0),
                child: Row(
                  children: [
                    ElevatedButton(
                        style: buildStyleFrom(),
                        onPressed: () {
                          Navigator.of(context).maybePop();
                        },
                        child: Icon(Icons.arrow_back, size: 30.r)),
                    const Spacer(),
                    _buildNextButton(context,controller),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context, CompleteUserController controller) {
    return BlocListener<PersonalInfoCubitCubit, PersonalInfoCubitState>(
      listenWhen: (previous, current) => previous != current,
      listener: controller.nextButtonListener,
      child: Obx(()=>NextButton(
        enableButton: controller.isNextButtonEnabled,
        replaceWithLoadingIndicator: controller.isLoading,
        onPressed: () async => await controller.onPressedNextButton(context),
      )
      ),
    );
  }
}
