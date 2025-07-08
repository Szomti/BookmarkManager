part of '../library.dart';

class LoadingScreenViewModel {
  final BoolValueNotifier errorOccurred = BoolValueNotifier(false);

  void dispose() {
    errorOccurred.dispose();
  }

  Future<void> handleLoading(BuildContext context) async {
    try {
      await Future.wait([
        FilePicker.platform.clearTemporaryFiles(),
        for (final storage in StorageSystem.storages) storage.getFromStorage(),
        Future.delayed(const Duration(milliseconds: 500)),
      ]);
      if (!context.mounted) return;
      unawaited(
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const BookmarksScreen()),
        ),
      );
    } catch (error, stackTrace) {
      await Future.delayed(const Duration(milliseconds: 100));
      errorOccurred.setTrue();
      debugPrint('[ERROR] $error\n$stackTrace');
    }
  }
}
