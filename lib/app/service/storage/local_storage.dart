import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class LocalStorage {
  Future<void> checkFirstRun();

  Future<int?> getUserId();

  Future<void> setUserId(int? value);

  Set<int> getReadQuestionIds();

  Future<void> setReadQuestionIds(Set<int> ids);
}

class LocalStorageImpl implements LocalStorage {
  static const _keyFirstRun = 'first_run';
  static const _keyUserId = 'user_id';
  static const _keyReadIds = 'read_ids';

  late final SharedPreferences _sharedPrefs;
  late final FlutterSecureStorage _secureStorage;

  Future<LocalStorageImpl> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
    _secureStorage = const FlutterSecureStorage();

    return this;
  }

  @override
  Future<void> checkFirstRun() async {
    if (_sharedPrefs.containsKey(_keyFirstRun)) return;

    await Future.wait([
      setUserId(null),
      _sharedPrefs.setBool(_keyFirstRun, false),
    ]);
  }

  @override
  Future<int?> getUserId() async {
    final stringValue = await _secureStorage.read(key: _keyUserId);

    return int.tryParse(stringValue ?? '');
  }

  @override
  Future<void> setUserId(int? value) {
    return value == null
        ? _secureStorage.delete(key: _keyUserId)
        : _secureStorage.write(key: _keyUserId, value: '$value');
  }

  @override
  Set<int> getReadQuestionIds() {
    final value = _sharedPrefs.getString(_keyReadIds) ?? '';
    if (value.isEmpty) return {};

    final split = value.split(',');

    return split.map((e) => int.parse(e)).toSet();
  }

  @override
  Future<void> setReadQuestionIds(Set<int> ids) {
    final value = ids.isEmpty ? '' : ids.join(',');

    return _sharedPrefs.setString(_keyReadIds, value);
  }
}
