import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../tags.dart';

class TagStyleButtons extends ConsumerWidget {
  const TagStyleButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStyle = ref.watch(newTagStyleProvider);
    return Column(
      children: [
        const SectionTitle('Style Customization'),
        ColorPickerButton(
          dialogTitle: 'Border',
          buttonLabel: 'Border color',
          currentColor: currentStyle.borderColor,
          onColorSelected: ref.read(newTagStyleProvider.notifier).changeBorder,
        ),
        ColorPickerButton(
          dialogTitle: 'Background',
          buttonLabel: 'Background color',
          currentColor: currentStyle.backgroundColor,
          onColorSelected: ref
              .read(newTagStyleProvider.notifier)
              .changeBackground,
        ),
        ColorPickerButton(
          dialogTitle: 'Text',
          buttonLabel: 'Text color',
          currentColor: currentStyle.textColor,
          onColorSelected: ref.read(newTagStyleProvider.notifier).changeText,
        ),
      ],
    );
  }
}
