import 'package:shared_preferences/shared_preferences.dart';

class SettingsStorage {
  static final instance = SettingsStorage._();
  static const _textTagsKey = 'settingsTextTags';
  bool textTags = false;

  SettingsStorage._();

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    textTags = prefs.getBool(_textTagsKey) ?? true;
  }

  Future<void> setTextTags(bool value) async {
    textTags = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_textTagsKey, value);
  }
}
