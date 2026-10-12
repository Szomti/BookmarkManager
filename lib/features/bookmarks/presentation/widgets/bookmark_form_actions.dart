import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class BookmarkFormActions extends StatelessWidget {
  final void Function()? onSave;

  const BookmarkFormActions({required this.onSave, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: SizedBox(
              key: ValueKey(onSave != null),
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: onSave,
                label: const Text('Save'),
                icon: const Icon(Symbols.save, fill: 1.0),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: OutlinedButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
        ),
      ],
    );
  }
}
