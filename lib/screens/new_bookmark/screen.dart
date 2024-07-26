part of 'library.dart';

class NewBookmarkScreen extends StatefulWidget {
  const NewBookmarkScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NewBookmarkScreenState();
}

class _NewBookmarkScreenState extends State<NewBookmarkScreen> {
  static final _titleController = TextEditingController();
  static final _chapterController = TextEditingController();
  static final _subChapterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF454545),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextField(
                  controller: _titleController,
                  style: const TextStyle(color: Color(0xFFD8D8D8)),
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(
                      color: Color(0xFF9F9F9F),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFD8D8D8),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextField(
                  controller: _chapterController,
                  style: const TextStyle(color: Color(0xFFD8D8D8)),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Chapter',
                    labelStyle: TextStyle(
                      color: Color(0xFF9F9F9F),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFD8D8D8),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextField(
                  controller: _subChapterController,
                  style: const TextStyle(color: Color(0xFFD8D8D8)),
                  decoration: const InputDecoration(
                    labelText: 'Sub Chapter',
                    labelStyle: TextStyle(
                      color: Color(0xFF9F9F9F),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFD8D8D8),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: _saveBookmark,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color(0xFFD8D8D8),
                    width: 2.0,
                  ),
                ),
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Save',
                    style: TextStyle(color: Color(0xFFD8D8D8)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveBookmark() async {
    final title = _titleController.text;
    final chapter = int.tryParse(_chapterController.text);
    final subChapter = _subChapterController.text;
    if (title.isEmpty || chapter == null) return;
    await BookmarksStorage.instance.addBookmark(
      Bookmark(
        title: title,
        ordinal: BookmarksStorage.count + 1,
        chapter: Chapter(main: chapter, sub: subChapter),
      ),
    );
    _titleController.clear();
    _chapterController.clear();
    _subChapterController.clear();
    if (mounted) Navigator.pop(context);
  }
}
