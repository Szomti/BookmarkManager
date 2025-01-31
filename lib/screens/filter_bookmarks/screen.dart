part of 'library.dart';

class FilterBookmarks extends StatefulWidget {
  const FilterBookmarks({super.key});

  @override
  State<StatefulWidget> createState() => _FilterBookmarksState();
}

class _FilterBookmarksState extends State<FilterBookmarks> {
  final _storage = TagsStorage.instance;
  final _checkList = <bool>[true];

  TagsList get _tagsList => _storage.list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
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

  Widget _createCheckbox(bool check) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: check
            ? Icon(
                key: UniqueKey(),
                Icons.check_box_rounded,
                color: Colors.white,
              )
            : Icon(
                key: UniqueKey(),
                Icons.check_box_outline_blank_rounded,
                color: Colors.white,
              ),
      ),
    );
  }

  Widget _createTile(int index) {
    bool check = _checkList.elementAt(index);
    return GestureDetector(
      onTap: () {
        _checkList[index] = !check;
        setState(() {});
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: check ? const Color(0xFF656565) : const Color(0xFF595959),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            _createCheckbox(check),
            Expanded(
                child: Align(
              alignment: Alignment.centerLeft,
              child: CustomTag(_tagsList.elementAt(index)),
            )),
          ],
        ),
      ),
    );
  }
}
