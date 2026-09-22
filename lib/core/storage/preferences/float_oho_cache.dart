import 'package:b21pdf/core/storage/preference_keys.dart';

abstract final class FloatOhoCache {
  static int read() {
    return getStorage.read<int>(PreferenceKeys.floatOho) ?? 50;
  }

  static Future<void> save({required int timestamp}) {
    return getStorage.write(PreferenceKeys.floatOho, timestamp);
  }
}
