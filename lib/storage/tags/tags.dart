import 'dart:convert';
import 'package:bookmark_manager/storage/bookmarks/bookmark.dart';
import 'package:bookmark_manager/storage/tags/tag.dart';
import 'package:bookmark_manager/storage/tags/tags_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TagsStorage with ChangeNotifier {
  static const iterableKey = 'TAGS_ITERABLE';
  static final instance = TagsStorage._();
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  final TagsList list = TagsList([]);

  TagsStorage._();

  Future<void> addTag(Tag newTag) async {
    list.addTag(newTag);
    await save();
    notifyListeners();
  }

  Future<void> updateTag(Tag changedTag) async {
    list.removeTag(changedTag);
    list.addTag(changedTag);
    await save();
    notifyListeners();
  }

  Future<void> removeTag(Tag tag) async {
    list.removeTag(tag);
    await save();
    notifyListeners();
  }

  bool canShow(Bookmark bookmark) {
    if (bookmark.tags.any((tag) => list.excluded.contains(tag))) return false;
    return list.show.every((tag) => bookmark.tags.contains(tag));
  }

  Iterable<Map<String, Object?>> exported() => list.toJson().toList();

  Future<void> import(Iterable<Object?> jsonData) async {
    Iterable<Tag> copy = List.of(list.tags);
    bool inDanger = false;
    try {
      Iterable<Map<String, Object?>> jsonArray = jsonData.map(
        (item) => item as Map<String, Object?>,
      );
      list.clear();
      inDanger = true;
      for (final jsonObject in jsonArray) {
        list.addTag(Tag.fromJson(jsonObject));
      }
      await save();
    } catch (error, stackTrace) {
      debugPrint('[ERROR] $error\n$stackTrace');
      if (!inDanger) return;
      list.clear();
      for (final tag in copy) {
        list.addTag(tag);
      }
    }
    notifyListeners();
  }

  Future<void> load() async {
    String tagsJsonData = await prefs.getString(iterableKey) ?? '';
    if (tagsJsonData.isEmpty) return;
    Iterable<Object?> decodedJson =
        json.decode(tagsJsonData) as Iterable<Object?>;
    Iterable<Map<String, Object?>> jsonArray = decodedJson.map(
      (item) => item as Map<String, Object?>,
    );
    list.recreate([
      for (Map<String, Object?> jsonObject in jsonArray)
        Tag.fromJson(jsonObject),
    ]);
    notifyListeners();
  }

  Future<void> save() async {
    await prefs.setString(iterableKey, json.encode(list.toJson()));
  }
}
