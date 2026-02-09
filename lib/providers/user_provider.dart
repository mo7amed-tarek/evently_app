import 'package:evently_app/model/users.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User? myUser;
  String? profileImagePath;

  void savaUser(User? newUser) {
    myUser = newUser;
    notifyListeners();
  }

  void clearUser() {
    myUser = null;
    profileImagePath = null;
    notifyListeners();
  }

  void setProfileImage(String path) {
    profileImagePath = path;
    notifyListeners();
  }
}
