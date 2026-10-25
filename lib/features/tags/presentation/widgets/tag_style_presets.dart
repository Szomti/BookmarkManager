import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../tags.dart';

class TagStylePresetsCard extends ConsumerWidget {
  const TagStylePresetsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              const SectionTitle('Style Presets'),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 150),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      children: [
                        for (final style in ref.watch(
                          tagStyleBuiltInPresetsProvider,
                        ))
                          InkWell(
                            borderRadius: .circular(8.0),
                            onTap: () => ref
                                .read(newTagStyleProvider.notifier)
                                .changeStyle(style),
                            child: Padding(
                              padding: const .all(6.0),
                              child: TagWidget.preset(style),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SavePresetButton(),
            ],
          ),
        ),
      ],
    );
  }
}
