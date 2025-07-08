part of '../library.dart';

class _ListViewWidget extends StatefulWidget {
  final BookmarksScreenViewModel viewModel;

  const _ListViewWidget(this.viewModel);

  @override
  State<StatefulWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<_ListViewWidget> {
  static const _gapWidget = SizedBox(height: 16);

  BookmarksScreenViewModel get _viewModel => widget.viewModel;

  Iterable<Bookmark> get _bookmarks =>
      SplayTreeSet.of(_viewModel.searchedBookmarks);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        bookmarksStorageHandler,
        tagsStorageHandler,
        _viewModel.bookmarksSearch,
      ]),
      builder: (BuildContext context, _) {
        final bookmarks = _bookmarks;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: bookmarks.length + 1,
          itemBuilder: (context, index) {
            if (index >= bookmarks.length) return _gapWidget;
            return _TileWidget(key: UniqueKey(), bookmarks.elementAt(index));
          },
        );
      },
    );
  }
}
