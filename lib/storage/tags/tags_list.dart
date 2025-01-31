import 'dart:collection';

import 'package:bookmark_manager/storage/tags/tag.dart';

class TagsList extends Iterable<Tag> {
  final SplayTreeSet<Tag> _tags;
  final Map<String, Tag> _tagsMap;

  TagsList(Iterable<Tag> tags)
      : _tags = SplayTreeSet.of(tags),
        _tagsMap = {
          for (final tag in tags) tag.uuid: tag,
        };

  factory TagsList.fromJson(Iterable<Map<String, Object?>> jsonArray) {
    return TagsList([
      for (Map<String, Object?> jsonObject in jsonArray)
        Tag.fromJson(jsonObject),
    ]);
  }

  Iterable<Tag> get tags => _tags.toList();

  @override
  Iterator<Tag> get iterator => tags.iterator;

  Iterable<Map<String, Object?>> toJson() {
    return [for (Tag tag in tags) tag.toJson()];
  }

  void recreate(Iterable<Tag> tags) {
    _tags.clear();
    _tagsMap.clear();
    _tags.addAll(tags);
    for (final tag in tags) {
      _tagsMap[tag.uuid] = tag;
    }
  }

  void addTag(Tag newTag) {
    _tags.removeWhere((tag) => tag == newTag);
    _tags.add(newTag);
    _tagsMap[newTag.uuid] = newTag;
  }

  void removeTag(Tag tag) {
    _tags.remove(tag);
    _tagsMap.remove(tag.uuid);
  }

  Tag? fromUuid(String uuid) => _tagsMap[uuid];
}
