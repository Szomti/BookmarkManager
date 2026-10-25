import 'package:material_ui/material_ui.dart';

import '../../tags.dart';

class TagFormPage extends StatelessWidget {
  const TagFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tag Form')),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: TagForm(),
      ),
    );
  }
}
