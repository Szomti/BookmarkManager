import 'package:freezed_annotation/freezed_annotation.dart';

import 'tag_style.dart';

part 'tag.freezed.dart';

@freezed
@immutable
final class Tag with _$Tag {
  final int id;
  final String label;
  final TagStyle style;

  const Tag({required this.id, required this.label, required this.style});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tag && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
