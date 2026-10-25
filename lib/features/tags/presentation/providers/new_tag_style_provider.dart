import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/tag_style.dart';
import 'tag_style_presets_provider.dart';

part 'new_tag_style_provider.g.dart';

@riverpod
class NewTagStyle extends _$NewTagStyle {
  @override
  TagStyle build() {
    final defaultStyle = ref.read(tagStyleBuiltInPresetsProvider).elementAt(0);
    return TagStyle(
      borderColor: defaultStyle.borderColor,
      backgroundColor: defaultStyle.backgroundColor,
      textColor: defaultStyle.textColor,
    );
  }

  void changeStyle(TagStyle style) => state = style;

  void changeBorder(Color color) {
    state = state.copyWith(borderColor: color);
  }

  void changeBackground(Color color) {
    state = state.copyWith(backgroundColor: color);
  }

  void changeText(Color color) {
    state = state.copyWith(textColor: color);
  }
}
