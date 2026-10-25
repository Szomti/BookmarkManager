import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'picker_color_provider.g.dart';

@Riverpod(keepAlive: true)
class PickerColor extends _$PickerColor {
  @override
  Color? build() => null;

  void changeColor(Color color) => state = color;
}
