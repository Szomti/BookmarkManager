part of '../library.dart';

class _HeaderWidget extends StatelessWidget {
  static const _margin = EdgeInsets.only(bottom: 8.0);
  static const _padding = EdgeInsets.all(8.0);
  static const _decoration = BoxDecoration(color: Color(0xFF656565));
  static const _headerTextStyle = TextStyle(
    color: Color(0xFFD8D8D8),
    fontSize: 16,
  );

  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _margin,
      padding: _padding,
      decoration: _decoration,
      child: const Row(
        children: [
          Expanded(
            child: Text(
              'Filter Bookmarks by Tags',
              textAlign: TextAlign.center,
              style: _headerTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
