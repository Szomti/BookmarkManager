part of 'library.dart';

class LoadingScreenViewModel {
  Future<void> handleLoading(BuildContext context) async {
    await BookmarksStorage.instance.load();
    await Future.delayed(const Duration(milliseconds: 250));
    if (!context.mounted) return;
    unawaited(
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      ),
    );
  }
}
