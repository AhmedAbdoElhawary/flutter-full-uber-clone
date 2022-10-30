import 'package:shared_preferences/shared_preferences.dart';

const String _isUserLoggedIn = "PREFS_KEY_IS_USER_LOGGED_IN";
const String _userId = "USER_ID";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<void> setUserId(String id) async {
    await _sharedPreferences.setString(_userId, id);
  }

  String getUserId() => _sharedPreferences.getString(_userId) ?? "";

  Future<void> logout() async =>
      await _sharedPreferences.remove(_isUserLoggedIn);
}
