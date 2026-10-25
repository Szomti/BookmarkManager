import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

class PageTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const PageTextFormField(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: .done,
      keyboardType: .number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: const InputDecoration(label: Text('Page')),
    );
  }
}
