import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../tags.dart';

class LabelTextFormField extends ConsumerWidget {
  final TextEditingController controller;

  const LabelTextFormField(this.controller, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: controller,
      textInputAction: .done,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      onChanged: (String value) =>
          ref.read(newTagLabelProvider.notifier).changeLabel(value),
      validator: (String? value) {
        if (value != null && value.isNotEmpty) return null;
        return 'Field required';
      },
      decoration: InputDecoration(
        label: Text.rich(
          TextSpan(
            text: 'Label',
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
