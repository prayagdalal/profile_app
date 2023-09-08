import 'package:flutter/material.dart';
import 'package:login_module/presentation/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static late final SharedPreferences _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }

  static Future<void> saveLoginData(
      String? email, String? password, String? name, String? exp, String? skills, bool? keepLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email!);
    prefs.setString('password', password!);
    prefs.setString('exp', exp!);
    prefs.setString('name', name!);
    prefs.setString('skills', skills!);
    prefs.setBool('keepLoggedIn', keepLogin!);
    prefs.setString('image', '');
  }

  static Future<void> setEmail(String email) async {
    await _prefsInstance.setString('email', email);
  }

  static Future<void> setName(String name) async {
    await _prefsInstance.setString('name', name);
  }

  static Future<void> setExp(String exp) async {
    await _prefsInstance.setString('exp', exp);
  }

  static Future<void> setSkills(String skill) async {
    await _prefsInstance.setString('skills', skill);
  }

  static Future<void> setImage(String image) async {
    await _prefsInstance.setString('image', image);
  }

  static Future<void> setAuthentication(bool isLoggedin) async {
    await _prefsInstance.setBool('isLoggedin', isLoggedin);
  }

  static Future<void> setRole(String role) async {
    await _prefsInstance.setString('role', role);
  }

  static String? getAccessToken() {
    return _prefsInstance.getString('accessToken');
  }

  static String? getRefreshToken() {
    return _prefsInstance.getString('refreshToken');
  }

  static bool? getAuthentication() {
    return _prefsInstance.getBool('isLoggedin');
  }

  static bool? keepLogin() {
    return _prefsInstance.getBool('keepLoggedIn');
  }

  static String? getRole() {
    return _prefsInstance.getString('role');
  }

  static String? getImage() {
    return _prefsInstance.getString('image');
  }

  static String? getEmail() {
    return _prefsInstance.getString('email');
  }

  static String? getSkill() {
    return _prefsInstance.getString('skills');
  }

  static String? getExp() {
    return _prefsInstance.getString('exp');
  }

  static Future<String> getMembershipType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('membershipType') ?? '';
  }

  static String? getPassword() {
    return _prefsInstance.getString('password');
  }

  static String? getName() {
    return _prefsInstance.getString('name');
  }

  static Future<void> clearSessionData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.remove('email');
    // await prefs.remove('name');
    // await prefs.remove('password');
    // await prefs.remove('exp');
    // await prefs.remove('skills');
    // await prefs.remove('image');
    await prefs.clear();
    Future.delayed(Duration.zero, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginPage(), // Replace with your login screen widget
        ),
      );
    });
  }
}
