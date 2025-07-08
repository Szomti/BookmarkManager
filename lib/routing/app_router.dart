import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/loading/library.dart';

// TODO: finish
final router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoadingScreen();
      },
    ),
  ],
);
