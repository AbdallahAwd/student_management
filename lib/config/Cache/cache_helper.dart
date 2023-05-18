import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_system/config/resources/cache_keys.dart';

class Cache {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({required key}) {
    return sharedPreferences.get(key.toString());
  }

  static Future<bool> saveData({
    required CacheKeys key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key.toString(), value);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key.toString(), value);
    }
    if (value is bool) {
      return await sharedPreferences.setBool(key.toString(), value);
    }
    return await sharedPreferences.setDouble(key.toString(), value);
  }

  static Future<bool> removeData(key) async {
    return await sharedPreferences.remove(key.toString());
  }

  static Future<bool> setStrings(key, List<String> value) async {
    return await sharedPreferences.setStringList(key.toString(), value);
  }

  static Future<List<String>?> getStrings(key) async {
    return sharedPreferences.getStringList(key.toString());
  }
}
