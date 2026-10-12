import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:material_ui/material_ui.dart';

import 'app/app.dart';

void main() {
  initializeLogging();
  runApp(const ProviderScope(child: MyApp()));
}

void initializeLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    log(
      '${record.time}: ${record.message}',
      time: record.time,
      sequenceNumber: record.sequenceNumber,
      level: record.level.value,
      name: record.loggerName,
      zone: record.zone,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  });
}
