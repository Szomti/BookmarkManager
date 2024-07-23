import 'dart:collection';

import 'bookmark.dart';

class BookmarksStorage {
  static const _iterableKey = 'BOOKMARKS_ITERABLE';
  static final instance = BookmarksStorage._();
  static final Iterable<Bookmark> _items = SplayTreeSet<Bookmark>();

  BookmarksStorage._();

  Iterable<Bookmark> get items => _items.toList();
}
