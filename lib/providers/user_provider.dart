import 'package:flutter/material.dart';
import 'package:to_do_app/model/my_user.dart';

class UserProvider extends ChangeNotifier {
  MyUser? currentUser;

  // if i change the current account, update the current user
  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
