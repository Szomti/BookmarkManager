import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class TagsPage extends StatelessWidget {

  const TagsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Tags'),
        TextButton(
          onPressed: () => context.go('/tags/form'),
          child: const Text('Go to Tag Form [DEV]'),
        ),
      ],
    );
  }
}