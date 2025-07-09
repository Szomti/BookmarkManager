part of '../library.dart';

class FilterBookmarksScreen extends StatefulWidget {
  const FilterBookmarksScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FilterBookmarksScreenState();
}

class _FilterBookmarksScreenState extends State<FilterBookmarksScreen> {
  final Iterable<Tag> _tagsList = SplayTreeSet.of(
    tagsStorageHandler.getOrThrow().list,
  );

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
                itemBuilder: (_, int index) => _createTile(index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createCheckbox(TagFilterState state) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        child: Icon(key: UniqueKey(), switch (state) {
          TagFilterState.show => Icons.check,
          TagFilterState.none => Icons.horizontal_rule,
          TagFilterState.exclude => Icons.close,
        }, color: Colors.white),
      ),
    );
  }

  Widget _createTile(int index) {
    Tag tag = _tagsList.elementAt(index);
    return ListenableBuilder(
      listenable: tag,
      builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          onTap: () async {
            tag.filterState = tag.filterState.next();
            await tagsStorageHandler.saveToStorage();
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
            decoration: BoxDecoration(
              color: const Color(0xFF656565), //: const Color(0xFF595959),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                _createCheckbox(tag.filterState),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomTag(tag),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
