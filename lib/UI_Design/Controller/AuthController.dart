import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_api_app/API/DataModels/UseerModel.dart';

class AuthController {
  static String? token;
  static UserModel? userModel;

  static const String _tokenKey = 'token';
  static const String _userModelKey = 'user-model';

  // Save Info
  static Future<void> saveInformation(String accessToken, UserModel user) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_tokenKey, accessToken);
    await sharedPreferences.setString(_userModelKey, jsonEncode(user.toJson()));

    token = accessToken;
    userModel = user;
  }

  // Update User Data
  static Future<void> updateUserData(UserModel newUserData) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userModelKey, jsonEncode(newUserData.toJson()));
    userModel = newUserData;
  }

  // Get Info
  static Future<void> getUserInformation() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString(_tokenKey);

    final savedUserModelString = sharedPreferences.getString(_userModelKey);
    if (savedUserModelString != null) {
      userModel = UserModel.fromJson(jsonDecode(savedUserModelString));
    }
  }

  // Login Check
  static Future<bool> checkLoginStatus() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final userToken = sharedPreferences.getString(_tokenKey);

    if (userToken != null) {
      await getUserInformation();
      return true;
    }
    return false;
  }

  // Logout
  static Future<void> logout() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(_tokenKey);
    await sharedPreferences.remove(_userModelKey);
    token = null;
    userModel = null;
  }
}