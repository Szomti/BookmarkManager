import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'tag_filter_state.dart';

class Tag with ChangeNotifier implements Comparable<Tag> {
  static const _uuidKey = 'uuid';
  static const _labelKey = 'label';
  static const _filterStateKey = 'filterState';
  static const _labelColorKey = 'labelColor';
  static const _backgroundColorKey = 'backgroundColor';
  static const _borderColorKey = 'borderColor';
  final String _uuid;
  String label;
  TagFilterState _filterState;
  Color labelColor;
  Color backgroundColor;
  Color borderColor;

  String get uuid => _uuid;

  TagFilterState get filterState => _filterState;

  set filterState(TagFilterState state) {
    _filterState = state;
    notifyListeners();
  }

  Tag({
    String? uuid,
    required this.label,
    TagFilterState? filterState,
    required this.labelColor,
    required this.backgroundColor,
    required this.borderColor,
  }) : _uuid = uuid ?? const Uuid().v4(),
       _filterState = filterState ?? TagFilterState.none;

  factory Tag.fromJson(Map<String, Object?> jsonObject) {
    return Tag(
      uuid: jsonObject[_uuidKey] as String,
      label: jsonObject[_labelKey] as String,
      filterState: TagFilterState.fromId(jsonObject[_filterStateKey] as int?),
      labelColor: Color(jsonObject[_labelColorKey] as int),
      backgroundColor: Color(jsonObject[_backgroundColorKey] as int),
      borderColor: Color(jsonObject[_borderColorKey] as int),
    );
  }

  @override
  int compareTo(Tag other) {
    final result = label.compareTo(other.label);
    return result == 0 ? _uuid.compareTo(other._uuid) : result;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tag && runtimeType == other.runtimeType && _uuid == other._uuid;

  @override
  int get hashCode => _uuid.hashCode;

  Map<String, Object?> toJson() {
    return {
      _uuidKey: _uuid,
      _labelKey: label,
      _filterStateKey: filterState.id,
      _labelColorKey: labelColor.toARGB32(),
      _backgroundColorKey: backgroundColor.toARGB32(),
      _borderColorKey: borderColor.toARGB32(),
    };
  }
}
