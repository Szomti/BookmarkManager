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
        const SizedBox(width: 8.0),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            unawaited(
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(4.0),
            child: const Icon(
              Icons.settings,
              size: 28.0,
              color: Color(0xFFD8D8D8),
            ),
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
