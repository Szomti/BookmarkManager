import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../tags/tags.dart';
import 'bookmark.dart';

enum SortType {
  updateStartWithOld._('Update Time - Old first'),
  updateStartWithNew._('Update Time - New first'),
  creationStartWithOld._('Creation Time - Old first'),
  creationStartWithNew._('Creation Time - New first');

  final String text;

  const SortType._(this.text);
}

class BookmarksStorage with ChangeNotifier {
  static const _hugeAmountOfItemsThreshold = 50;
  static const _iterableKey = 'BOOKMARKS_ITERABLE';
  static const _countKey = 'BOOKMARKS_COUNT';
  static final instance = BookmarksStorage._();
  static final SplayTreeSet<Bookmark> _items = SplayTreeSet<Bookmark>();
  static ValueNotifier<bool> edited = ValueNotifier(false);
  static ValueNotifier<SortType> sortType = ValueNotifier(
    SortType.updateStartWithOld,
  );
  final TagsStorage _tagsStorage = TagsStorage.instance;
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  String _search = '';

  BookmarksStorage._();

  void handleFilterEdited() => notifyListeners();

  Iterable<Bookmark> get items => _items.toList();

  Iterable<Bookmark> get searchItems =>
      items
          .where(
            (item) =>
                _tagsStorage.canShow(item) &&
                item.title.toLowerCase().contains(_search.toLowerCase()),
          )
          .toList();

  void clear() {
    for (final item in _items) {
      item.dispose();
    }
    _items.clear();
  }

  set search(String value) {
    if (_search == value) return;
    _search = value;
    notifyListeners();
  }

  Future<void> load() async {
    await prefs.remove(_countKey);
    final iterable = await prefs.getStringList(_iterableKey) ?? [];
    final slowDown = iterable.length >= _hugeAmountOfItemsThreshold;
    clear();
    for (final item in iterable) {
      _items.add(Bookmark.fromJson(json.decode(item) as Map<String, Object?>));
      if (slowDown) await Future.delayed(const Duration(milliseconds: 2));
    }
    notifyListeners();
  }

  Future<void> addBookmark(Bookmark bookmark) async {
    _items.removeWhere((item) {
      if (item != bookmark) return false;
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
    await prefs.setStringList(_iterableKey, bookmarksToSave().toList());
    _resort();
    notifyListeners();
  }

  void changeSortType(SortType type) {
    if (BookmarksStorage.sortType.value == type) return;
    BookmarksStorage.sortType.value = type;
    _resort(notify: true);
  }

  void _resort({bool notify = false}) {
    final temp = _items.toList();
    _items.clear();
    _items.addAll(temp);
    if (notify) notifyListeners();
  }

  Iterable<String> bookmarksToSave() sync* {
    for (final bookmark in _items) {
      yield json.encode(bookmark.toJson());
    }
  }

  String exported() => json.encode(_items.toList());

  Future<void> import(String jsonData) async {
    Iterable<Bookmark> copy = List.of(_items);
    bool inDanger = false;
    try {
      Iterable<Object?> decodedJson =
          json.decode(jsonData) as Iterable<Object?>;
      Iterable<Map<String, Object?>> jsonArray = decodedJson.map(
        (item) => item as Map<String, Object?>,
      );
      final slowDown = jsonArray.length >= _hugeAmountOfItemsThreshold;
      clear();
      inDanger = true;
      for (final jsonObject in jsonArray) {
        _items.add(Bookmark.fromJson(jsonObject));
        if (slowDown) await Future.delayed(const Duration(milliseconds: 2));
      }
      await save();
    } catch (error, stackTrace) {
      debugPrint('[ERROR] $error\n$stackTrace');
      if (!inDanger) return;
      clear();
      _items.addAll(copy);
    }
    notifyListeners();
  }

  static void changeEdited(bool newValue) {
    if (edited.value == newValue) return;
    edited.value = newValue;
  }
}
