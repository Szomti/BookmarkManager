import 'package:bookmark_manager/storage/bookmarks/bookmarks.dart';
import 'package:flutter/material.dart';

class Bookmark with ChangeNotifier implements Comparable<Bookmark> {
  static const _idKey = 'id';
  static const _titleKey = 'text';
  static const _updatedAtKey = 'updatedAt';
  static const _createdAtKey = 'createdAt';
  static const _chapterKey = 'chapter';

  final int id;
  final DateTime createdAt;
  DateTime _updatedAt;
  String _title;
  Chapter _chapter;

  Bookmark({
    int? customId,
    required String title,
    required DateTime updatedAt,
    required this.createdAt,
    required Chapter chapter,
  })  : id = customId ?? BookmarksStorage.count + 1,
        _title = title,
        _updatedAt = updatedAt,
        _chapter = chapter {
    if (customId == null) BookmarksStorage.count += 1;
  }

  Map<String, Object?> toJson() {
    return {
      _idKey: id,
      _titleKey: _title,
      _updatedAtKey: _updatedAt.millisecondsSinceEpoch,
      _createdAtKey: createdAt.millisecondsSinceEpoch,
      _chapterKey: _chapter.toJson(),
    };
  }

  static Bookmark fromJson(Map<String, Object?> jsonObject) {
    return Bookmark(
      customId: jsonObject[_idKey] as int,
      title: jsonObject[_titleKey] as String,
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
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Bookmark && runtimeType == other.runtimeType && id == other.id;

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
        result = _updatedAt.compareTo(other._updatedAt);
      case SortType.updateStartWithNew:
        result = other._updatedAt.compareTo(_updatedAt);
    }
    return result == 0 ? id.compareTo(other.id) : result;
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
