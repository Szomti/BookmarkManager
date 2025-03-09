part of 'library.dart';

class BookmarksScreenViewModel {
  static const _delayDuration = Duration(milliseconds: 250);
  final searchController = TextEditingController();
  ValueNotifier bookmarksSearch = ValueNotifier('');

  BookmarksStorageHandler get _storage => bookmarksStorageHandler;

  Bookmarks get bookmarks => _storage.getOrThrow();

  Iterable<Bookmark> get searchedBookmarks =>
      bookmarks.searchItems(bookmarksSearch.value);

  void init() {
    searchController.addListener(_handleSearchUpdate);
  }

  void dispose() {
    searchController.removeListener(_handleSearchUpdate);
    searchController.dispose();
  }

  void _handleSearchUpdate() {
    bookmarksSearch.value = searchController.text;
  }

  Future<void> handleDiscard(ValueNotifier<bool> loading) async {
    await _handleChange(loading, _storage.getFromStorage);
  }

  Future<void> handleSave(ValueNotifier<bool> loading) async {
    await _handleChange(loading, _storage.saveToStorage);
  }

  Future<void> _handleChange(
    ValueNotifier<bool> loading,
    Future<void> Function() action,
  ) async {
    loading.value = true;
    await action();
    await Future.delayed(_delayDuration);
    loading.value = false;
    Bookmarks.changeEdited(false);
  }

  Future<void> handleAddNew(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NewBookmarkScreen()),
    );
  }

  Future<void> handleFilter(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FilterBookmarks()),
    );
  }
}
