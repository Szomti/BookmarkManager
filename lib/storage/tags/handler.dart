import 'package:bookmark_manager/models/tags/tags.dart';
import 'package:bookmark_manager/storage/system/system.dart';

import '../../models/tags/tag.dart';

final TagsStorageHandler tagsStorageHandler = TagsStorageHandler.instance;

class TagsStorageHandler extends StorageSystem<Tags> {
  static const _storageName = 'tags';
  static const iterableKey = 'TAGS_ITERABLE';
  static final instance = TagsStorageHandler._();

  TagsStorageHandler._() : super(_storageName);

  @override
  Tags fromJson(Map<String, Object?> jsonObject) {
    final JsonArray jsonArray =
        (jsonObject[iterableKey] as Iterable<Object?>).whereType<JsonObject>();
    return Tags.fromStorage([
      for (final bookmark in jsonArray) Tag.fromJson(bookmark),
    ]);
  }

  @override
  JsonObject toJson(Tags tags) {
    return {iterableKey: tags.list.toJson()};
  }

  @override
  Tags defaultObjectProvider() => Tags.fromStorage([]);
}
