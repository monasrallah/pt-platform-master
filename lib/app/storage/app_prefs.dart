import 'package:pt_platform/domain/entities/auth_entities/coach_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../enum.dart';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  final String keyLang = "PREFS_KEY_LANG";
  final String accessTokenKey = "ACCESS_TOKEN_KEY";
  final String userIdKey = "USER_ID";
  final String coachIdKey = "COACH_ID";
  final String coachEntityKey = "COACH_ENTITY";
  final String userEntityKey = "USER_ENTITY";
  final String prefsKeyFcmToken = "_PREFS_KEY_FCM_TOKEN";
  final String loginUserKey = "LOGIN_USER_KEY";

  String getAppLanguage() {
    String? language =
        _sharedPreferences.getString(keyLang) ?? LanguageType.en.name;
    if (language.isNotEmpty) {
      return language;
    } else {
      // return default lang
      return LanguageType.en.name;
    }
  }

  Future<void> setAppLanguage(String languageType) async {
    _sharedPreferences.setString(keyLang, languageType);
  }

  //access token
  Future<void> setAccessToken(String accessToken) async {
    _sharedPreferences.setString(accessTokenKey, accessToken);
  }

  String getAccessToken() {
    return _sharedPreferences.getString(accessTokenKey) ?? "";
  }

  Future<void> removeAccessToken() async {
    _sharedPreferences.remove(accessTokenKey);
  }

  // //userId
  // Future<void> setUserId(int userId) async {
  //   _sharedPreferences.setInt(userIdKey, userId);
  // }
  //
  // int getUserId() {
  //   return _sharedPreferences.getInt(userIdKey) ?? 1;
  // }
  //
  // Future<void> removeUserId() async {
  //   _sharedPreferences.remove(userIdKey);
  // }
  //
  // //coachId
  // Future<void> setCoachId(int userId) async {
  //   _sharedPreferences.setInt(coachIdKey, userId);
  // }
  //
  // int getCoachId() {
  //   return _sharedPreferences.getInt(coachIdKey) ?? 1;
  // }
  //
  // Future<void> removeCoachId() async {
  //   _sharedPreferences.remove(coachIdKey);
  // }

  //coachEntity
  Future<void> setCoachEntity(List<String> coach) async {
    _sharedPreferences.setStringList(coachEntityKey, coach);
  }

  List<String> getCoachEntity() {
    return _sharedPreferences.getStringList(coachEntityKey) ?? [];
  }

  Future<void> removeCoachEntity() async {
    _sharedPreferences.remove(coachEntityKey);
  }

  //userEntity
  Future<void> setUserEntity(List<String> user) async {
    _sharedPreferences.setStringList(userEntityKey, user);
  }

  List<String> getUserEntity() {
    return _sharedPreferences.getStringList(userEntityKey) ?? [];
  }

  Future<void> removeUserEntity() async {
    _sharedPreferences.remove(userEntityKey);
  }

  ///firebase fcm token
  Future<void> setFcmToken(String token) async {
    _sharedPreferences.setString(prefsKeyFcmToken, token);
  }

  Future<void> removeFcmToken() async {
    _sharedPreferences.remove(prefsKeyFcmToken);
  }

  dynamic getFcmToken() async {
    return _sharedPreferences.getString(prefsKeyFcmToken);
  }

  Future<void> setLoginUser(bool value) async {
    await _sharedPreferences.setBool(loginUserKey, value);
  }

  bool? getLoginUser() {
    return _sharedPreferences.getBool(loginUserKey);
  }
}
