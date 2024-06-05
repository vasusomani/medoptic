import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  //Save Data
  Future<bool> saveStringData(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  Future<bool> saveBoolData(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  Future<bool> saveStringListData(String key, List<String> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, value);
  }

  //Get Data
  Future<String?> getStringData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<bool?> getBoolData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future<List<String>?> getStringListData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  //Remove Data
  Future<bool> removeStringData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  Future<bool> removeBoolData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  Future<bool> removeStringListData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
