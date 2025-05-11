import 'package:easy_localization/easy_localization.dart';

abstract final class StringsManager {
  // Onboarding Strings
  static String get startTitle => 'startTitle'.tr();
  static String get startDesc => 'startDesc'.tr();
  static String get language => 'language'.tr();
  static String get theme => 'theme'.tr();
  static String get letsStart => 'letsStart'.tr();

  // Onboarding Screens Content
  static String get onTitle1 => 'on_title'.tr();
  static String get onDesc1 => 'on_description'.tr();
  static String get onTitle2 => 'on_title2'.tr();
  static String get onDesc2 => 'on_description2'.tr();
  static String get onTitle3 => 'on_title3'.tr();
  static String get onDesc3 => 'on_description3'.tr();

  // Authentication Strings
  static String get register => 'register'.tr();
  static String get name => 'name'.tr();
  static String get email => 'email'.tr();
  static String get password => 'password'.tr();
  static String get repassword => 'repassword'.tr();
  static String get createAccount => 'Create Account'.tr();
  static String get alreadyHaveAccount => 'Already Have Account ?'.tr();
  static String get login => "login".tr();
}
