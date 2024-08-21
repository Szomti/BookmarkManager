part of 'library.dart';

class LoadingScreenViewModel {
  final BoolValueNotifier errorOccurred = BoolValueNotifier(false);

  void dispose() {
    errorOccurred.dispose();
  }

  Future<void> handleLoading(BuildContext context) async {
    try {
      await BookmarksStorage.instance.load();
      await Future.delayed(const Duration(milliseconds: 250));
      if (!context.mounted) return;
      unawaited(
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        ),
      );
    } catch (error, stackTrace) {
      await Future.delayed(const Duration(milliseconds: 100));
      errorOccurred.setTrue();
      debugPrint('[ERROR] $error\n$stackTrace');
    }
  }
}
