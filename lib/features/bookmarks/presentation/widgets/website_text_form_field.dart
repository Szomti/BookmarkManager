import 'package:material_ui/material_ui.dart';

class WebsiteTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const WebsiteTextFormField(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: .next,
      decoration: const InputDecoration(label: Text('Website')),
    );
  }
}
