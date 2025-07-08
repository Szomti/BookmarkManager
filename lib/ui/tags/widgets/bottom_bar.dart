part of '../library.dart';

class _BottomBarWidget extends StatefulWidget {
  final TagsScreenViewModel viewModel;

  const _BottomBarWidget(this.viewModel);

  @override
  State<StatefulWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<_BottomBarWidget> {
  TagsScreenViewModel get _viewModel => widget.viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [_createAddNewBtn()],
    );
  }

  Widget _createAddNewBtn() {
    return Row(
      children: [
        Expanded(
          child: CustomOutlinedButton(
            text: 'Add New',
            icon: const Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Icon(Icons.add, color: Colors.white, size: 24),
            ),
            onPressed: (loading) => _viewModel.handleAddNew(context),
          ),
        ),
      ],
    );
  }
}
