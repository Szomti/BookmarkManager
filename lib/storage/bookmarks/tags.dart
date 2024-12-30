import 'dart:collection';

import 'package:bookmark_manager/storage/bookmarks/tag.dart';

class Tags extends Iterable<Tag> {
  final SplayTreeSet<Tag> tags;

  Tags(Iterable<Tag> tags) : tags = SplayTreeSet.of(tags);

  factory Tags.fromJson(Iterable<Map<String, Object?>> jsonArray) {
    return Tags([
      for (Map<String, Object?> jsonObject in jsonArray)
        Tag.fromJson(jsonObject),
    ]);
  }

  @override
  Iterator<Tag> get iterator => tags.toList().iterator;

  Iterable<Map<String, Object?>> toJson() {
    return [for (Tag tag in tags) tag.toJson()];
  }

  void addTag(Tag tag) => tags.add(tag);

  void removeTag(Tag tag) => tags.remove(tag);
}
