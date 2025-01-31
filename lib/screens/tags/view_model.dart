part of 'library.dart';

class TagsScreenViewModel {
  Future<void> handleAddNew(BuildContext context) async {
    unawaited(
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const NewTagScreen(),
        ),
      ),
    );
  }
}
