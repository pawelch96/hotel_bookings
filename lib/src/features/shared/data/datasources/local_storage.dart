import 'package:shared_preferences/shared_preferences.dart';

abstract class ILocalStorage {
  Future<void> writeData(String key, String value);
  Future<String?> readData(String key);
}

class LocalStorage implements ILocalStorage {
  LocalStorage._(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  static Future<ILocalStorage> create() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return LocalStorage._(sharedPreferences);
  }

  @override
  Future<void> writeData(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  @override
  Future<String?> readData(String key) async => _sharedPreferences.getString(key);
}
