import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../services/bookmarks/handler.dart';
import '../../services/tags/handler.dart';
import 'bookmark.dart';

enum SortType {
  updateStartWithOld._('Update Time - Old first'),
  updateStartWithNew._('Update Time - New first'),
  creationStartWithOld._('Creation Time - Old first'),
  creationStartWithNew._('Creation Time - New first');

  final String text;

  const SortType._(this.text);
}

class Bookmarks {
  static const iterableKey = 'BOOKMARKS_ITERABLE';
  static ValueNotifier<bool> edited = ValueNotifier(false);
  static ValueNotifier<SortType> sortType = ValueNotifier(
    SortType.updateStartWithOld,
  );
  final Set<Bookmark> _items;
  final String testUuid = Uuid().v4();

  Bookmarks.fromStorage(Iterable<Bookmark> bookmarks)
    : _items = Set.of(bookmarks);

  Iterable<Bookmark> get items => _items.toList();

  Iterable<Bookmark> searchItems(String search) {
    final tags = tagsStorageHandler.getOrThrow();
    return items
        .where(
          (item) =>
              tags.canShow(item) &&
              item.title.toLowerCase().contains(search.toLowerCase()),
        )
        .toList();
  }

  void clear() {
    for (final item in _items) {
      item.dispose();
    }
    _items.clear();
  }

  Future<void> addBookmark(Bookmark bookmark) async {
    _items.removeWhere((item) {
      if (item != bookmark) return false;
      item.dispose();
      return true;
    });
    _items.add(bookmark);
    await bookmarksStorageHandler.saveToStorage();
  }

  Future<void> removeBookmark(Bookmark bookmark) async {
    _items.remove(bookmark);
    await bookmarksStorageHandler.saveToStorage();
  }

  void changeSortType(SortType type) {
    if (Bookmarks.sortType.value == type) return;
    Bookmarks.sortType.value = type;
    _resort(notify: true);
  }

  void _resort({bool notify = false}) {
    final temp = _items.toList();
    _items.clear();
    _items.addAll(temp);
  }

  static void changeEdited(bool newValue) {
    if (edited.value == newValue) return;
    edited.value = newValue;
  }

  // *** TO YEET *** //

  Iterable<Map<String, Object?>> exported() =>
      [for (final bookmark in _items) bookmark.toJson()].toList();

  Future<void> import(Iterable<Object?> jsonData) async {
    Iterable<Bookmark> copy = List.of(_items);
    bool inDanger = false;
    try {
      Iterable<Map<String, Object?>> jsonArray = jsonData.map(
        (item) => item as Map<String, Object?>,
      );
      clear();
      inDanger = true;
      for (final jsonObject in jsonArray) {
        _items.add(Bookmark.fromJson(jsonObject));
      }
      await bookmarksStorageHandler.saveToStorage();
    } catch (error, stackTrace) {
      debugPrint('[ERROR] $error\n$stackTrace');
      if (!inDanger) return;
      clear();
      _items.addAll(copy);
    }
  }
}
