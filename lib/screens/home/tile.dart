part of 'library.dart';

class _TileWidget extends StatefulWidget {
  final Bookmark bookmark;

  const _TileWidget(this.bookmark);

  @override
  State<StatefulWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends State<_TileWidget> {
  final _subChapterController = TextEditingController();

  Bookmark get _bookmark => widget.bookmark;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16).copyWith(bottom: 0),
      decoration: BoxDecoration(
        color: const Color(0xFF656565),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListenableBuilder(
        key: UniqueKey(),
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
                Row(
                  children: [
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
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                      'Delete',
                      Icons.delete_forever,
                      () => BookmarksStorage.instance.removeBookmark(_bookmark),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
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
    void Function() onTap,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: const Color(0xFF7E7E7E),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFFD8D8D8),
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              icon,
              color: const Color(0xFFD8D8D8),
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
