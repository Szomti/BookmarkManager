part of 'library.dart';

class _TileWidget extends StatefulWidget {
  final Tag tag;

  const _TileWidget(
    this.tag, {
    required Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends State<_TileWidget> {
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
      decoration: BoxDecoration(
        color: const Color(0xFF656565),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTag(
                      _tag,
                      forceCustom: true,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _createEditBaseBtn(
                  'Edit',
                  Icons.edit,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NewTagScreen(tag: _tag),
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
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleDelete() async {
    if (_confirmed.value) {
      return TagsStorage.instance.removeTag(_tag);
    }
    _confirmed.setTrue();
    Timer(const Duration(seconds: 2), _confirmed.setFalse);
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
        padding: const EdgeInsets.all(4.0),
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
