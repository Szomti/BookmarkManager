import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_style.freezed.dart';

@freezed
@immutable
final class TagStyle with _$TagStyle {
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;

  const TagStyle({
    required this.borderColor,
    required this.backgroundColor,
    required this.textColor,
  });
}
