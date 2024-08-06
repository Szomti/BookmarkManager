part of 'library.dart';

class _UpdateBarWidget extends StatefulWidget {
  final HomeScreenViewModel viewModel;

  const _UpdateBarWidget(this.viewModel);

  @override
  State<StatefulWidget> createState() => _UpdateBarWidgetState();
}

class _UpdateBarWidgetState extends State<_UpdateBarWidget> {
  static const _gapWidget = SizedBox(width: 16);

  HomeScreenViewModel get _viewModel => widget.viewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: CustomOutlinedButton(
            text: 'Discard',
            onPressed: _viewModel.handleDiscard,
          ),
        ),
        _gapWidget,
        Expanded(
          child: CustomOutlinedButton(
            text: 'Save',
            onPressed: _viewModel.handleSave,
          ),
        ),
      ],
    );
  }
}
