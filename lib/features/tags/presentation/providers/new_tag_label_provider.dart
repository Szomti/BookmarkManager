import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'new_tag_label_provider.g.dart';

@riverpod
class NewTagLabel extends _$NewTagLabel {
  @override
  String build() => '';

  void changeLabel(String label) => state = label;
}