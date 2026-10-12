import 'package:material_ui/material_ui.dart';

import '../../bookmarks.dart';

class BookmarkFormPage extends StatelessWidget {
  const BookmarkFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookmark Form')),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: BookmarkForm(),
      ),
    );
  }
}
