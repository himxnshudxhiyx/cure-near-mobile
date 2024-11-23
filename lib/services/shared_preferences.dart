import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  // Initialize shared preferences instance
  static SharedPreferences? _prefs;

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Set a string value in shared preferences
  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  /// Get a string value from shared preferences
  String? getString(String key) {
    return _prefs?.getString(key);
  }

  /// Set an integer value in shared preferences
  Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  /// Get an integer value from shared preferences
  int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  /// Set a boolean value in shared preferences
  Future<void> setBool(String key, bool value) async {
    try {
      await _prefs?.setBool(key, value);
      var result = _prefs?.getBool('isFirstTime');
      log('Result ->>>> ${result.toString()}');
    } catch (e) {
      log('Error in Shared Preferences --->>> ${e.toString()}');
    }
  }

  /// Get a boolean value from shared preferences
  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  /// Clear a specific key in shared preferences
  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  /// Clear all shared preferences
  Future<void> clearAll() async {
    await _prefs?.clear();
  }
}
