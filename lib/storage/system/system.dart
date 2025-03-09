import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../../exceptions/illegal_state.dart';
import '../bookmarks/handler.dart';
import '../tags/handler.dart';

typedef JsonObject = Map<String, Object?>;
typedef JsonArray = Iterable<JsonObject>;

abstract class StorageSystem<T> with ChangeNotifier {
  static const _storageDir = 'storages';
  static Set<StorageSystem> storages = {
    bookmarksStorageHandler,
    tagsStorageHandler
  };
  final String storageName;
  T? _cached;

  StorageSystem(this.storageName);

  /// Data to save into file
  ///
  /// Ensure nothing is encoded as [saveToStorage] is in charge of it
  JsonObject toJson(T object);

  /// Create object from json
  T fromJson(JsonObject jsonObject);

  /// Saves data to storage
  Future<void> saveToStorage({T? object}) async {
    try {
      debugPrint('[$storageName] Starting saving to storage');
      object ??= _cached;
      if(object == null) throw IllegalStateException();
      final storagesDir = await _getStoragesDir();
      File(
        '$storagesDir/$storageName',
      ).writeAsStringSync(jsonEncode(toJson(object)));
      debugPrint('Successfully saved to: $storageName');
    } catch (error, stackTrace) {
      debugPrint('$error\n$stackTrace');
    } finally {
      notifyListeners();
    }
  }

  /// Returns cached storage, throws error if it's not cached
  T getOrThrow() => _cached!;

  /// Returns cached storage or null
  T? getOrNull() => _cached;

  /// Get default object for caching when it does not exist
  T defaultObjectProvider();

  /// Get data from storage
  Future<T> getFromStorage() async {
    try {
      debugPrint('[$storageName] Getting data from storage');
      final storageFile = await _getStorageFile();
      final data = await storageFile.readAsString();
      if (data.trim().isEmpty) {
        debugPrint('[$storageName] STORAGE IS EMPTY');
        return _cached = defaultObjectProvider();
      }
      debugPrint('[$storageName] Successfully retrieved data');
      final T object = fromJson(json.decode(data));
      return _cached = object;
    } catch (error, stackTrace) {
      debugPrint('$error\n$stackTrace');
      return _cached = defaultObjectProvider();
    } finally {
      notifyListeners();
    }
  }

  /// Get main storage file
  Future<File> _getStorageFile() async {
    final storagesDir = await _getStoragesDir();
    final file = File('$storagesDir/$storageName');
    if (await file.exists()) return file;
    await file.writeAsString('');
    return file;
  }

  /// Get main storage folder inside internal storage
  Future<String> _getStoragesDir() async {
    final mainDirPath = (await getApplicationDocumentsDirectory()).path;
    final dir = Directory('$mainDirPath/$_storageDir');
    dir.createSync();
    return dir.path;
  }
}
