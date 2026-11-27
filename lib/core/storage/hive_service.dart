import 'package:hive_flutter/hive_flutter.dart';

import '../errors/app_exception.dart';

class HiveService {
  static Future<void> initialize() {
    return _guard(() => Hive.initFlutter());
  }

  Future<T?> read<T>(String boxName, String key) {
    return _guard(() async {
      final box = await _box(boxName);
      final value = box.get(key);

      if (value == null) {
        return null;
      }
      if (value is T) {
        return value;
      }

      throw StorageException(
        cause: 'Stored value for "$key" is ${value.runtimeType}, expected $T.',
      );
    });
  }

  Future<void> write(String boxName, String key, Object value) {
    return _guard(() async {
      final box = await _box(boxName);
      await box.put(key, value);
    });
  }

  Future<void> delete(String boxName, String key) {
    return _guard(() async {
      final box = await _box(boxName);
      await box.delete(key);
    });
  }

  Future<Box<dynamic>> _box(String name) async {
    if (Hive.isBoxOpen(name)) {
      return Hive.box<dynamic>(name);
    }
    return Hive.openBox<dynamic>(name);
  }

  static Future<R> _guard<R>(Future<R> Function() action) async {
    try {
      return await action();
    } on StorageException {
      rethrow;
    } catch (error) {
      throw StorageException(cause: error);
    }
  }
}