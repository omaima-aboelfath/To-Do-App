/*
import 'package:flutter/material.dart';

/**
 StateManagement => بتغير لي كذا ودجت من مرة وحدة زي مثلا اللغة والوضع
 StateFulWidget =>  بتغير لي ودجت وحدة بس زي الكاونتر
 */

class AppConfigProvider extends ChangeNotifier {
  // in stateManagement class :
  // put data that if change it will affect multi widgets
  // put function that will changes this data
  // هشوف بعدها البروفايدر هيأثر على انهي ويدجت

  String appLanguage = 'en';
  ThemeMode appMode = ThemeMode.light;

  void changeLanguage(String newLanguage) {
    // لو اللغة اللي اختارها المستخدم هي هي نفس اللغة الحالية هيطلع برة
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    // هتبعت اشعار ...
    notifyListeners();
  }

  void changeMode(ThemeMode newMode) {
    if (appMode == newMode) {
      return;
    }
    appMode = newMode;
    notifyListeners();
  }

  // OR : اختصار
  bool isDarkMode() {
    return appMode == ThemeMode.dark;
  }
  bool isLightMode() {
    return appMode == ThemeMode.light;
  }
}
*/

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = 'en';
  ThemeMode appMode = ThemeMode.light;

  AppConfigProvider() {
    // Load the saved preferences when the provider is initialized
    _loadPreferences();
  }

  void changeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    _saveLanguagePreference(newLanguage); // Save the preference
    notifyListeners();
  }

  void changeMode(ThemeMode newMode) {
    if (appMode == newMode) {
      return;
    }
    appMode = newMode;
    _saveThemePreference(newMode); // Save the preference
    notifyListeners();
  }

  bool isDarkMode() {
    return appMode == ThemeMode.dark;
  }

  bool isLightMode() {
    return appMode == ThemeMode.light;
  }

  // Load preferences
  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    appLanguage = prefs.getString('appLanguage') ?? 'en';
    appMode = prefs.getBool('isDarkMode') ?? false ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Notify listeners after loading the preferences
  }

  // Save language preference
  void _saveLanguagePreference(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('appLanguage', languageCode);
  }

  // Save theme preference
  void _saveThemePreference(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', mode == ThemeMode.dark);
  }
}
