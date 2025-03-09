import 'package:bookmark_manager/models/tags/tag.dart';
import 'package:bookmark_manager/models/tags/tags_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../models/bookmarks/bookmark.dart';
import '../../storage/tags/handler.dart';

class Tags {
  static const iterableKey = 'TAGS_ITERABLE';
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  final TagsList list;
  final String testUuid = Uuid().v4();

  Tags.fromStorage(Iterable<Tag> tags) : list = TagsList(tags);

  Future<void> addTag(Tag newTag) async {
    list.addTag(newTag);
    await tagsStorageHandler.saveToStorage();
  }

  Future<void> updateTag(Tag changedTag) async {
    list.removeTag(changedTag);
    list.addTag(changedTag);
    await tagsStorageHandler.saveToStorage();
  }

  Future<void> removeTag(Tag tag) async {
    list.removeTag(tag);
    await tagsStorageHandler.saveToStorage();
  }

  bool canShow(Bookmark bookmark) {
    final bookmarkTags = bookmark.createTags();
    if (bookmarkTags.any((tag) => list.excluded.contains(tag))) return false;
    return list.show.every((tag) => bookmarkTags.contains(tag));
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
      await tagsStorageHandler.saveToStorage();
    } catch (error, stackTrace) {
      debugPrint('[ERROR] $error\n$stackTrace');
      if (!inDanger) return;
      list.clear();
      for (final tag in copy) {
        list.addTag(tag);
      }
    }
  }
}
