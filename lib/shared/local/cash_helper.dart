
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/static_model/user_model.dart';

class CashHelper {
  ///  variables declaration
  static late SharedPreferences sharedPreferences;

  ///constructor
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  ///methods of shared preferences

  // Method to save a list of values
  static Future<bool?> putData(
      {required String key, required List<String> value}) async {
    return await sharedPreferences.setStringList(key, value);
  }

  // Method to save a value
  static Future<bool?> putDataString(
      {required String key, required String value}) async {
    return await sharedPreferences.setString(key, value);
  }

  // Method to get a list of value
  static Future<List<String>?> getData(String key) async {
    return sharedPreferences.getStringList(key);
  }

  // Method to get a value
  static Future<String?> getDataString(String key) async {
    return sharedPreferences.getString(key);
  }

  // Method to save a bool value
  static Future<bool?> putBool(
      {required String key, required bool value}) async {
    return await sharedPreferences.setBool(key, value);
  }

  // Method to get a bool value
  static Future<bool?> getBool(String key) async {
    return sharedPreferences.getBool(key);
  }

  // Method to remove a value
  static Future<bool?> removeData(String key) async {
    return sharedPreferences.remove(key);
  }

  /// specifique methode

  // set token
  static Future<bool> setUserId(int userId) async {
    return await sharedPreferences.setInt('userId', userId);
  }

  // get token
  static int getUserId() {
    int? userId = sharedPreferences.getInt('userId');
    return userId!;
  }

  static Future<bool> storeLocation(String location) async {
    return await sharedPreferences.setString('location', location);
  }

  static String? getLocationAddress() {
    String? location = sharedPreferences.getString('location');
    return location;
  }

  static Future<bool> setCurrency(String currency) async {
    return await sharedPreferences.setString('currency', currency);
  }

  static String getCurrency() {
    String currency = sharedPreferences.getString('currency') ?? 'ر.س ';
    return currency;
  }



  static Future<bool> setUserData(UserModel user) async {
    List<String> data = [
      user.fullName??'',
      user.image??'',
      user.phone??'',
      user.email??'',
    ];
    return await sharedPreferences.setStringList('userData', data);
  }


  static UserModel getUserData() {
    List<String> data = sharedPreferences.getStringList('userData') ?? [];

    return UserModel(
      fullName: data[0],
      image: data[1],
      phone: data[2],
      email: data[3],
    );
  }


  //clear all data
  static Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }
}
