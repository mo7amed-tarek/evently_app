import 'package:evently_app/model/users.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User? myUser;
  savaUser(User? newUser) {
    myUser = newUser;
    notifyListeners();
  }
}
