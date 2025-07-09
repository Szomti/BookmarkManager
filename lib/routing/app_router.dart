import 'package:bookmark_manager/data/models/tags/tag.dart';
import 'package:bookmark_manager/ui/bookmark_tags/library.dart';
import 'package:bookmark_manager/ui/new_tag/library.dart';
import 'package:bookmark_manager/ui/settings/library.dart';
import 'package:bookmark_manager/ui/tags/library.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/models/bookmarks/bookmark.dart';
import '../ui/bookmarks/library.dart';
import '../ui/filter_bookmarks/library.dart';
import '../ui/loading/library.dart';
import '../ui/new_bookmark/library.dart';

CustomTransitionPage _fadeTransitionPage(GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: Duration(milliseconds: 300),
    transitionsBuilder: (_, a, _, c) => FadeTransition(opacity: a, child: c),
  );
}

final router = GoRouter(
  initialLocation: '/loading',
  routes: <RouteBase>[
    GoRoute(
      path: '/loading',
      builder: (_, _) {
        return const LoadingScreen();
      },
    ),
    GoRoute(
      path: '/bookmarks',
      pageBuilder: (_, GoRouterState state) {
        return _fadeTransitionPage(state, const BookmarksScreen());
      },
    ),
    GoRoute(
      path: '/tags',
      pageBuilder: (_, GoRouterState state) {
        return _fadeTransitionPage(state, const TagsScreen());
      },
    ),
    GoRoute(
      path: '/settings',
      pageBuilder: (_, GoRouterState state) {
        return _fadeTransitionPage(state, const SettingsScreen());
      },
    ),
    GoRoute(
      path: '/new-bookmark',
      builder: (_, GoRouterState state) {
        return NewBookmarkScreen(bookmark: state.extra as Bookmark?);
      },
    ),
    GoRoute(
      path: '/filter-bookmarks',
      builder: (_, _) {
        return const FilterBookmarksScreen();
      },
    ),
    GoRoute(
      path: '/bookmark-tags',
      builder: (_, GoRouterState state) {
        return BookmarkTagsScreen(state.extra as Bookmark);
      },
    ),
    GoRoute(
      path: '/new-tag',
      builder: (_, GoRouterState state) {
        return NewTagScreen(tag: state.extra as Tag?);
      },
    ),
  ],
);
