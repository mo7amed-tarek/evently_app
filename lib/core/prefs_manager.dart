import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static late SharedPreferences prefs;
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static savathemeMode(bool newtheme) {
    prefs.setBool("theme", newtheme);
  }

  static bool getThemeMode() {
    return prefs.getBool("theme") ?? false;
  }

  static saveProfileImage(String path) {
    prefs.setString("profileImage", path);
  }

  static String? getProfileImage() {
    return prefs.getString("profileImage");
  }

  static clearProfileImage() {
    prefs.remove("profileImage");
  }
}
