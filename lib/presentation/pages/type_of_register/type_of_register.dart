import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/config/routes/route_app.dart';
import 'package:uber/core/functions/toast_show.dart';
import 'package:uber/core/utility/app_prefs.dart';
import 'package:uber/core/utility/injector.dart';
import 'package:uber/presentation/common/widgets/custom_circulars_progress.dart';
import 'package:uber/presentation/cubit/personal_info_cubit/personal_info_cubit_cubit.dart';
import 'package:uber/presentation/layouts/base_layout.dart';
import 'package:uber/presentation/pages/register/complete_user_info/view/complete_user_info.dart';
import 'package:uber/presentation/pages/register/register_page/view/register_page.dart';

class GetPersonalInfo extends StatelessWidget {
  final String userId;
  final String phoneNumber;

  const GetPersonalInfo({Key? key, required this.userId, this.phoneNumber = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonalInfoCubitCubit, PersonalInfoCubitState>(
        bloc: PersonalInfoCubitCubit.get(context)..getUserInfo(userId),
        listenWhen: (previous, current) => previous != current,
        listener: listener,
        child: const Scaffold(body: ThineCircularProgress()));
  }

  Future<void> listener(context, state) async {
    if (state is PersonalInfoLoaded) {
      registerUserType(state);
    } else if (state is PersonalInfoFailed) {
      goBackToRegisterPage(state, context);
    }
  }

  registerUserType(PersonalInfoLoaded state) async {
    bool isUserExist = state.personalInfo != null;
    if (isUserExist) {
      login(state);
    } else {
      phoneNumber.isNotEmpty
          ? continueTakingUserInfo()
          : Go.to(const RegisterPage());
    }
  }

  continueTakingUserInfo() {
    Go.to(CompleteUserInfoPage(userId: userId, phoneNumber: phoneNumber));
  }

  login(PersonalInfoLoaded state) async {
    final AppPreferences sharePrefs = injector<AppPreferences>();
    await sharePrefs.setUserId(userId);
    Go.offAll(BaseLayout(personalInfo: state.personalInfo!));
  }

  goBackToRegisterPage(PersonalInfoFailed state, BuildContext context) {
    ToastShow.reformatToast(context, state.error);
    Go.offAll(const RegisterPage());
  }
}
