part of 'library.dart';

class _TileWidget extends StatefulWidget {
  final Bookmark bookmark;
  final Tag tag;

  const _TileWidget({required this.bookmark, required this.tag});

  @override
  State<StatefulWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends State<_TileWidget> {
  Bookmark get _bookmark => widget.bookmark;

  Tag get _tag => widget.tag;

  Iterable<Tag> get _bookmarkTags => _bookmark.createTags();

  bool get checked => _bookmarkTags.contains(_tag);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (checked) {
          _bookmark.removeTag(_tag.uuid);
        } else {
          _bookmark.addTag(_tag.uuid);
        }
        setState(() {});
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        decoration: BoxDecoration(
          color: checked ? const Color(0xFF656565) : const Color(0xFF595959),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            _createCheckbox(checked),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomTag(_tag, forceCustom: true),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createCheckbox(bool check) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child:
            check
                ? Icon(
                  key: UniqueKey(),
                  Icons.check_box_rounded,
                  color: Colors.white,
                )
                : Icon(
                  key: UniqueKey(),
                  Icons.check_box_outline_blank_rounded,
                  color: Colors.white,
                ),
      ),
    );
  }
}
