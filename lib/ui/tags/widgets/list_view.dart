part of '../library.dart';

class _ListViewWidget extends StatefulWidget {
  const _ListViewWidget();

  @override
  State<StatefulWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<_ListViewWidget> {
  static const _gapWidget = SizedBox(height: 16);

  Iterable<Tag> get _tags =>
      SplayTreeSet.of(tagsStorageHandler.getOrThrow().list);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: tagsStorageHandler,
      builder: (BuildContext context, Widget? child) {
        final tags = _tags;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: tags.length + 1,
          itemBuilder: (context, index) {
            if (index >= tags.length) return _gapWidget;
            return _TileWidget(key: UniqueKey(), tags.elementAt(index));
          },
        );
      },
    );
  }
}
