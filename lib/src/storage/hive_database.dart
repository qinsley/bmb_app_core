import 'package:hive_ce_flutter/hive_flutter.dart';

import '../failures/cache_failure.dart';

/// Thin wrapper over Hive CE (community fork — the original `hive`
/// package is no longer maintained). Provides typed get/put/delete
/// with error wrapping into `CacheFailure`.
///
/// Box names should be declared as constants in `TbBoxes` so they
/// stay consistent across features.
class HiveDatabase {
  HiveDatabase._();
  static final HiveDatabase instance = HiveDatabase._();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    await Hive.initFlutter();
    _initialized = true;
  }

  Future<Box<T>> openBox<T>(String name) async {
    if (!_initialized) await init();
    if (Hive.isBoxOpen(name)) return Hive.box<T>(name);
    return Hive.openBox<T>(name);
  }

  Future<T?> get<T>({required String box, required String key}) async {
    try {
      final b = await openBox<T>(box);
      return b.get(key);
    } catch (e) {
      throw CacheFailure('Failed to read $key from $box: $e');
    }
  }

  Future<void> put<T>({
    required String box,
    required String key,
    required T value,
  }) async {
    try {
      final b = await openBox<T>(box);
      await b.put(key, value);
    } catch (e) {
      throw CacheFailure('Failed to write $key to $box: $e');
    }
  }

  Future<void> delete({required String box, required String key}) async {
    try {
      final b = await openBox<dynamic>(box);
      await b.delete(key);
    } catch (e) {
      throw CacheFailure('Failed to delete $key from $box: $e');
    }
  }

  Future<void> clearBox(String box) async {
    try {
      final b = await openBox<dynamic>(box);
      await b.clear();
    } catch (e) {
      throw CacheFailure('Failed to clear $box: $e');
    }
  }
}
