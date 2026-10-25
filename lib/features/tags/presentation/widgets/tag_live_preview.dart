import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../tags.dart';

class TagLivePreview extends ConsumerWidget {
  const TagLivePreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = ref.watch(newTagStyleProvider);
    return TagWidget(
      label: ref.watch(newTagLabelProvider),
      borderColor: style.borderColor,
      backgroundColor: style.backgroundColor,
      textColor: style.textColor,
    );
  }
}
