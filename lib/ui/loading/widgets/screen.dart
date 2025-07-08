part of '../library.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  static const _loadingIndicatorSize = 64.0;

  final _viewModel = LoadingScreenViewModel();

  BoolValueNotifier get _errorOccurred => _viewModel.errorOccurred;

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _viewModel.handleLoading(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_createLoading(), _createErrorBuilder()],
        ),
      ),
    );
  }

  Widget _createLoading() {
    return const Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox.square(
            dimension: _loadingIndicatorSize,
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _createErrorBuilder() {
    return ValueListenableBuilder(
      valueListenable: _errorOccurred,
      builder: (_, bool errorOccurred, __) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 1500),
          child: _createErrorInfo(errorOccurred),
        );
      },
    );
  }

  Widget _createErrorInfo(bool errorOccurred) {
    if (!errorOccurred) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.only(top: 64.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: const Row(
        children: [
          Expanded(
            child: Text(
              'Error Occurred',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
