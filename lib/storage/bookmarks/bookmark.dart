import 'package:flutter/material.dart';

class Bookmark with ChangeNotifier {
  static const _idKey = 'id';
  static const _textKey = 'text';
  static const _ordinalKey = 'ordinal';
  static const _chapterKey = 'chapter';

  final int id;
  String _text;
  int _ordinal;
  Chapter _chapter;

  Bookmark({
    required this.id,
    required String text,
    required int ordinal,
    required Chapter chapter,
  })  : _text = text,
        _ordinal = ordinal,
        _chapter = chapter;

  Map<String, Object?> toJson() {
    return {
      _idKey: id,
      _textKey: _text,
      _ordinalKey: _ordinal,
      _chapterKey: _chapter.toJson(),
    };
  }

  static Bookmark fromJson(Map<String, Object?> object) {
    throw ('Not implemented yet');
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Bookmark && runtimeType == other.runtimeType && id == other.id;

  String get text => _text;

  set text(String value) {
    _text = value;
    notifyListeners();
  }

  @override
  int get hashCode => id.hashCode;

  int get ordinal => _ordinal;

  set ordinal(int value) {
    _ordinal = value;
    notifyListeners();
  }

  Chapter get chapter => _chapter;

  set chapter(Chapter value) {
    _chapter = value;
    notifyListeners();
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
}
