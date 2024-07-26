import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bookmark.dart';

class BookmarksStorage with ChangeNotifier {
  static const _iterableKey = 'BOOKMARKS_ITERABLE';
  static const _countKey = 'BOOKMARKS_COUNT';
  static const _defaultCount = 0;
  static final instance = BookmarksStorage._();
  static final SplayTreeSet<Bookmark> _items = SplayTreeSet<Bookmark>();
  static int count = _defaultCount;
  static ValueNotifier<bool> edited = ValueNotifier(false);

  BookmarksStorage._();

  Iterable<Bookmark> get items => _items.toList();

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    count = prefs.getInt(_countKey) ?? _defaultCount;
    final iterable = prefs.getStringList(_iterableKey) ?? [];
    _items.clear();
    for (final item in iterable) {
      _items.add(
        Bookmark.fromJson(json.decode(item) as Map<String, Object?>),
      );
    }
    notifyListeners();
    changeEdited(false);
  }

  Future<void> addBookmark(Bookmark bookmark) async {
    _items.add(bookmark);
    await save();
  }

  Future<void> removeBookmark(Bookmark bookmark) async {
    _items.remove(bookmark);
    await save();
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_countKey, count);
    prefs.setStringList(_iterableKey, _bookmarksToSave().toList());
    notifyListeners();
    changeEdited(false);
  }

  Iterable<String> _bookmarksToSave() sync* {
    for (final bookmark in _items) {
      yield json.encode(bookmark.toJson());
    }
  }

  static void changeEdited(bool newValue) {
    if(edited.value == newValue) return;
    edited.value = newValue;
  }
}
