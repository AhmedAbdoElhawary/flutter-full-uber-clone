import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uber/core/functions/toast_show.dart';
import 'package:uber/core/resources/styles_manager.dart';
import 'package:uber/core/utility/injector.dart';
import 'package:uber/data/models/personal_info.dart';
import 'package:uber/presentation/cubit/personal_info_cubit/personal_info_cubit_cubit.dart';
import 'package:uber/presentation/layouts/base_layout.dart';
import 'package:uber/presentation/pages/register/code_verification.dart';
import 'package:uber/presentation/pages/register/register_page.dart';
import 'package:uber/presentation/widgets/belong_to/register/next_button.dart';
import 'package:uber/presentation/widgets/common/custom_widgets/text_field/custom_text_field.dart';

enum EnumNextButton { enable, disable, replaceWithLoading }

class CompleteUserInfoPage extends StatefulWidget {
  final String userId;
  final String phoneNumber;

  const CompleteUserInfoPage(
      {Key? key, required this.userId, required this.phoneNumber})
      : super(key: key);

  @override
  State<CompleteUserInfoPage> createState() => _CompleteUserInfoPageState();
}

class _CompleteUserInfoPageState extends State<CompleteUserInfoPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final ValueNotifier<bool> firstNameNotEmpty = ValueNotifier(false);
  final ValueNotifier<bool> lastNameNotEmpty = ValueNotifier(false);

  final ValueNotifier<EnumNextButton> enableNextButton =
      ValueNotifier(EnumNextButton.disable);

  final SharedPreferences _sharePrefs = injector<SharedPreferences>();

  @override
  void initState() {
    lastNameController.addListener(() {
      bool lastNotEmpty = lastNameController.text.isNotEmpty;

      lastNameNotEmpty.value = lastNotEmpty;
      enableNextButton.value = firstNameNotEmpty.value && lastNotEmpty
          ? EnumNextButton.enable
          : EnumNextButton.disable;
    });
    firstNameController.addListener(() {
      bool firstNotEmpty = firstNameController.text.isNotEmpty;
      firstNameNotEmpty.value = firstNotEmpty;
      enableNextButton.value = lastNameNotEmpty.value && firstNotEmpty
          ? EnumNextButton.enable
          : EnumNextButton.disable;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        width: (width / 2)-30,
                        child: CustomTextField(
                          controller: firstNameController,
                          hint: "Enter first name",
                        )),
                  ),
                  Flexible(
                    child: SizedBox(
                      child: CustomTextField(
                        controller: lastNameController,
                        hint: "Enter last name",
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding:  REdgeInsets.only(bottom: 35.0),
                child: Row(
                  children: [
                    ElevatedButton(
                        style: buildStyleFrom(),
                        onPressed: () {
                          Navigator.of(context).maybePop();
                        },
                        child:  Icon(Icons.arrow_back, size: 30.r)),
                    const Spacer(),
                    ValueListenableBuilder(
                      valueListenable: enableNextButton,
                      builder:
                          (context, EnumNextButton nextButtonValue, child) {
                        bool isHeMoved = true;
                        return BlocBuilder<PersonalInfoCubitCubit,
                            PersonalInfoCubitState>(
                          buildWhen: (previous, current) => previous != current,
                          builder: (context, state) {
                            if (state is UserCreationLoaded) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((_) async {
                                await _sharePrefs.setString(
                                    "userId", widget.userId);
                                if (!mounted) return;
                                if (isHeMoved) {
                                  isHeMoved = false;
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => BaseLayout(
                                              personalInfo:
                                                  state.personalInfo)),
                                      (route) => false);
                                }
                              });
                              return const RSizedBox();
                            } else if (state is PersonalInfoFailed) {
                              ToastShow.toastStateError(context,state.error.toString());
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (isHeMoved) {
                                  isHeMoved = false;
                                  Navigator.of(context).pushAndRemoveUntil(
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              const RegisterPage()),
                                      (route) => false);
                                }
                              });

                              return const RSizedBox();
                            }
                            return NextButton(
                              enableButton:
                                  nextButtonValue == EnumNextButton.enable,
                              replaceWithLoadingIndicator: nextButtonValue ==
                                  EnumNextButton.replaceWithLoading,
                              onPressed: () async {
                                if (nextButtonValue == EnumNextButton.enable) {
                                  enableNextButton.value =
                                      EnumNextButton.replaceWithLoading;
                                  PersonalInfo personalInfo = PersonalInfo(
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      userId: widget.userId,
                                      phoneNumber: widget.phoneNumber);
                                  print(
                                      "===================> ${personalInfo.toMap()}");
                                  await PersonalInfoCubitCubit.get(context)
                                      .createNewUser(personalInfo);
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
