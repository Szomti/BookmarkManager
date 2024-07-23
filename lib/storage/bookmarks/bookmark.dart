class Bookmark {
  static const _idKey = 'id';
  static const _textKey = 'text';
  static const _ordinalKey = 'ordinal';
  static const _chapterKey = 'chapter';

  final int id;
  final String text;
  final int ordinal;
  final Chapter chapter;

  Bookmark({
    required this.id,
    required this.text,
    required this.ordinal,
    required this.chapter,
  });

  Map<String, Object?> toJson() {
    return {
      _idKey: id,
      _textKey: text,
      _ordinalKey: ordinal,
      _chapterKey: chapter.toJson(),
    };
  }

  static Bookmark fromJson(Map<String, Object?> object) {
    throw ('Not implemented yet');
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Bookmark && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class Chapter {
  static const _mainKey = 'main';
  static const _subKey = 'sub';

  final int main;
  final int sub;

  Chapter({
    required this.main,
    required this.sub,
  });

  Map<String, Object?> toJson() {
    return {
      _mainKey: main,
      _subKey: sub,
    };
  }
}
