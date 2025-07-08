import 'package:flutter/material.dart';

abstract class ScreenOption {
  static final Iterable<ScreenOption> values = {
    BookmarksScreenOption(),
    TagsScreenOption(),
    SettingsScreenOption(),
  };

  final int screenIndex;
  final String label;
  final IconData icon;

  ScreenOption(this.screenIndex, this.label, this.icon);

  NavigationDestination getDestination() {
    return NavigationDestination(
      icon: Icon(icon, color: Colors.white, size: 24.0),
      label: label,
    );
  }
}

class BookmarksScreenOption extends ScreenOption {
  static const int index = 0;
  static final _instance = BookmarksScreenOption._();

  BookmarksScreenOption._() : super(index, 'Bookmarks', Icons.bookmarks);

  factory BookmarksScreenOption() => _instance;
}

class TagsScreenOption extends ScreenOption {
  static const int index = 1;
  static final _instance = TagsScreenOption._();

  TagsScreenOption._() : super(index, 'Tags', Icons.tag);

  factory TagsScreenOption() => _instance;
}

class SettingsScreenOption extends ScreenOption {
  static const int index = 2;
  static final _instance = SettingsScreenOption._();

  SettingsScreenOption._() : super(index, 'Settings', Icons.settings);

  factory SettingsScreenOption() => _instance;
}
