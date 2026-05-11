import 'package:evently_app/core/prefs_manager.dart';
import 'package:evently_app/model/users.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User? myUser;
  String? profileImagePath;

  UserProvider() {
    profileImagePath = PrefsManager.getProfileImage();
  }

  void savaUser(User? newUser) {
    myUser = newUser;
    notifyListeners();
  }

  void clearUser() {
    myUser = null;
    profileImagePath = null;
    PrefsManager.clearProfileImage();
    notifyListeners();
  }

  void setProfileImage(String path) {
    profileImagePath = path;
    PrefsManager.saveProfileImage(path);
    notifyListeners();
  }

  void updateProfileImageRemote(String base64) {
    if (myUser != null) {
      myUser!.profileImage = base64;
      notifyListeners();
    }
  }
}
