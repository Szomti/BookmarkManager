class Tag implements Comparable<Tag> {
  static const _uuidKey = 'uuid';
  static const _textKey = 'text';
  final String uuid;
  final String text;

  Tag({required this.uuid, required this.text});

  factory Tag.fromJson(Map<String, Object?> jsonObject) {
    return Tag(
      uuid: jsonObject[_uuidKey] as String,
      text: jsonObject[_textKey] as String,
    );
  }

  @override
  int compareTo(Tag other) {
    final result = text.compareTo(other.text);
    return result == 0 ? uuid.compareTo(other.uuid) : result;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tag && runtimeType == other.runtimeType && uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;

  Map<String, Object?> toJson() {
    return {
      _uuidKey: uuid,
      _textKey: text,
    };
  }
}
