import 'package:flutter/material.dart';

import '../models/navigation/screen_option.dart';
import '../models/navigation/navigation_info.dart';

class MainNavigationBar extends StatefulWidget {
  final bool useMargin;

  const MainNavigationBar({this.useMargin = false, super.key});

  @override
  State<StatefulWidget> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  static const _navigationBarHeight = 48.0;
  static const _mainColor = Color(0xFF535353);
  static const _indicatorColor = Color(0xFF7E7E7E);
  static const _padding = EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0);

  bool get _useMargin => widget.useMargin;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _mainColor,
      child: Padding(
        padding: _useMargin ? _padding : EdgeInsets.zero,
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            NavigationBar(
              height: _navigationBarHeight,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              indicatorColor: _indicatorColor,
              backgroundColor: _mainColor,
              selectedIndex: NavigationInfo().currentScreen.screenIndex,
              destinations:
                  ScreenOption.values
                      .map((option) => option.getDestination())
                      .toList(),
              onDestinationSelected:
                  (index) =>
                      NavigationInfo().onDestinationSelected(index, context),
            ),
          ],
        ),
      ),
    );
  }
}
