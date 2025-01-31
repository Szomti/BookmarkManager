import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Tag implements Comparable<Tag> {
  static const _uuidKey = 'uuid';
  static const _textKey = 'label';
  static const _labelColorKey = 'labelColor';
  static const _backgroundColorKey = 'backgroundColor';
  static const _borderColorKey = 'borderColor';
  final String uuid;
  String label;
  Color labelColor;
  Color backgroundColor;
  Color borderColor;

  Tag({
    String? uuid,
    required this.label,
    required this.labelColor,
    required this.backgroundColor,
    required this.borderColor,
  }) : uuid = uuid ?? const Uuid().v4();

  factory Tag.fromJson(Map<String, Object?> jsonObject) {
    return Tag(
      uuid: jsonObject[_uuidKey] as String,
      label: jsonObject[_textKey] as String,
      labelColor: Color(jsonObject[_labelColorKey] as int),
      backgroundColor: Color(jsonObject[_backgroundColorKey] as int),
      borderColor: Color(jsonObject[_borderColorKey] as int),
    );
  }

  @override
  int compareTo(Tag other) {
    final result = label.compareTo(other.label);
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
      _textKey: label,
      _labelColorKey: labelColor.value,
      _backgroundColorKey: backgroundColor.value,
      _borderColorKey: borderColor.value,
    };
  }
}
