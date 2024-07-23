import 'dart:collection';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'bookmark.dart';

class BookmarksStorage {
  static const _iterableKey = 'BOOKMARKS_ITERABLE';
  static const _countKey = 'BOOKMARKS_COUNT';
  static const _defaultCount = 0;
  static final instance = BookmarksStorage._();
  static final Iterable<Bookmark> _items = SplayTreeSet<Bookmark>();
  static int count = _defaultCount;

  BookmarksStorage._();

  Iterable<Bookmark> get items => _items.toList();

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    count = prefs.getInt(_countKey) ?? _defaultCount;
    final iterable = prefs.getStringList(_iterableKey) ?? [];
    final tempItems = SplayTreeSet<Bookmark>();
    for (final item in iterable) {
      tempItems.add(
        Bookmark.fromJson(json.decode(item) as Map<String, Object?>),
      );
    }
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_countKey, count);
    prefs.setStringList(_iterableKey, _bookmarksToSave().toList());
  }

  Iterable<String> _bookmarksToSave() sync* {
    for (final bookmark in _items) {
      yield json.encode(bookmark.toJson());
    }
  }
}
