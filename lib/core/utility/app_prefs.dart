import 'package:shared_preferences/shared_preferences.dart';

const String _userId = "USER_ID";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<void> setUserId(String id) async {
    await _sharedPreferences.setString(_userId, id);
  }

  String getUserId() => _sharedPreferences.getString(_userId) ?? "";

  Future<bool> logout() async =>
      await _sharedPreferences.remove(_userId);
}
