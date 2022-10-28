import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uber/config/routes/route_app.dart';
import 'package:uber/core/functions/toast_show.dart';
import 'package:uber/core/utility/injector.dart';
import 'package:uber/presentation/cubit/personal_info_cubit/personal_info_cubit_cubit.dart';
import 'package:uber/presentation/layouts/base_layout.dart';
import 'package:uber/presentation/pages/complete_user_info.dart';
import 'package:uber/presentation/pages/register/register_page.dart';
import 'package:uber/presentation/common_widgets/custom_circulars_progress.dart';

class GetPersonalInfo extends StatefulWidget {
  final String userId;
  final String phoneNumber;

  const GetPersonalInfo({Key? key, required this.userId, this.phoneNumber = ""})
      : super(key: key);

  @override
  State<GetPersonalInfo> createState() => _GetPersonalInfoState();
}

class _GetPersonalInfoState extends State<GetPersonalInfo> {
  final SharedPreferences _sharePrefs = injector<SharedPreferences>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonalInfoCubitCubit, PersonalInfoCubitState>(
        bloc: PersonalInfoCubitCubit.get(context)..getUserInfo(widget.userId),
        listenWhen: (previous, current) => previous != current,
        listener: listener,
        child: const Scaffold(body: ThineCircularProgress()));
  }

  Future<void> listener(context, state) async {
    if (state is PersonalInfoLoaded) {
      registerUserType(state);
    } else if (state is PersonalInfoFailed) {
      goBackToRegisterPage(state);
    }
  }

  registerUserType(PersonalInfoLoaded state) async {
    bool isUserExist = state.personalInfo != null;
    if (isUserExist) {
      login(state);
    } else {
      continueTakingUserInfo();
    }
  }

  continueTakingUserInfo() {
    Go(context).to(CompleteUserInfoPage(
        userId: widget.userId, phoneNumber: widget.phoneNumber));
  }

  login(PersonalInfoLoaded state) async {
    await _sharePrefs.setString("userId", widget.userId);
    if (!mounted) return;
    Go(context).toAndRemoveAll(BaseLayout(personalInfo: state.personalInfo!));
  }

  goBackToRegisterPage(PersonalInfoFailed state) {
    ToastShow.reformatToast(context, state.error);
    Go(context).toAndRemoveAll(const RegisterPage());
  }
}
