part of '../library.dart';

class NewTagScreen extends StatefulWidget {
  final Tag? tag;

  const NewTagScreen({this.tag, super.key});

  @override
  State<StatefulWidget> createState() => _NewTagScreenState();
}

class _NewTagScreenState extends State<NewTagScreen> {
  static const _padding = EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0);
  final _viewModel = NewTagScreenViewModel();

  Color get _labelColor => _viewModel.labelColor;

  Color get _backgroundColor => _viewModel.backgroundColor;

  Color get _borderColor => _viewModel.borderColor;

  TextEditingController get _labelController => _viewModel.labelController;

  Tag? get _tag => widget.tag;

  @override
  void initState() {
    _viewModel.init(_tag);
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _HeaderWidget(_tag == null),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ExampleTag(_viewModel),
                    _createTextFieldPadding(
                      CustomTextField('Label*', _labelController),
                    ),
                    _createTextFieldPadding(
                      CustomOutlinedButton(
                        text: 'Label Color',
                        onPressed: (_) async => _changeColor(
                          () => _labelColor,
                          _viewModel.changeLabelColor,
                          _viewModel.resetLabelColor,
                        ),
                      ),
                    ),
                    _createTextFieldPadding(
                      CustomOutlinedButton(
                        text: 'Background Color',
                        onPressed: (_) async => _changeColor(
                          () => _backgroundColor,
                          _viewModel.changeBackgroundColor,
                          _viewModel.resetBackgroundColor,
                        ),
                      ),
                    ),
                    _createTextFieldPadding(
                      CustomOutlinedButton(
                        text: 'Border Color',
                        onPressed: (_) async => _changeColor(
                          () => _borderColor,
                          _viewModel.changeBorderColor,
                          _viewModel.resetBorderColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _ButtonsWidget(_viewModel, _tag),
          ],
        ),
      ),
    );
  }

  void _changeColor(
    Color Function() colorCallback,
    void Function(Color) onColorChanged,
    void Function() resetColor,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            backgroundColor: AppColors.background,
            title: const SizedBox.shrink(),
            content: SingleChildScrollView(
              child: ColorPicker(
                labelTypes: const [],
                hexInputBar: true,
                pickerColor: colorCallback(),
                onColorChanged: onColorChanged,
              ),
            ),
            actions: <Widget>[
              CustomOutlinedButton(
                text: 'Reset',
                onPressed: (_) async {
                  resetColor();
                  Navigator.of(context).pop();
                  _changeColor(colorCallback, onColorChanged, resetColor);
                },
              ),
              CustomOutlinedButton(
                text: 'Select',
                onPressed: (_) async {
                  Navigator.of(context).pop();
                  _viewModel.notify();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _createTextFieldPadding(Widget child) {
    return Row(
      children: [
        Expanded(
          child: Padding(padding: _padding, child: child),
        ),
      ],
    );
  }
}
