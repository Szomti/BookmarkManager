import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class ShellWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ShellWithNavBar(this.navigationShell, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => navigationShell.goBranch(index),
        items: const [
          BottomNavigationBarItem(
            label: 'Tags',
            icon: Icon(Symbols.style),
            activeIcon: Icon(Symbols.style, fill: 1.0),
          ),
          BottomNavigationBarItem(
            label: 'Bookmarks',
            icon: Icon(Symbols.home),
            activeIcon: Icon(Symbols.home, fill: 1.0),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Symbols.settings),
            activeIcon: Icon(Symbols.settings, fill: 1.0),
          ),
        ],
      ),
    );
  }
}
