import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../tags.dart';

class SavePresetButton extends ConsumerWidget {
  const SavePresetButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) {
            // TODO: Along with saving also add deleting
            // For example selecting presets and pressing delete icon
            // Don't forget about confirmation dialog
            // Maybe also show number of selected presets
            return const Dialog(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Not Implemented', textAlign: TextAlign.center),
              ),
            );
          },
        );
      },
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          const Text('Save as new preset'),
          TagWidget.preset(ref.watch(newTagStyleProvider)),
        ],
      ),
    );
  }
}
