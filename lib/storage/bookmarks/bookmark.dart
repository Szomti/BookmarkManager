import 'package:bookmark_manager/storage/bookmarks/bookmarks.dart';
import 'package:flutter/material.dart';

class Bookmark with ChangeNotifier implements Comparable<Bookmark> {
  static const _idKey = 'id';
  static const _titleKey = 'text';
  static const _ordinalKey = 'ordinal';
  static const _chapterKey = 'chapter';

  final int id;
  String _title;
  int _ordinal;
  Chapter _chapter;

  Bookmark({
    int? id,
    required String title,
    required int ordinal,
    required Chapter chapter,
  })  : id = BookmarksStorage.count + 1,
        _title = title,
        _ordinal = ordinal,
        _chapter = chapter {
    BookmarksStorage.count += 1;
  }

  Map<String, Object?> toJson() {
    return {
      _idKey: id,
      _titleKey: _title,
      _ordinalKey: _ordinal,
      _chapterKey: _chapter.toJson(),
    };
  }

  static Bookmark fromJson(Map<String, Object?> jsonObject) {
    return Bookmark(
      id: jsonObject[_idKey] as int,
      title: jsonObject[_titleKey] as String,
      ordinal: jsonObject[_ordinalKey] as int,
      chapter: Chapter.fromJson(
        jsonObject[_chapterKey] as Map<String, Object?>,
      ),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Bookmark && runtimeType == other.runtimeType && id == other.id;

  String get title => _title;

  set title(String value) {
    _title = value;
    _handleEdit();
  }

  @override
  int get hashCode => id.hashCode;

  int get ordinal => _ordinal;

  set ordinal(int value) {
    _ordinal = value;
    _handleEdit();
  }

  Chapter get chapter => _chapter;

  set chapter(Chapter value) {
    _chapter = value;
    _handleEdit();
  }

  void _handleEdit() {
    notifyListeners();
    BookmarksStorage.changeEdited(true);
  }

  @override
  int compareTo(Bookmark other) {
    return ordinal.compareTo(other.ordinal);
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
