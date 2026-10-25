import 'package:material_ui/material_ui.dart';

class ChapterSuffixTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const ChapterSuffixTextFormField(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: .next,
      decoration: const InputDecoration(label: Text('Chapter Suffix')),
    );
  }
}
