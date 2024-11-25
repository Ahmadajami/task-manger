
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {

  // Constructor to initialize FlutterSecureStorage
  StorageService() {
    _secureStorage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  }

  late final FlutterSecureStorage _secureStorage;

  // Method to get AndroidOptions with encryptedSharedPreferences set to true
  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  // Save data to secure storage
  Future<void> saveData(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  // Read data from secure storage
  Future<String?> readData(String key) async {
    return  _secureStorage.read(key: key);
  }

  // Delete data from secure storage
  Future<void> deleteData(String key) async {
    await _secureStorage.delete(key: key);
  }

  // Save data to Shared Preferences
  Future<void> savePref(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // Read data from Shared Preferences
  Future<String?> readPrefs(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Delete data from Shared Preferences
  Future<void> deletePrefs(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
