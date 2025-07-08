part of '../library.dart';

class NewTagScreenViewModel with ChangeNotifier {
  static const _loadingDelay = Duration(milliseconds: 250);
  static const defaultLabelColor = Color(0xFFD8D8D8);
  static const defaultBackgroundColor = Color(0xFF7E7E7E);
  static const defaultBorderColor = defaultLabelColor;
  final labelController = TextEditingController();
  Color labelColor = defaultLabelColor;
  Color backgroundColor = defaultBackgroundColor;
  Color borderColor = defaultBorderColor;

  void init(Tag? tag) {
    if (tag != null) {
      labelController.text = tag.label;
      labelColor = tag.labelColor;
      backgroundColor = tag.backgroundColor;
      borderColor = tag.borderColor;
    }
    labelController.addListener(notify);
  }

  void notify() => notifyListeners();

  @override
  void dispose() {
    super.dispose();
    labelController.removeListener(notify);
    labelController.dispose();
  }

  void changeLabelColor(Color newColor) {
    labelColor = newColor;
  }

  void resetLabelColor() {
    labelColor = defaultLabelColor;
  }

  void changeBackgroundColor(Color newColor) {
    backgroundColor = newColor;
  }

  void resetBackgroundColor() {
    backgroundColor = defaultBackgroundColor;
  }

  void changeBorderColor(Color newColor) {
    borderColor = newColor;
  }

  void resetBorderColor() {
    borderColor = defaultBorderColor;
  }

  Future<void> cancel(ValueNotifier<bool> loading, BuildContext context) async {
    if (context.mounted) Navigator.pop(context);
  }

  Future<void> saveTag(
    ValueNotifier<bool> loading,
    Tag? tag,
    BuildContext context,
  ) async {
    final title = labelController.text;
    if (title.isEmpty) return;
    loading.value = true;
    await tagsStorageHandler.getOrThrow().addTag(
      Tag(
        uuid: tag?.uuid,
        label: title,
        labelColor: labelColor,
        backgroundColor: backgroundColor,
        borderColor: borderColor,
      ),
    );
    await Future.delayed(_loadingDelay);
    loading.value = false;
    if (context.mounted) Navigator.pop(context);
  }
}
