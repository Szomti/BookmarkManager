import 'package:bookmark_manager/storage/bookmarks/bookmarks.dart';
import 'package:bookmark_manager/storage/tags/tags_list.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../tags/tag.dart';

class Bookmark with ChangeNotifier implements Comparable<Bookmark> {
  static const _uuidKey = 'uuid';
  static const _titleKey = 'text';
  static const _tagsKey = 'tags';
  static const _updatedAtKey = 'updatedAt';
  static const _createdAtKey = 'createdAt';
  static const _chapterKey = 'chapter';

  final String uuid;
  final DateTime createdAt;
  final TagsList _tags;
  DateTime _updatedAt;
  String _title;
  Chapter _chapter;

  Bookmark({
    String? uuid,
    required String title,
    required TagsList tags,
    required DateTime updatedAt,
    required this.createdAt,
    required Chapter chapter,
  })  : uuid = uuid ?? const Uuid().v4(),
        _tags = tags,
        _title = title,
        _updatedAt = updatedAt,
        _chapter = chapter;

  Map<String, Object?> toJson() {
    return {
      _uuidKey: uuid,
      _titleKey: _title,
      _tagsKey: _tags.toJson(),
      _updatedAtKey: _updatedAt.millisecondsSinceEpoch,
      _createdAtKey: createdAt.millisecondsSinceEpoch,
      _chapterKey: _chapter.toJson(),
    };
  }

  factory Bookmark.fromJson(Map<String, Object?> jsonObject) {
    Iterable<Object?> tagsList = jsonObject[_tagsKey] as Iterable<Object?>;
    Iterable<Map<String, Object?>> jsonArray =
        tagsList.map((item) => item as Map<String, Object?>);
    return Bookmark(
      uuid: jsonObject[_uuidKey] as String,
      title: jsonObject[_titleKey] as String,
      tags: TagsList.fromJson(jsonArray),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        jsonObject[_updatedAtKey] as int,
        isUtc: true,
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        jsonObject[_createdAtKey] as int,
        isUtc: true,
      ),
      chapter: Chapter.fromJson(
        jsonObject[_chapterKey] as Map<String, Object?>,
      ),
    );
  }

  @override
  int get hashCode => uuid.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Bookmark &&
          runtimeType == other.runtimeType &&
          uuid == other.uuid;

  String get title => _title;

  set title(String value) {
    _title = value;
    _handleEdit();
  }

  Chapter get chapter => _chapter;

  DateTime get updatedAt => _updatedAt;

  set chapter(Chapter value) {
    _chapter = value;
    _updatedAt = DateTime.timestamp();
    _handleEdit();
  }

  void addTag(Tag tag) {
    _tags.addTag(tag);
    _handleEdit();
  }

  void removeTag(Tag tag) {
    _tags.removeTag(tag);
    _handleEdit();
  }

  void _handleEdit() {
    notifyListeners();
    BookmarksStorage.changeEdited(true);
  }

  @override
  int compareTo(Bookmark other) {
    int result = 0;
    switch (BookmarksStorage.sortType.value) {
      case SortType.creationStartWithOld:
        result = createdAt.compareTo(other.createdAt);
      case SortType.creationStartWithNew:
        result = other.createdAt.compareTo(createdAt);
      case SortType.updateStartWithOld:
        result = updatedAt.compareTo(other.updatedAt);
      case SortType.updateStartWithNew:
        result = other.updatedAt.compareTo(updatedAt);
    }
    return result == 0 ? uuid.compareTo(other.uuid) : result;
  }
}

class Chapter {
  static const _mainKey = 'main';
  static const _subKey = 'sub';

  int main;
  String sub;

  String get info => '$main$sub';

  Chapter({
    required this.main,
    this.sub = '',
  });

  Map<String, Object?> toJson() {
    return {
      _mainKey: main,
      _subKey: sub,
    };
  }

  static Chapter fromJson(Map<String, Object?> jsonObject) {
    return Chapter(
      main: jsonObject[_mainKey] as int,
      sub: jsonObject[_subKey] as String,
    );
  }
}
