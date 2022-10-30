import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uber/core/translations/local_storage/local_storage.dart';

class AppLanguage extends GetxController {
  String _appLocale = 'en';

  @override
  void onInit() async {
    super.onInit();
    LocalStorage localStorage = LocalStorage();

    _appLocale = await localStorage.languageSelected ?? 'en';
    update();
    Get.updateLocale(Locale(_appLocale));
  }

  String get appLang => _appLocale;

  void changeLanguage() async {
    LocalStorage localStorage = LocalStorage();

    if (_appLocale == 'en') {
      _appLocale = 'ar';
      localStorage.saveLanguageToDisk('ar');
    } else {
      _appLocale = 'en';
      localStorage.saveLanguageToDisk('en');
    }
    update();
  }
}
