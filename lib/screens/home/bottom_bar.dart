part of 'library.dart';

class _BottomBarWidget extends StatefulWidget {
  final HomeScreenViewModel viewModel;

  const _BottomBarWidget(this.viewModel);

  @override
  State<StatefulWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<_BottomBarWidget> {
  static const _gapWidget = SizedBox(height: 8);

  HomeScreenViewModel get _viewModel => widget.viewModel;

  TextEditingController get _searchController => _viewModel.searchController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _createAddNewBtn(),
        _gapWidget,
        _createSearch(),
      ],
    );
  }

  Widget _createAddNewBtn() {
    return Row(
      children: [
        Expanded(
          child: CustomOutlinedButton(
            text: 'Add New',
            onPressed: (loading) => _viewModel.handleAddNew(loading, context),
          ),
        ),
      ],
    );
  }

  Widget _createSearch() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            'Search',
            _searchController,
          ),
        ),
      ],
    );
  }
}
