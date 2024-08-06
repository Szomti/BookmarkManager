part of './library.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _animationDuration = Duration(milliseconds: 300);
  static const _mainColor = Color(0xFF535353);
  static const _padding = EdgeInsets.symmetric(
    vertical: 8.0,
    horizontal: 16.0,
  );

  final HomeScreenViewModel _viewModel = HomeScreenViewModel();

  @override
  void initState() {
    _viewModel.init();
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
            const Expanded(child: _ListViewWidget()),
            Container(
              padding: _padding,
              color: _mainColor,
              child: Column(
                children: [
                  _createSwitchingUpdateBar(),
                  _BottomBarWidget(_viewModel),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createSwitchingUpdateBar() {
    return ValueListenableBuilder(
      valueListenable: BookmarksStorage.edited,
      builder: (BuildContext context, value, Widget? child) {
        return AnimatedSwitcher(
          duration: _animationDuration,
          child: value ? _UpdateBarWidget(_viewModel) : const SizedBox.shrink(),
        );
      },
    );
  }
}
