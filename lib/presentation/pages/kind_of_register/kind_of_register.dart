import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uber/config/routes/route_app.dart';
import 'package:uber/core/functions/toast_show.dart';
import 'package:uber/core/utility/injector.dart';
import 'package:uber/presentation/cubit/personal_info_cubit/personal_info_cubit_cubit.dart';
import 'package:uber/presentation/layouts/base_layout.dart';
import 'package:uber/presentation/pages/complete_user_info.dart';
import 'package:uber/presentation/pages/register/register_page.dart';
import 'package:uber/presentation/widgets/common/custom_widgets/custom_circulars_progress.dart';

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
    return BlocBuilder<PersonalInfoCubitCubit, PersonalInfoCubitState>(
        bloc: PersonalInfoCubitCubit.get(context)..getUserInfo(widget.userId),
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is PersonalInfoLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              if (state.personalInfo == null) {
                pushToPage(context,
                    page: CompleteUserInfoPage(
                        userId: widget.userId, phoneNumber: widget.phoneNumber));
              } else {
                await _sharePrefs.setString("userId", widget.userId);
                if(!mounted)return;
                Navigator.of(context).pushAndRemoveUntil(
                    CupertinoPageRoute(
                        builder: (context) =>
                            BaseLayout(personalInfo: state.personalInfo!)),
                    (route) => false);
              }
            });
          } else if (state is PersonalInfoFailed) {
            ToastShow.toastStateError(context,state.error);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(
                      builder: (context) => const RegisterPage()),
                  (route) => false);
            });
          }
          return const ThineCircularProgress();
        });
  }
}
