import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static Future<void> storeMap(String key, Map<String, dynamic> map) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(map);
    await prefs.setString(key, jsonString);
  }

  static Future<Map<String, dynamic>?> retrieveMap(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }
  static Future<void> delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
