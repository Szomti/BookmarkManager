part of '../library.dart';

class _TileWidget extends StatefulWidget {
  final Tag tag;

  const _TileWidget(this.tag, {required Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends State<_TileWidget> {
  static const _editBtnPadding = EdgeInsets.all(4.0);
  static final _tileDecoration = BoxDecoration(
    color: const Color(0xFF656565),
    borderRadius: BorderRadius.circular(8),
  );
  static final _deleteTimeout = Duration(milliseconds: 1500);
  final BoolValueNotifier _confirmed = BoolValueNotifier(false);

  Tag get _tag => widget.tag;

  @override
  void dispose() {
    _confirmed.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16).copyWith(bottom: 0),
      decoration: _tileDecoration,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CustomTag(_tag, forceCustom: true)],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _createEditBaseBtn('Edit', Icons.edit, () {
                  context.push('/new-tag', extra: _tag);
                }),
                ListenableBuilder(
                  listenable: _confirmed,
                  builder: (_, _) {
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
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleDelete() async {
    if (_confirmed.value) {
      return tagsStorageHandler.getOrThrow().removeTag(_tag);
    }
    _confirmed.setTrue();
    Timer(_deleteTimeout, _confirmed.setFalse);
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
        margin: _editBtnPadding,
        padding: _editBtnPadding,
        decoration: BoxDecoration(
          color: const Color(0xFF7E7E7E),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
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
}
