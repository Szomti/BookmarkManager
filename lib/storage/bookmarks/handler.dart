import 'package:bookmark_manager/models/bookmarks/bookmarks.dart';
import 'package:bookmark_manager/storage/system/system.dart';

import '../../models/bookmarks/bookmark.dart';

final BookmarksStorageHandler bookmarksStorageHandler =
    BookmarksStorageHandler.instance;

class BookmarksStorageHandler extends StorageSystem<Bookmarks> {
  static const _storageName = 'bookmarks';
  static const iterableKey = 'BOOKMARKS_ITERABLE';
  static final instance = BookmarksStorageHandler._();

  BookmarksStorageHandler._() : super(_storageName);

  @override
  Bookmarks fromJson(Map<String, Object?> jsonObject) {
    final JsonArray jsonArray =
        (jsonObject[iterableKey] as Iterable<Object?>).whereType<JsonObject>();
    return Bookmarks.fromStorage([
      for (final bookmark in jsonArray) Bookmark.fromJson(bookmark),
    ]);
  }

  @override
  JsonObject toJson(Bookmarks bookmarks) {
    return {
      iterableKey: [for (final bookmark in bookmarks.items) bookmark.toJson()],
    };
  }

  @override
  Bookmarks defaultObjectProvider() => Bookmarks.fromStorage([]);
}
