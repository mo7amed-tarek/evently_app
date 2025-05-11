import 'package:evently_app/core/resoources/assets_manager.dart';
import 'package:evently_app/core/resoources/constants.dart';
import 'package:evently_app/core/resoources/strings_manager.dart';
import 'package:evently_app/core/reusable_components/custom_buttom.dart';
import 'package:evently_app/core/reusable_components/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController nameConroller;
  late TextEditingController emailConroller;
  late TextEditingController passConroller;
  late TextEditingController repassConroller;
  GlobalKey<FormState> formkay = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    nameConroller = TextEditingController();
    emailConroller = TextEditingController();
    passConroller = TextEditingController();
    repassConroller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameConroller.dispose();
    emailConroller.dispose();
    passConroller.dispose();
    repassConroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(StringsManager.register),
      ),
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
                  hint: StringsManager.name,
                  controller: nameConroller,
                  prefixpath: AssetsManager.name,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "should not be empty";
                    }
                    return null;
                  },
                  kyboard: TextInputType.name,
                ),
                SizedBox(height: 16.h),
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
                CustomField(
                  hint: StringsManager.repassword,
                  obscure: true,
                  controller: repassConroller,
                  prefixpath: AssetsManager.repass,
                  validation: (value) {
                    if (value != passConroller.text) {
                      return " Not same as password";
                    }
                    return null;
                  },
                  kyboard: TextInputType.visiblePassword,
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    title: StringsManager.createAccount,
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
                      StringsManager.alreadyHaveAccount,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        StringsManager.login,
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
