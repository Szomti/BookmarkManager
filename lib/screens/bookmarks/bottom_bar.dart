part of 'library.dart';

class _BottomBarWidget extends StatefulWidget {
  final BookmarksScreenViewModel viewModel;

  const _BottomBarWidget(this.viewModel);

  @override
  State<StatefulWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<_BottomBarWidget> {
  static const _gapWidget = SizedBox(height: 8);

  BookmarksScreenViewModel get _viewModel => widget.viewModel;

  TextEditingController get _searchController => _viewModel.searchController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [_createAddNewBtn(), _gapWidget, _createSearch()],
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
        const SizedBox(width: 16.0),
        Expanded(
          child: CustomOutlinedButton(
            text: 'Filter',
            icon: const Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Icon(Icons.filter_list, color: Colors.white, size: 24),
            ),
            onPressed: (loading) async {
              await _viewModel.handleFilter(context);
            },
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
            showClearBtn: true,
          ),
        ),
      ],
    );
  }
}
