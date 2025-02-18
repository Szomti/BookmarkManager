import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsStorage {
  static final instance = SettingsStorage._();
  static const settingsKey = 'SETTINGS';
  static const _textTagsKey = 'settingsTextTags';
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  bool textTags = false;

  SettingsStorage._();

  Map<String, Object?> exported() => {_textTagsKey: textTags};

  Future<void> import(Map<String, Object?> jsonData) async {
    try {
      await setTextTags(jsonData[_textTagsKey] as bool);
    } catch (error, stackTrace) {
      debugPrint('[ERROR] $error\n$stackTrace');
    }
  }

  Future<void> initialize() async {
    textTags = await prefs.getBool(_textTagsKey) ?? false;
  }

  Future<void> setTextTags(bool value) async {
    textTags = value;
    await prefs.setBool(_textTagsKey, value);
  }
}
