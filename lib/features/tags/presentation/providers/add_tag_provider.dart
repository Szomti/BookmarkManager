import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/tag_style.dart';
import 'tag_repository_provider.dart';

part 'add_tag_provider.g.dart';

@riverpod
class AddTag extends _$AddTag {
  @override
  Future<void> build() async {}

  Future<void> addTag(String label, TagStyle style) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(tagRepositoryProvider).addTag(label, style);
    });
  }
}
