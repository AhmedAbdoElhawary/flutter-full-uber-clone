import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uber/config/themes/app_theme.dart';
import 'package:uber/config/themes/theme_service.dart';
import 'package:uber/core/translations/app_lang.dart';
import 'package:uber/core/translations/translations.dart';
import 'package:uber/core/utility/constant.dart';
import 'package:uber/core/utility/injector.dart';
import 'package:uber/core/widgets/multi_bloc_provider.dart';
import 'package:uber/presentation/pages/kind_of_register/kind_of_register.dart';
import 'package:uber/presentation/pages/register/register_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SharedPreferences _sharePrefs = injector<SharedPreferences>();
  @override
  void initState() {
    String? userId = _sharePrefs.getString("userId");
    if (userId != null) personalId = userId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocs(materialApp());
  }

  ScreenUtilInit materialApp() {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetBuilder<AppLanguage>(
              init: AppLanguage(),
              builder: (controller) {
                return GetMaterialApp(
                  title: 'Uber',
                  theme: AppTheme.light,
                  translations: Translation(),
                  locale: Locale(controller.appLocale),
                  fallbackLocale: const Locale('en'),
                  darkTheme: AppTheme.dark,
                  themeMode: ThemeOfApp().theme,
                  debugShowCheckedModeBanner: false,
                  home: personalId.isNotEmpty
                      ? GetPersonalInfo(userId: personalId)
                      : const RegisterPage(),
                );
              });
        });
  }
}