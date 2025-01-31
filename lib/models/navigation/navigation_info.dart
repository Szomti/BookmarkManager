import 'dart:async';

import 'package:bookmark_manager/screens/settings/library.dart';
import 'package:flutter/material.dart';

import '../../screens/bookmarks/library.dart';
import '../../screens/tags/library.dart';
import 'screen_option.dart';

class NavigationInfo {
  static final NavigationInfo _instance = NavigationInfo._();
  ScreenOption currentScreen = BookmarksScreenOption();

  NavigationInfo._();

  factory NavigationInfo() => _instance;

  Future<void> onDestinationSelected(int index, BuildContext context) async {
    currentScreen = ScreenOption.values.firstWhere(
      (option) => option.screenIndex == index,
    );
    unawaited(Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => switch (index) {
          BookmarksScreenOption.index => const BookmarksScreen(),
          TagsScreenOption.index => const TagsScreen(),
          SettingsScreenOption.index => const SettingsScreen(),
          int() => throw UnimplementedError(),
        },
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      ),
    ));
  }
}
