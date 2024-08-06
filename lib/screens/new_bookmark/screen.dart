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
            const Spacer(),
            _ButtonsWidget(_viewModel, _bookmark),
          ],
        ),
      ),
    );
  }
}
