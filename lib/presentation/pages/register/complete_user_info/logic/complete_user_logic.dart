import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber/config/routes/route_app.dart';
import 'package:uber/core/functions/toast_show.dart';
import 'package:uber/core/utility/app_prefs.dart';
import 'package:uber/core/utility/injector.dart';
import 'package:uber/data/models/personal_info.dart';
import 'package:uber/presentation/cubit/personal_info_cubit/personal_info_cubit_cubit.dart';
import 'package:uber/presentation/layouts/base_layout.dart';
import 'package:uber/presentation/pages/register/register_page/view/register_page.dart';

enum _EnumNextButton { enable, disable, replaceWithLoading }

class CompleteUserController extends GetxController {
  final String userId;
  final String phoneNumber;
  CompleteUserController({required this.userId, required this.phoneNumber});

  final _firstNameNotEmpty = false.obs;
  final _lastNameNotEmpty = false.obs;

  final _enableNextButton = _EnumNextButton.disable.obs;

  final Rx<TextEditingController> firstNameController =
      TextEditingController().obs;
  final Rx<TextEditingController> lastNameController =
      TextEditingController().obs;

  final AppPreferences _sharePrefs = injector<AppPreferences>();

  bool get isLoading =>
      _enableNextButton.value == _EnumNextButton.replaceWithLoading;

  bool get isNextButtonEnabled =>
      _enableNextButton.value == _EnumNextButton.enable;

  @override
  void onInit() {
    controllersListener();
    super.onInit();
  }

  controllersListener() {
    lastNameController.value.addListener(() {
      bool lastNotEmpty = lastNameController.value.text.isNotEmpty;

      _lastNameNotEmpty.value = lastNotEmpty;
      _enableNextButton.value = _firstNameNotEmpty.value && lastNotEmpty
          ? _EnumNextButton.enable
          : _EnumNextButton.disable;
    });
    firstNameController.value.addListener(() {
      bool firstNotEmpty = firstNameController.value.text.isNotEmpty;
      _firstNameNotEmpty.value = firstNotEmpty;
      _enableNextButton.value = _lastNameNotEmpty.value && firstNotEmpty
          ? _EnumNextButton.enable
          : _EnumNextButton.disable;
    });
  }

  onPressedNextButton(BuildContext context) async {
    if (isNextButtonEnabled) {
      _makeNextButtonLoading();
      PersonalInfo personalInfo = PersonalInfo(
          firstName: firstNameController.value.text,
          lastName: lastNameController.value.text,
          userId: userId,
          phoneNumber: phoneNumber);
      await PersonalInfoCubitCubit.get(context).createNewUser(personalInfo);
    }
  }

  void _makeNextButtonLoading() =>
      _enableNextButton.value = _EnumNextButton.replaceWithLoading;

  /// listen to bloc state
  nextButtonListener(context, state) async {
    if (state is UserCreationLoaded) {
      signIn(context, state);
    } else if (state is PersonalInfoFailed) {
      goBackToRegisterPage(context, state);
    }
  }

  signIn(BuildContext context, UserCreationLoaded state) async {
    await _sharePrefs.setUserId(userId);
    Go.offAll(BaseLayout(personalInfo: state.personalInfo));
  }

  goBackToRegisterPage(BuildContext context, PersonalInfoFailed state) {
    ToastShow.reformatToast(context, state.error);
    Go.offAll( const RegisterPage());
  }

  /// ------------------->
}
