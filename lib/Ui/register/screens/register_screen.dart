import 'package:evently_app/Ui/home/screens/home_screen.dart';
import 'package:evently_app/Ui/login/screen/login_screen.dart';
import 'package:evently_app/core/dialog_utils.dart';
import 'package:evently_app/core/firestor_handler.dart';
import 'package:evently_app/core/resoources/assets_manager.dart';
import 'package:evently_app/core/resoources/constants.dart';
import 'package:evently_app/core/resoources/strings_manager.dart';
import 'package:evently_app/core/reusable_components/custom_buttom.dart';
import 'package:evently_app/core/reusable_components/custom_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:evently_app/model/users.dart' as MyUser;

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

  String? _selectedGender;

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
      appBar: AppBar(title: Text(StringsManager.register)),
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
                      return StringsManager.shouldnotempty;
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
                      return StringsManager.shouldnotempty;
                    }
                    if (!RegExp(emailRegex).hasMatch(value)) {
                      return StringsManager.Emailnotvaliad;
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
                      return StringsManager.shouldnotempty;
                    }
                    if (value.length < 8) {
                      return StringsManager.passvaladetion;
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
                      return StringsManager.passwordsDoNotMatch;
                    }
                    return null;
                  },
                  kyboard: TextInputType.visiblePassword,
                ),
                SizedBox(height: 16.h),

                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: StringsManager.SelectGender,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                  value: _selectedGender,
                  items:
                      [StringsManager.male, StringsManager.female].map((
                        String value,
                      ) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return StringsManager.pleaseSelectGender;
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.h),

                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    title: StringsManager.createAccount,
                    onClick: () {
                      if (formkay.currentState?.validate() ?? false) {
                        signup();
                      }
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
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          LoginScreen.routeName,
                        );
                      },
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

  signup() async {
    try {
      DialogUtils.showLodingDialog(context);
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailConroller.text,
            password: passConroller.text,
          );
      await FirestorHandler.addUser(
        MyUser.User(
          name: nameConroller.text,
          gender: _selectedGender,
          email: emailConroller.text,
          id: credential.user?.uid,
        ),
      );
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreen.routeNeme,
        (Route) => false,
      );
      print(credential.user?.uid);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        DialogUtils.showMassegeDialog(
          context: context,
          message: StringsManager.weakPassword,
          postitle: StringsManager.ok,
          posclick: () {
            Navigator.pop(context);
          },
        );
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.showMassegeDialog(
          context: context,
          message: StringsManager.emailAlreadyInUse,
          postitle: StringsManager.ok,
          posclick: () {
            Navigator.pop(context);
          },
        );
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
