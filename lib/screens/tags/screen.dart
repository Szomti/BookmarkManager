part of './library.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  static const _mainColor = Color(0xFF535353);
  static const _padding = EdgeInsets.symmetric(
    vertical: 8.0,
    horizontal: 16.0,
  );

  final TagsScreenViewModel _viewModel = TagsScreenViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(child: _ListViewWidget()),
            Container(
              padding: _padding,
              color: _mainColor,
              child: Column(
                children: [
                  _BottomBarWidget(_viewModel),
                  const MainNavigationBar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
