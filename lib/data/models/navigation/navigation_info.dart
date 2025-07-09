import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    context.go(switch (index) {
      BookmarksScreenOption.index => '/bookmarks',
      TagsScreenOption.index => '/tags',
      SettingsScreenOption.index => '/settings',
      int() => throw UnimplementedError(),
    });
  }
}
