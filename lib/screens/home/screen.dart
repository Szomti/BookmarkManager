part of './library.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF454545),
      body: SafeArea(
        child: Column(
          children: [
            _TileWidget(),
            _TileWidget(),
            _TileWidget(),
            _TileWidget(),
            _TileWidget(),
          ],
        ),
      ),
    );
  }
}
