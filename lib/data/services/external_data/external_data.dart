import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/bookmarks/bookmarks.dart';
import '../../models/tags/tags.dart';
import '../bookmarks/handler.dart';
import '../settings/settings.dart';
import '../tags/handler.dart';

class ExternalData {
  final DateFormat _formatter = DateFormat('yyyy-MM-dd-HH-mm-ss-SSS');

  Future<void> export() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) await Permission.storage.request();
    Directory tempDir = Directory('/storage/emulated/0/Download/');
    String tempPath = tempDir.path;
    final DateTime now = DateTime.now();
    var filePath = '$tempPath/bookmarks_${_formatter.format(now)}.json';
    await File(filePath).writeAsString(dataToExport());
  }

  String dataToExport() {
    return json.encode({
      Bookmarks.iterableKey: bookmarksStorageHandler.getOrThrow().exported(),
      Tags.iterableKey: tagsStorageHandler.getOrThrow().exported(),
      SettingsStorage.settingsKey: SettingsStorage.instance.exported(),
    });
  }

  Future<void> import(Map<String, Object?> jsonObject) async {
    await bookmarksStorageHandler.getOrThrow().import(
      jsonObject[Bookmarks.iterableKey] as Iterable<Object?>,
    );
    await tagsStorageHandler.getOrThrow().import(
      jsonObject[Tags.iterableKey] as Iterable<Object?>,
    );
    await SettingsStorage.instance.import(
      jsonObject[SettingsStorage.settingsKey] as Map<String, Object?>,
    );
  }
}
