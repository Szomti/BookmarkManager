import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

class ChapterTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const ChapterTextFormField(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        label: Text.rich(
          TextSpan(
            text: 'Chapter',
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ),
        ),
      ),
      validator: (String? value) {
        if (int.tryParse(value ?? '') != null) return null;
        return 'Field required';
      },
    );
  }
}
