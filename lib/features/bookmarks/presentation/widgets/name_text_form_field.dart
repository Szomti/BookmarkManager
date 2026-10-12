import 'package:material_ui/material_ui.dart';

class NameTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const NameTextFormField(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        label: Text.rich(
          TextSpan(
            text: 'Name',
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
        if (value != null && value.isNotEmpty) return null;
        return 'Field required';
      },
    );
  }
}
