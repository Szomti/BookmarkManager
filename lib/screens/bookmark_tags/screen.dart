part of 'library.dart';

class BookmarkTagsScreen extends StatefulWidget {
  final Bookmark bookmark;

  const BookmarkTagsScreen(this.bookmark, {super.key});

  @override
  State<StatefulWidget> createState() => _BookmarkTagsScreenState();
}

class _BookmarkTagsScreenState extends State<BookmarkTagsScreen> {

  TagsList get _tagsList => tagsStorageHandler.getOrThrow().list;

  Bookmark get _bookmark => widget.bookmark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const _HeaderWidget(),
            Expanded(
              child: ListView.builder(
                itemCount: _tagsList.length,
                itemBuilder: (_, int index) {
                  return _TileWidget(
                    bookmark: _bookmark,
                    tag: _tagsList.elementAt(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
