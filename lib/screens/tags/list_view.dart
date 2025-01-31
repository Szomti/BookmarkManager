part of 'library.dart';

class _ListViewWidget extends StatefulWidget {
  const _ListViewWidget();

  @override
  State<StatefulWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<_ListViewWidget> {
  static const _gapWidget = SizedBox(height: 16);

  TagsStorage get _storage => TagsStorage.instance;

  Iterable<Tag> get _tags => _storage.list;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _storage,
      builder: (BuildContext context, Widget? child) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: _tags.length + 1,
          itemBuilder: (context, index) {
            if (index >= _tags.length) return _gapWidget;
            return _TileWidget(
              key: UniqueKey(),
              _tags.elementAt(index),
            );
          },
        );
      },
    );
  }
}
