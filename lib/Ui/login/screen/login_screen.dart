import 'package:evently_app/Ui/forgot%20_password/screen/forgot_password_screen.dart';
import 'package:evently_app/Ui/home/screens/home_screen.dart';
import 'package:evently_app/Ui/register/screens/register_screen.dart';
import 'package:evently_app/core/dialog_utils.dart';
import 'package:evently_app/core/firestor_handler.dart';
import 'package:evently_app/core/resoources/assets_manager.dart';
import 'package:evently_app/core/resoources/constants.dart';
import 'package:evently_app/core/resoources/strings_manager.dart';
import 'package:evently_app/core/reusable_components/custom_buttom.dart';
import 'package:evently_app/core/reusable_components/custom_field.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:evently_app/model/users.dart' as MyUser;
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart'; // اضفت هنا

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  GlobalKey<FormState> formkay = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formkay,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 35.h),
                Image.asset(AssetsManager.logo),
                SizedBox(height: 24.h),

                CustomField(
                  hint: StringsManager.email.tr(),
                  controller: emailController,
                  prefixpath: AssetsManager.email,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return StringsManager.shouldnotempty.tr();
                    }
                    if (!RegExp(emailRegex).hasMatch(value)) {
                      return StringsManager.Emailnotvaliad.tr();
                    }
                    return null;
                  },
                  kyboard: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.h),
                CustomField(
                  hint: StringsManager.password.tr(),
                  obscure: true,
                  controller: passwordController,
                  prefixpath: AssetsManager.pass,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return StringsManager.shouldnotempty.tr();
                    }
                    if (value.length < 8) {
                      return StringsManager.passvaladetion.tr();
                    }
                    return null;
                  },
                  kyboard: TextInputType.visiblePassword,
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        ForgotPasswordScreen.routeName,
                      );
                    },
                    child: Text(
                      StringsManager.forgetPassword.tr(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    title: StringsManager.login.tr(),
                    onClick: () {
                      if (formkay.currentState?.validate() ?? false) {
                        login();
                      }
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringsManager.dontHaveAccount.tr(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: Text(
                        StringsManager.createAccount.tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    try {
      DialogUtils.showLodingDialog(context);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      MyUser.User? myUser = await FirestorHandler.getUser(
        credential.user?.uid ?? "",
      );
      provider.savaUser(myUser);
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routeNeme);
      print(credential.user?.uid);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        DialogUtils.showMassegeDialog(
          context: context,
          message: StringsManager.userNotFoundForEmail.tr(),
          postitle: StringsManager.ok.tr(),
          posclick: () {
            Navigator.pop(context);
          },
        );
      } else if (e.code == 'wrong-password') {
        DialogUtils.showMassegeDialog(
          context: context,
          message: StringsManager.wrongPassword.tr(),
          postitle: StringsManager.ok.tr(),
          posclick: () {
            Navigator.pop(context);
          },
        );
      }
    }
  }
}
