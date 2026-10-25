import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../tags.dart';

class ColorPickerButton extends ConsumerWidget {
  final String dialogTitle;
  final String buttonLabel;
  final Color currentColor;
  final void Function(Color color) onColorSelected;

  const ColorPickerButton({
    required this.dialogTitle,
    required this.buttonLabel,
    required this.currentColor,
    required this.onColorSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () => _showColorPicker(context, ref),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [Text(buttonLabel), ColorTile(currentColor)],
      ),
    );
  }

  void _showColorPicker(BuildContext context, WidgetRef ref) {
    ref.read(pickerColorProvider.notifier).changeColor(currentColor);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(child: Text(dialogTitle)),
        titlePadding: const EdgeInsets.all(8.0),
        contentPadding: const EdgeInsets.all(0),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: currentColor,
            onColorChanged: (Color color) {
              ref.read(pickerColorProvider.notifier).changeColor(color);
            },
            labelTypes: const [],
            hexInputBar: true,
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            child: const Text('Confirm'),
            onPressed: () {
              final color = ref.read(pickerColorProvider);
              if (color != null) onColorSelected(color);
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}
