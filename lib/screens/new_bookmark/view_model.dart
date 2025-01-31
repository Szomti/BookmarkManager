part of 'library.dart';

class NewBookmarkScreenViewModel {
  static const _loadingDelay = Duration(milliseconds: 250);
  final titleController = TextEditingController();
  final chapterController = TextEditingController();
  final subChapterController = TextEditingController();

  void init(Bookmark? bookmark) {
    titleController.text = bookmark?.title ?? '';
    chapterController.text = bookmark?.chapter.main.toString() ?? '';
    subChapterController.text = bookmark?.chapter.sub ?? '';
  }

  void dispose() {
    titleController.dispose();
    chapterController.dispose();
    subChapterController.dispose();
  }

  Future<void> cancel(
    ValueNotifier<bool> loading,
    BuildContext context,
  ) async {
    if (context.mounted) Navigator.pop(context);
  }

  Future<void> saveBookmark(
    ValueNotifier<bool> loading,
    Bookmark? bookmark,
    BuildContext context,
  ) async {
    final title = titleController.text;
    final chapter = int.tryParse(chapterController.text);
    final subChapter = subChapterController.text;
    if (title.isEmpty || chapter == null) return;
    loading.value = true;
    await BookmarksStorage.instance.addBookmark(
      Bookmark(
        uuid: bookmark?.uuid,
        title: title,
        tags: TagsList([]),
        updatedAt: DateTime.timestamp(),
        createdAt: bookmark?.createdAt ?? DateTime.timestamp(),
        chapter: Chapter(main: chapter, sub: subChapter),
      ),
    );
    BookmarksStorage.changeEdited(false);
    await Future.delayed(_loadingDelay);
    loading.value = false;
    if (context.mounted) Navigator.pop(context);
  }

  TextInputFormatter onlyNumbersFormatter() {
    return TextInputFormatter.withFunction(
      (oldValue, newValue) {
        final text = newValue.text;
        if (text.isNotEmpty && int.tryParse(text) == null) return oldValue;
        return newValue;
      },
    );
  }
}
