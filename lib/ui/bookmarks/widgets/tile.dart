part of '../library.dart';

class _TileWidget extends StatefulWidget {
  final Bookmark bookmark;

  const _TileWidget(this.bookmark, {required super.key});

  @override
  State<StatefulWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends State<_TileWidget> {
  static const _textColor = Color(0xFFD8D8D8);
  static const _chapterIconColor = Colors.white;
  static const _chapterIconSize = 20.0;
  static const _chapterIconPadding = EdgeInsets.all(4.0);
  static const _tilePadding = EdgeInsets.all(8.0);
  static const _btnDecoration = BoxDecoration(
    color: Color(0xFF7E7E7E),
    shape: BoxShape.circle,
  );
  static const _titleTextStyle = TextStyle(fontSize: 15, color: _textColor);
  static final _tileMargin = EdgeInsets.all(16).copyWith(bottom: 0);
  static final _tileDecoration = BoxDecoration(
    color: const Color(0xFF656565),
    borderRadius: BorderRadius.circular(8),
  );
  final BoolValueNotifier _expanded = BoolValueNotifier(false);

  Bookmark get _bookmark => widget.bookmark;

  @override
  void dispose() {
    _expanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _expanded.value = !_expanded.value,
      child: Container(
        margin: _tileMargin,
        decoration: _tileDecoration,
        child: ListenableBuilder(
          listenable: _bookmark,
          builder: (_, _) => _createTileContent(),
        ),
      ),
    );
  }

  Widget _createTileContent() {
    return Padding(
      padding: _tilePadding,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text(_bookmark.title, style: _titleTextStyle)),
              ValueListenableBuilder(
                valueListenable: _expanded,
                builder: (_, bool expanded, _) {
                  return Icon(
                    expanded
                        ? Icons.keyboard_arrow_up_outlined
                        : Icons.keyboard_arrow_down_outlined,
                    color: _textColor,
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
                    style: const TextStyle(fontSize: 13, color: _textColor),
                  ),
                ),
              ),
              _createBtn(Icons.add, () => _changeChapter(1)),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: _expanded,
            builder: (_, bool expanded, _) {
              return ExpandedSection(
                expand: expanded,
                child: _ExpandedSectionWidget(_bookmark),
              );
            },
          ),
        ],
      ),
    );
  }

  void _changeChapter(int value) {
    _bookmark.chapter = Chapter(main: _bookmark.chapter.main + value);
  }

  Widget _createBtn(IconData icon, void Function() onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: _chapterIconPadding,
        child: Container(
          decoration: _btnDecoration,
          child: Padding(
            padding: _chapterIconPadding,
            child: Icon(icon, color: _chapterIconColor, size: _chapterIconSize),
          ),
        ),
      ),
    );
  }
}
