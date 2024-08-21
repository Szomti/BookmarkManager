part of 'library.dart';

class NewBookmarkScreen extends StatefulWidget {
  final Bookmark? bookmark;

  const NewBookmarkScreen({this.bookmark, super.key});

  @override
  State<StatefulWidget> createState() => _NewBookmarkScreenState();
}

class _NewBookmarkScreenState extends State<NewBookmarkScreen> {
  final _viewModel = NewBookmarkScreenViewModel();

  Bookmark? get _bookmark => widget.bookmark;

  @override
  void initState() {
    _viewModel.init(_bookmark);
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
            _HeaderWidget(_bookmark == null),
            _FieldsWidget(_viewModel),
            _createInfo(),
            const Spacer(),
            _ButtonsWidget(_viewModel, _bookmark),
          ],
        ),
      ),
    );
  }

  Widget _createInfo() {
    if (_bookmark == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              'Updated at: ${_bookmark?.updatedAt.toLocal()}',
              style: const TextStyle(color: Color(0xFF959595)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              'Created at: ${_bookmark?.createdAt.toLocal()}',
              style: const TextStyle(color: Color(0xFF959595)),
            ),
          ),
        ],
      ),
    );
  }
}
