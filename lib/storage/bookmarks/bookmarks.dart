import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bookmark.dart';

class BookmarksStorage with ChangeNotifier {
  static const _hugeAmountOfItemsThreshold = 50;
  static const _iterableKey = 'BOOKMARKS_ITERABLE';
  static const _countKey = 'BOOKMARKS_COUNT';
  static const _defaultCount = 0;
  static final instance = BookmarksStorage._();
  static final SplayTreeSet<Bookmark> _items = SplayTreeSet<Bookmark>();
  static int count = _defaultCount;
  static ValueNotifier<bool> edited = ValueNotifier(false);

  BookmarksStorage._();

  Iterable<Bookmark> get items => _items.toList();

  void clear() {
    for(final item in _items) {
      item.dispose();
    }
    _items.clear();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    count = prefs.getInt(_countKey) ?? _defaultCount;
    final iterable = prefs.getStringList(_iterableKey) ?? [];
    final slowDown = iterable.length >= _hugeAmountOfItemsThreshold;
    clear();
    for (final item in iterable) {
      _items.add(
        Bookmark.fromJson(json.decode(item) as Map<String, Object?>),
      );
      if(slowDown) await Future.delayed(const Duration(milliseconds: 2));
    }
    notifyListeners();
  }

  Future<void> addBookmark(Bookmark bookmark) async {
    _items.removeWhere((item) {
      if(item != bookmark) return false;
      item.dispose();
      return true;
    });
    _items.add(bookmark);
    await save();
  }

  Future<void> removeBookmark(Bookmark bookmark) async {
    _items.remove(bookmark);
    await save();
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_countKey, count);
    await prefs.setStringList(_iterableKey, _bookmarksToSave().toList());
    notifyListeners();
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
