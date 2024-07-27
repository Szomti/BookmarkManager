part of 'library.dart';

class NewBookmarkScreen extends StatefulWidget {
  final Bookmark? bookmark;

  const NewBookmarkScreen({this.bookmark, super.key});

  @override
  State<StatefulWidget> createState() => _NewBookmarkScreenState();
}

class _NewBookmarkScreenState extends State<NewBookmarkScreen> {
  final _titleController = TextEditingController();
  final _chapterController = TextEditingController();
  final _subChapterController = TextEditingController();

  Bookmark? get _bookmark => widget.bookmark;

  @override
  void initState() {
    _titleController.text = _bookmark?.title ?? '';
    _chapterController.text = _bookmark?.chapter.main.toString() ?? '';
    _subChapterController.text = _bookmark?.chapter.sub ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF454545),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                color: Color(0xFF656565),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _bookmark == null ? 'New Bookmark' : 'Edit Bookmark',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFD8D8D8),
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: CustomTextField('Title*', _titleController),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: CustomTextField(
                'Chapter*',
                _chapterController,
                type: TextInputType.number,
                formatters: [_onlyNumbersFormatter()],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: CustomTextField('Sub Chapter', _subChapterController),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              color: const Color(0xFF535353),
              child: Row(
                children: [
                  Expanded(
                    child: CustomOutlinedButton(
                      text: 'Cancel',
                      onPressed: _cancel,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: CustomOutlinedButton(
                      text: 'Save',
                      onPressed: _saveBookmark,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextInputFormatter _onlyNumbersFormatter() {
    return TextInputFormatter.withFunction(
      (oldValue, newValue) {
        if (int.tryParse(newValue.text) == null) return oldValue;
        return newValue;
      },
    );
  }

  Future<void> _cancel(ValueNotifier<bool> loading) async {
    if (mounted) Navigator.pop(context);
  }

  Future<void> _saveBookmark(ValueNotifier<bool> loading) async {
    final title = _titleController.text;
    final chapter = int.tryParse(_chapterController.text);
    final subChapter = _subChapterController.text;
    if (title.isEmpty || chapter == null) return;
    loading.value = true;
    await BookmarksStorage.instance.addBookmark(
      Bookmark(
        customId: _bookmark?.id,
        title: title,
        ordinal: _bookmark?.ordinal ?? BookmarksStorage.count + 1,
        chapter: Chapter(main: chapter, sub: subChapter),
      ),
    );
    BookmarksStorage.changeEdited(false);
    await Future.delayed(const Duration(milliseconds: 250));
    loading.value = false;
    if (mounted) Navigator.pop(context);
  }
}
