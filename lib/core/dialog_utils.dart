import 'package:evently_app/core/resoources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogUtils {
  static void showMassegeDialog({
    required BuildContext context,
    required String message,
    required String postitle,
    required void Function() posclick,
    String? negtitle,
    void Function()? negclick,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: ColorManager.withe,
            title: Text(message),
            actions: [
              ElevatedButton(onPressed: posclick, child: Text(postitle)),
              Visibility(
                visible: negtitle != null,
                child: ElevatedButton(
                  onPressed: negclick,
                  child: Text(negtitle ?? ""),
                ),
              ),
            ],
          ),
    );
  }

  static showLodingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: ColorManager.withe,
            title: Center(child: CircularProgressIndicator()),
          ),
    );
  }

  static showtoast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }
}
