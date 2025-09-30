import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureCashHelper {
  ///  variables declaration
  static late FlutterSecureStorage storage;

  ///constructor
  static init() async {
    storage = const FlutterSecureStorage();
  }

  ///methods of secure storage

  // Method to save a value
  static Future<void> putDataSecure(
      {required String key, required String value}) async {
    return await storage.write(key: key, value: value);
  }

  // Method to get a value
  static Future<String?> getDataSecure(String key) async {
    return await storage.read(key: key);
  }

  // Method to delete a value
  static Future<void> deleteDataSecure(String key) async {
    await storage.delete(key: key);
  }

  // Method to check if a key exists
  static Future<bool> containsKey(String key) async {
    var allValues = await storage.readAll();
    return allValues.containsKey(key);
  }

  // Method to clear all values
  static Future<void> clear() async {
    await storage.deleteAll();
  }

  /// specifique methode

  // set token
  static Future<void> setToken(String token) async {
    return await storage.write(key: 'token', value: token);
  }

  // get token
  static Future<String> getToken() async {
    String token = await storage.read(key: 'token') ?? '';
    return token;
  }
}
