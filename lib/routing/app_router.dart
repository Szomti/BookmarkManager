import 'package:go_router/go_router.dart';

import '../features/bookmarks/bookmarks.dart';
import '../features/settings/settings.dart';
import '../features/shell_with_nav_bar/shell_with_nav_bar.dart';
import '../features/tags/tags.dart';

final appRouter = GoRouter(
  initialLocation: '/bookmarks',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (_, _, navigationShell) => ShellWithNavBar(navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [GoRoute(path: '/tags', builder: (_, _) => const TagsPage())],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/bookmarks',
              builder: (_, _) => const BookmarksPage(),
              routes: [
                GoRoute(
                  path: 'form',
                  builder: (_, _) => const BookmarkFormPage(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/settings', builder: (_, _) => const SettingsPage()),
          ],
        ),
      ],
    ),
  ],
);
