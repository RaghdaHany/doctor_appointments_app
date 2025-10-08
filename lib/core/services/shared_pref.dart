import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static final SharedPref _instance = SharedPref._internal();
  static late SharedPreferences pref;
  static const String kToken = 'kToken';
  static const String kUserInfo = 'kUserInfo';
  static const String userType = 'userType';
  static const String firstRegister = 'firstRegister';


  SharedPref._internal();

  factory SharedPref() {
    return _instance;
  }

  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future<void> setUserToken(String value) async {
    setString(kToken, value);
  }

  static String getUserToken() {
    return getString(kToken);
  }

  static Future<void> setUserType(String value) async {
    setString(userType, value);
  }

  static String getUserType() {
    return getString(userType);
  }

   static Future<void> setDoctorRegister(String value) async {
    setString(firstRegister, value);
  }

  static String getDoctorRegister() {
    return getString(firstRegister);
  }

  static Future<void> setString(String key, String value) async {
    await pref.setString(key, value);
  }

  static String getString(String key) {
    return pref.getString(key) ?? '';
  }

  static Future<void> setBool(String key, bool value) async {
    await pref.setBool(key, value);
  }

  static bool getBool(String key) {
    return pref.getBool(key) ?? false;
  }

  static Future<void> remove(String key) async {
    await pref.remove(key);
  }

  static Future<void> clear() async {
    await pref.clear();
  }

  static Future<void> setInt(String key, int value) async {
    await pref.setInt(key, value);
  }

  static int getInt(String key) {
    return pref.getInt(key) ?? 0;
  }

  static Future<void> setDouble(String key, double value) async {
    await pref.setDouble(key, value);
  }

  static double getDouble(String key) {
    return pref.getDouble(key) ?? 0.0;
  }

  static Future<void> setStringList(String key, List<String> value) async {
    await pref.setStringList(key, value);
  }

  static List<String> getStringList(String key) {
    return pref.getStringList(key) ?? [];
  }
}
