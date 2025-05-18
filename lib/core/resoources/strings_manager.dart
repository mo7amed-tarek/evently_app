import 'package:easy_localization/easy_localization.dart';

abstract final class StringsManager {
  static String get startTitle => 'startTitle'.tr();
  static String get startDesc => 'startDesc'.tr();
  static String get language => 'language'.tr();
  static String get theme => 'theme'.tr();
  static String get letsStart => 'letsStart'.tr();

  static String get onTitle1 => 'on_title'.tr();
  static String get onDesc1 => 'on_description'.tr();
  static String get onTitle2 => 'on_title2'.tr();
  static String get onDesc2 => 'on_description2'.tr();
  static String get onTitle3 => 'on_title3'.tr();
  static String get onDesc3 => 'on_description3'.tr();

  static String get register => 'register'.tr();
  static String get name => 'name'.tr();
  static String get email => 'email'.tr();
  static String get password => 'password'.tr();
  static String get repassword => 'repassword'.tr();
  static String get createAccount => 'Create Account'.tr();
  static String get alreadyHaveAccount => 'Already Have Account ?'.tr();
  static String get login => "login".tr();
  static String get dontHaveAccount => 'Don’t Have Account ?'.tr();
  static String get forgetPassword => 'Forget Password?'.tr();
  static String get resetPassword => 'Reset Password'.tr();
  static String get shouldnotempty => 'should not be empty'.tr();
  static String get Emailnotvaliad => 'Email not valiad'.tr();
  static String get passvaladetion =>
      'Password shoulnt be less than 8 char'.tr();
  static String get userNotFoundForEmail => 'No user found for that email'.tr();
  static String get ok => 'OK'.tr();
  static String get wrongPassword =>
      'Wrong password provided for that user.'.tr();
  static String get linksentsucessful => 'link sent sucessful'.tr();
  static String get passwordsDoNotMatch => 'Passwords do not match.'.tr();
  static String get weakPassword => 'The password provided is too weak.'.tr();
  static String get emailAlreadyInUse =>
      'The account already exists for that email.'.tr();
}
