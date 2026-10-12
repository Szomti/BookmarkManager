import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../bookmarks.dart';
import '../../domain/entities/bookmark.dart';
import '../providers/add_bookmark_provider.dart';

class BookmarkForm extends ConsumerStatefulWidget {
  const BookmarkForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookmarkFormState();
}

class _BookmarkFormState extends ConsumerState<BookmarkForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _websiteController = TextEditingController();
  final _chapterController = TextEditingController();
  final _chapterSuffixController = TextEditingController();
  final _pageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _websiteController.dispose();
    _chapterController.dispose();
    _chapterSuffixController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            NameTextFormField(_nameController),
            const SizedBox(height: 16.0),
            ChapterTextFormField(_chapterController),
            const SizedBox(height: 16.0),
            WebsiteTextFormField(_websiteController),
            const SizedBox(height: 16.0),
            ChapterSuffixTextFormField(_chapterSuffixController),
            const SizedBox(height: 16.0),
            PageTextFormField(_pageController),
            const SizedBox(height: 16.0),
            const SelectTagsSection(),
            const SizedBox(height: 16.0),
            BookmarkFormActions(
              onSave: ref.watch(addBookmarkProvider).isLoading ? null : save,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> save() async {
    if (ref.read(addBookmarkProvider).isLoading) return;
    final state = _formKey.currentState;
    if (state == null || !state.validate()) return;
    final chapter = int.tryParse(_chapterController.text);
    final page = int.tryParse(_pageController.text);
    if (chapter == null) return;
    await ref.read(addBookmarkProvider.notifier).addBookmark((
      name: _nameController.text,
      website: _websiteController.text,
      bookmark: Bookmark(
        chapter: chapter,
        chapterSuffix: _chapterSuffixController.text,
        page: page,
      ),
    ));
    if (mounted) context.pop();
  }
}
