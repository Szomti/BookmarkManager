import 'package:material_ui/material_ui.dart';

import 'app_borders.dart';

abstract final class AppTheme {
  static ThemeData dark() => ThemeData(
    colorScheme: .fromSeed(
      seedColor: const Color(0xFF0466C8),
      brightness: Brightness.dark,
    ),
    brightness: Brightness.dark,
    inputDecorationTheme: const InputDecorationThemeData(
      border: AppBorders.field,
    ),
  );
}