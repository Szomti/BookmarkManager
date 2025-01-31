import 'dart:convert';

import 'package:bookmark_manager/storage/tags/tag.dart';
import 'package:bookmark_manager/storage/tags/tags_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TagsStorage with ChangeNotifier {
  static const _iterableKey = 'TAGS_ITERABLE';
  static final instance = TagsStorage._();
  final TagsList list = TagsList([]);

  TagsStorage._();

  Future<void> addTag(Tag newTag) async {
    list.addTag(newTag);
    await save();
    notifyListeners();
  }

  Future<void> removeTag(Tag tag) async {
    list.removeTag(tag);
    await save();
    notifyListeners();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    String tagsJsonData = prefs.getString(_iterableKey) ?? '';
    if (tagsJsonData.isEmpty) return;
    Iterable<Object?> decodedJson =
        json.decode(tagsJsonData) as Iterable<Object?>;
    Iterable<Map<String, Object?>> jsonArray =
        decodedJson.map((item) => item as Map<String, Object?>);
    list.recreate([
      for (Map<String, Object?> jsonObject in jsonArray)
        Tag.fromJson(jsonObject),
    ]);
    notifyListeners();
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_iterableKey, json.encode(list.toJson()));
  }
}
