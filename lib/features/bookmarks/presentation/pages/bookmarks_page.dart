import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Bookmarks'),
        TextButton(
          onPressed: () => context.go('/bookmarks/form'),
          child: const Text('Go to Bookmark Form [DEV]'),
        ),
      ],
    );
  }
}
