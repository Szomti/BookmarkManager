part of 'library.dart';

class BookmarksScreenViewModel {
  static const _delayDuration = Duration(milliseconds: 250);

  final searchController = TextEditingController();

  BookmarksStorage get _storage => BookmarksStorage.instance;

  void init() {
    searchController.addListener(_handleSearchUpdate);
  }

  void dispose() {
    searchController.removeListener(_handleSearchUpdate);
    searchController.dispose();
  }

  void _handleSearchUpdate() {
    _storage.search = searchController.text;
  }

  Future<void> handleDiscard(ValueNotifier<bool> loading) async {
    await _handleChange(loading, _storage.load);
  }

  Future<void> handleSave(ValueNotifier<bool> loading) async {
    await _handleChange(loading, _storage.save);
  }

  Future<void> _handleChange(
    ValueNotifier<bool> loading,
    Future<void> Function() action,
  ) async {
    loading.value = true;
    await action();
    await Future.delayed(_delayDuration);
    loading.value = false;
    BookmarksStorage.changeEdited(false);
  }

  Future<void> handleAddNew(BuildContext context) async {
    unawaited(
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const NewBookmarkScreen(),
        ),
      ),
    );
  }

  Future<void> handleFilter(BuildContext context) async {
    unawaited(
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const FilterBookmarks(),
        ),
      ),
    );
  }
}
