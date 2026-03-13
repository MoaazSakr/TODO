import 'package:hive/hive.dart';

class AppLocalStorage {
  static Box? userBox;

  static init() {
    userBox = Hive.box('userBox');
  }

  static cacheData(String key, String value) async {
    await userBox?.put(key, value);
  }

  static String getData(String key) {
    return userBox?.get(key) ?? '';
  }

  static void setData(String key, String? value) async {
    await userBox?.put(key, value);
  }
}
