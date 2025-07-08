part of '../library.dart';

class _FieldsWidget extends StatefulWidget {
  final NewBookmarkScreenViewModel viewModel;

  const _FieldsWidget(this.viewModel);

  @override
  State<StatefulWidget> createState() => _FieldsWidgetState();
}

class _FieldsWidgetState extends State<_FieldsWidget> {
  static const _padding = EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0);

  NewBookmarkScreenViewModel get _viewModel => widget.viewModel;

  TextEditingController get _titleController => //
      _viewModel.titleController;

  TextEditingController get _chapterController => //
      _viewModel.chapterController;

  TextEditingController get _subChapterController => //
      _viewModel.subChapterController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _createTextFieldPadding(CustomTextField('Title*', _titleController)),
        _createTextFieldPadding(
          CustomTextField(
            'Chapter*',
            _chapterController,
            type: TextInputType.number,
            formatters: [_viewModel.onlyNumbersFormatter()],
          ),
        ),
        _createTextFieldPadding(
          CustomTextField('Sub Chapter', _subChapterController),
        ),
      ],
    );
  }

  Widget _createTextFieldPadding(Widget child) {
    return Padding(padding: _padding, child: child);
  }
}
