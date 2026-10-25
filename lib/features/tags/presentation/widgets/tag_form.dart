import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../tags.dart';

class TagForm extends ConsumerStatefulWidget {
  const TagForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TagFormState();
}

class _TagFormState extends ConsumerState<TagForm> {
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  LabelTextFormField(_labelController),
                  const SizedBox(height: 16.0),
                  const Divider(),
                  const SectionTitle('Live Preview'),
                  const TagLivePreview(),
                  const SizedBox(height: 16.0),
                  const Divider(),
                  const TagStyleButtons(),
                  const SizedBox(height: 16.0),
                  const Divider(),
                  const TagStylePresetsCard(),
                  const Divider(),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
          TagFormActions(
            onSave: ref.watch(addTagProvider.select((s) => s.isLoading))
                ? null
                : _onSave,
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Future<void> _onSave() async {
    if (ref.read(addTagProvider).isLoading) return;
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) return;
    await ref
        .read(addTagProvider.notifier)
        .addTag(_labelController.text, ref.read(newTagStyleProvider));
    if (mounted) context.pop();
  }
}
