import 'dart:math';

import 'package:finutss/new%20ui/modules/sign_in/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final Future<SharedPreferences> prefsData = SharedPreferences.getInstance();

  static Future<void> saveUser({
    LogInUser? user,
    String? token,
    String? email,
    String? userName,
    String? profilePicture,
    String? coverPicture,
    String? name,
    String? description,
    String? userId,
    required bool isLogin,
  }) async {
    final SharedPreferences prefs = await prefsData;
    await prefs.setString("email", email ?? '');
    await prefs.setString("userName", userName ?? '');
    await prefs.setString("profilePicture", profilePicture ?? '');
    await prefs.setString("coverPicture", coverPicture ?? '');
    await prefs.setString("name", name ?? '');
    await prefs.setString("description", description ?? '');
    await prefs.setString("token", token ?? '');
    await prefs.setString("userId", userId ?? '');
    await prefs.setBool("IsLogin", isLogin);
  }

  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await prefsData;
    await prefs.setString("token", token);
  }
  static Future<void> saveTimeZone(String token) async {
    final SharedPreferences prefs = await prefsData;
    await prefs.setString("saveTimeZone", token);
  }

  static Future<void> saveUsernameBio(
      String username, String description) async {
    final SharedPreferences prefs = await prefsData;
    await prefs.setString("userName", username);
    await prefs.setString("description", description);
  }

  static Future<String> getUserEmail() async {
    final SharedPreferences prefs = await prefsData;
    return prefs.getString("email") ?? "";
  }

  static Future<bool> getPhoneLanguage() async {
    final SharedPreferences prefs = await prefsData;
    return prefs.getBool("PhoneLanguage") ?? true;
  }

  static Future<void> isPhoneLanguage(bool isOpen) async {
    final SharedPreferences prefs = await prefsData;
    await prefs.setBool("PhoneLanguage", isOpen);
  }

  static Future<void> saveProfilePhoto(String photo) async {
    final SharedPreferences prefs = await prefsData;
    await prefs.setString("profilePicture", photo);
  }


  static Future<bool> getVerification() async {
    final SharedPreferences prefs = await prefsData;
    return prefs.getBool("IsVerification") ?? false;
  }

  static Future<void> setIsVerification(bool isOpen) async {
    final SharedPreferences prefs = await prefsData;
    await prefs.setBool("IsVerification", isOpen);
  }

  static Future<bool> getSocialLogin() async {
    final SharedPreferences prefs = await prefsData;
    return prefs.getBool("IsSocial") ?? false;
  }

  static Future<void> setSocialLogin(bool isOpen) async {
    final SharedPreferences prefs = await prefsData;
    await prefs.setBool("IsSocial", isOpen);
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await prefsData;
    return prefs.getString("token") ?? "";
  }
  static Future<String> getTimeZone() async {
    final SharedPreferences prefs = await prefsData;
    return prefs.getString("saveTimeZone") ?? "Asia/Kolkata";
  }
  static Future<String> getUserId() async {
    final SharedPreferences prefs = await prefsData;
    return prefs.getString("userId") ?? "";
  }

  static Future<void> guestLogin(bool token) async {
    final SharedPreferences prefs = await prefsData;
    await prefs.setBool("guestLogin", token);
  }

  static Future<bool> getGuestLogin() async {
    final SharedPreferences prefs = await prefsData;
    return prefs.getBool("guestLogin") ?? false;
  }

  static Future<bool> getLogin() async {
    final SharedPreferences prefs = await prefsData;
    return prefs.getBool("IsLogin") ?? false;
  }

  static Future<bool> getOnBoarding() async {
    final SharedPreferences prefs = await prefsData;
    return prefs.getBool("OnBoarding") ?? false;
  }

  static Future<bool> setOnBoarding(bool isShow) async {
    final SharedPreferences prefs = await prefsData;
    return prefs.setBool("OnBoarding", isShow);
  }

  static Future<LogInUser?> getUser() async {
    final SharedPreferences prefs = await prefsData;

    String username = await prefs.getString("userName") ?? "";
    String email = await prefs.getString("email") ?? '';
    String profilePicture = await prefs.getString("profilePicture") ?? '';
    String coverPicture = await prefs.getString("coverPicture") ?? '';
    String name = await prefs.getString("name") ?? '';
    String token = await prefs.getString("token") ?? "";
    String userId = await prefs.getString("userId") ?? "";
    String bio = await prefs.getString("description") ?? "";


    return LogInUser(
      name: username,
      token: token,
      email: email,
      bio: bio,
      profilePicture: profilePicture,
      coverPicture: coverPicture,
      userId: userId,
    );
  }

  static Future<void> clearUser() async {
    final SharedPreferences prefs = await prefsData;
    prefs.setString("username", "");
    prefs.setString("description", "");
    prefs.setString("password", "");
    prefs.setString("token", "");
    prefs.setBool("IsLogin", false);
    prefs.setBool("guestLogin", false);
    prefs.clear();
  }
}
