part of 'library.dart';

class _HeaderWidget extends StatefulWidget {
  final bool isNewBookmark;

  const _HeaderWidget(this.isNewBookmark);

  @override
  State<StatefulWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<_HeaderWidget> {
  static const _margin = EdgeInsets.only(bottom: 8.0);
  static const _padding = EdgeInsets.all(8.0);
  static const _decoration = BoxDecoration(
    color: Color(0xFF656565),
  );
  static const _headerTextStyle = TextStyle(
    color: Color(0xFFD8D8D8),
    fontSize: 16,
  );

  bool get _isNewBookmark => widget.isNewBookmark;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _margin,
      padding: _padding,
      decoration: _decoration,
      child: Row(
        children: [
          Expanded(
            child: Text(
              _isNewBookmark ? 'New Bookmark' : 'Edit Bookmark',
              textAlign: TextAlign.center,
              style: _headerTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
