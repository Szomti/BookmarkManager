import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class SelectTagsSection extends StatelessWidget {
  const SelectTagsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(
          children: [
            Expanded(
              child: TextButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      // TODO: Add option for selecting tags
                      return const Dialog(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Not Implemented',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  );
                },
                label: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // TODO: Show actual number of selected tags
                  children: [Text('Select tags'), Text('(0)')],
                ),
                icon: const Icon(Symbols.edit),
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
