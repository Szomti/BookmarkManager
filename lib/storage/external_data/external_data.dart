import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../bookmarks/bookmarks.dart';
import '../settings/settings.dart';
import '../tags/tags.dart';

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
      BookmarksStorage.iterableKey: BookmarksStorage.instance.exported(),
      TagsStorage.iterableKey: TagsStorage.instance.exported(),
      SettingsStorage.settingsKey: SettingsStorage.instance.exported(),
    });
  }

  Future<void> import(Map<String, Object?> jsonObject) async {
    await BookmarksStorage.instance.import(
      jsonObject[BookmarksStorage.iterableKey] as Iterable<Object?>,
    );
    await TagsStorage.instance.import(
      jsonObject[TagsStorage.iterableKey] as Iterable<Object?>,
    );
    await SettingsStorage.instance.import(
      jsonObject[SettingsStorage.settingsKey] as Map<String, Object?>,
    );
  }
}
