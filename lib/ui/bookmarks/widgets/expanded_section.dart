part of '../library.dart';

class _ExpandedSectionWidget extends StatefulWidget {
  final Bookmark bookmark;

  const _ExpandedSectionWidget(this.bookmark);

  @override
  State<StatefulWidget> createState() => _ExpandedSectionWidgetState();
}

class _ExpandedSectionWidgetState extends State<_ExpandedSectionWidget> {
  static final _deleteTimeout = Duration(milliseconds: 1500);
  static final _editBtnDecoration = BoxDecoration(
    color: const Color(0xFF7E7E7E),
    borderRadius: BorderRadius.circular(8.0),
  );
  static const _baseColor = Color(0xFFD8D8D8);
  final _subChapterController = TextEditingController();
  final BoolValueNotifier _confirmed = BoolValueNotifier(false);
  int rebuild = 0;

  Bookmark get _bookmark => widget.bookmark;

  @override
  void dispose() {
    _confirmed.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (final tag in _bookmark.createTags())
          Padding(padding: const EdgeInsets.all(4.0), child: CustomTag(tag)),
        const Row(children: [Expanded(child: SizedBox.shrink())]),
        _createEditBaseBtn('Sub Chapter', Icons.edit_note, () {
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
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextField('Sub Chapter', _subChapterController),
                          const SizedBox(height: 8.0),
                          _createDialogBtn('Set', () {
                            _bookmark.chapter = Chapter(
                              main: _bookmark.chapter.main,
                              sub: _subChapterController.text,
                            );
                            if (mounted) Navigator.pop(context);
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
        _createEditBaseBtn('Full Edit', Icons.edit, () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NewBookmarkScreen(bookmark: _bookmark),
            ),
          );
        }),
        _createEditBaseBtn('Edit Tags', Icons.tag_outlined, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => BookmarkTagsScreen(_bookmark)),
          );
        }),
        ListenableBuilder(
          listenable: _confirmed,
          builder: (_, __) {
            return _createEditBaseBtn(
              'Delete',
              Icons.delete_forever,
              _handleDelete,
              foregroundColor: _confirmed.value
                  ? const Color(0xFFFF6161)
                  : null,
            );
          },
        ),
      ],
    );
  }

  Future<void> _handleDelete() async {
    if (_confirmed.value) {
      await bookmarksStorageHandler.getOrThrow().removeBookmark(_bookmark);
      return;
    }
    _confirmed.setTrue();
    Timer(_deleteTimeout, _confirmed.setFalse);
  }

  Widget _createDialogBtn(String text, void Function() onPressed) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: _baseColor, width: 2.0),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(text, style: const TextStyle(color: _baseColor)),
            ),
          ),
        ),
      ],
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
        decoration: _editBtnDecoration,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: foregroundColor ?? _baseColor,
              ),
            ),
            const SizedBox(width: 4),
            Icon(icon, color: foregroundColor ?? _baseColor, size: 18),
          ],
        ),
      ),
    );
  }
}
