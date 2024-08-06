part of 'library.dart';

class _ButtonsWidget extends StatefulWidget {
  final NewBookmarkScreenViewModel viewModel;
  final Bookmark? bookmark;

  const _ButtonsWidget(this.viewModel, this.bookmark);

  @override
  State<StatefulWidget> createState() => _ButtonsWidgetState();
}

class _ButtonsWidgetState extends State<_ButtonsWidget> {
  static const _gapWidget = SizedBox(width: 16.0);
  static const _mainColor = Color(0xFF535353);
  static const _padding = EdgeInsets.symmetric(
    vertical: 8.0,
    horizontal: 16.0,
  );

  NewBookmarkScreenViewModel get _viewModel => widget.viewModel;

  Bookmark? get _bookmark => widget.bookmark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _padding,
      color: _mainColor,
      child: Row(
        children: [
          Expanded(
            child: CustomOutlinedButton(
              text: 'Cancel',
              onPressed: (loading) => _viewModel.cancel(loading, context),
            ),
          ),
          _gapWidget,
          Expanded(
            child: CustomOutlinedButton(
              text: 'Save',
              onPressed: (loading) =>
                  _viewModel.saveBookmark(loading, _bookmark, context),
            ),
          ),
        ],
      ),
    );
  }
}
