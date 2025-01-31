part of 'library.dart';

class _ListViewWidget extends StatefulWidget {
  const _ListViewWidget();

  @override
  State<StatefulWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<_ListViewWidget> {
  static const _gapWidget = SizedBox(height: 16);

  BookmarksStorage get _storage => BookmarksStorage.instance;

  Iterable<Bookmark> get _bookmarks => _storage.searchItems;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _storage,
      builder: (BuildContext context, Widget? child) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: _bookmarks.length + 1,
          itemBuilder: (context, index) {
            if (index >= _bookmarks.length) return _gapWidget;
            return _TileWidget(
              key: UniqueKey(),
              _bookmarks.elementAt(index),
            );
          },
        );
      },
    );
  }
}
