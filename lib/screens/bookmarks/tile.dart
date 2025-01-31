part of 'library.dart';

// TODO: Clean up
class _TileWidget extends StatefulWidget {
  final Bookmark bookmark;

  const _TileWidget(
    this.bookmark, {
    required Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends State<_TileWidget> {
  final TagsStorage tagsStorage = TagsStorage.instance;
  final _subChapterController = TextEditingController();
  final BoolValueNotifier _confirmed = BoolValueNotifier(false);
  final BoolValueNotifier _expanded = BoolValueNotifier(false);

  Bookmark get _bookmark => widget.bookmark;

  @override
  void dispose() {
    _confirmed.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _expanded.value = !_expanded.value,
      child: Container(
        margin: const EdgeInsets.all(16).copyWith(bottom: 0),
        decoration: BoxDecoration(
          color: const Color(0xFF656565),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListenableBuilder(
          listenable: _bookmark,
          builder: (BuildContext context, Widget? child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _bookmark.title,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFFD8D8D8),
                          ),
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: _expanded,
                        builder: (BuildContext context, bool expanded,
                            Widget? child) {
                          return Icon(
                            expanded
                                ? Icons.keyboard_arrow_up_outlined
                                : Icons.keyboard_arrow_down_outlined,
                            color: const Color(0xFFD8D8D8),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _createBtn(Icons.remove, () => _changeChapter(-1)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Chapter: ${_bookmark.chapter.info}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFFD8D8D8),
                            ),
                          ),
                        ),
                      ),
                      _createBtn(Icons.add, () => _changeChapter(1)),
                    ],
                  ),
                  ValueListenableBuilder(
                    valueListenable: _expanded,
                    builder:
                        (BuildContext context, bool expanded, Widget? child) {
                      return ExpandedSection(
                        expand: expanded,
                        child: _createEditSection(),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _createEditSection() {
    return Wrap(
      children: [
        for (final tag in _bookmark.tags)
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: CustomTag(tag),
          ),
        const Row(children: [Expanded(child: SizedBox.shrink())]),
        _createEditBaseBtn(
          'Sub Chapter',
          Icons.edit_note,
          () {
            showDialog(
              context: context,
              builder: (context) {
                _subChapterController.text = _bookmark.chapter.sub;
                return Material(
                  type: MaterialType.transparency,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(16.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: const Color(0xFF454545),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextField(
                              'Sub Chapter',
                              _subChapterController,
                            ),
                            const SizedBox(height: 8.0),
                            _createDialogBtn(
                              'Set',
                              () {
                                _bookmark.chapter = Chapter(
                                  main: _bookmark.chapter.main,
                                  sub: _subChapterController.text,
                                );
                                if (mounted) Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        _createEditBaseBtn(
          'Full Edit',
          Icons.edit,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => NewBookmarkScreen(
                  bookmark: _bookmark,
                ),
              ),
            );
          },
        ),
        _createEditBaseBtn(
          'Edit Tags',
          Icons.tag_outlined,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BookmarkTagsScreen(_bookmark),
              ),
            );
          },
        ),
        ListenableBuilder(
          listenable: _confirmed,
          builder: (_, __) {
            return _createEditBaseBtn(
              'Delete',
              Icons.delete_forever,
              _handleDelete,
              foregroundColor:
                  _confirmed.value ? const Color(0xFFFF6161) : null,
            );
          },
        ),
      ],
    );
  }

  Future<void> _handleDelete() async {
    if (_confirmed.value) {
      return BookmarksStorage.instance.removeBookmark(_bookmark);
    }
    _confirmed.setTrue();
    Timer(const Duration(seconds: 2), _confirmed.setFalse);
  }

  Widget _createDialogBtn(String text, void Function() onPressed) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Color(0xFFD8D8D8),
                width: 2.0,
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text,
                style: const TextStyle(color: Color(0xFFD8D8D8)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _changeChapter(int value) {
    _bookmark.chapter = Chapter(
      main: _bookmark.chapter.main + value,
    );
  }

  Widget _createEditBaseBtn(
    String text,
    IconData icon,
    void Function() onTap, {
    Color? foregroundColor,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: const Color(0xFF7E7E7E),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: foregroundColor ?? const Color(0xFFD8D8D8),
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              icon,
              color: foregroundColor ?? const Color(0xFFD8D8D8),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _createBtn(IconData icon, void Function() onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF7E7E7E),
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
