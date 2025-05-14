import 'package:evently_app/Ui/forgot%20_password/screen/forgot_password_screen.dart';
import 'package:evently_app/Ui/register/screens/register_screen.dart';
import 'package:evently_app/core/resoources/assets_manager.dart';
import 'package:evently_app/core/resoources/constants.dart';
import 'package:evently_app/core/resoources/strings_manager.dart';
import 'package:evently_app/core/reusable_components/custom_buttom.dart';
import 'package:evently_app/core/reusable_components/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<LoginScreen> {
  late TextEditingController emailConroller;
  late TextEditingController passConroller;

  GlobalKey<FormState> formkay = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    emailConroller = TextEditingController();
    passConroller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    emailConroller.dispose();
    passConroller.dispose();
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
                Image.asset(AssetsManager.logo),
                SizedBox(height: 24.h),

                CustomField(
                  hint: StringsManager.email,
                  controller: emailConroller,
                  prefixpath: AssetsManager.email,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "should not be empty";
                    }
                    if (!RegExp(emailRegex).hasMatch(value)) {
                      return "Email not valiad";
                    }
                    return null;
                  },
                  kyboard: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.h),
                CustomField(
                  hint: StringsManager.password,
                  obscure: true,
                  controller: passConroller,
                  prefixpath: AssetsManager.pass,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "should not be empty";
                    }
                    if (value.length < 8) {
                      return "Password shouln't be less than 8 char";
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
                      StringsManager.forgetPassword,
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
                    title: StringsManager.login,
                    onClick: () {
                      formkay.currentState?.validate();
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringsManager.dontHaveAccount,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: Text(
                        StringsManager.createAccount,
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
}
