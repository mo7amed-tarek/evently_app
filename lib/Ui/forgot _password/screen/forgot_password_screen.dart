import 'package:evently_app/core/dialog_utils.dart';
import 'package:evently_app/core/resoources/assets_manager.dart';
import 'package:evently_app/core/resoources/constants.dart';
import 'package:evently_app/core/resoources/strings_manager.dart';
import 'package:evently_app/core/reusable_components/custom_buttom.dart';
import 'package:evently_app/core/reusable_components/custom_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = "forgot password";
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController emailConroller;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    emailConroller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailConroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(StringsManager.forgetPassword)),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset(AssetsManager.forgot),
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
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  title: StringsManager.resetPassword,
                  onClick: () async {
                    if (formkey.currentState?.validate() ?? false) {
                      DialogUtils.showLodingDialog(context);
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: emailConroller.text,
                      );
                      Navigator.pop(context);
                      DialogUtils.showtoast(StringsManager.linksentsucessful);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
