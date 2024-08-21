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
