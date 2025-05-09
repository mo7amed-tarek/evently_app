import 'dart:async';

import 'package:evently_app/Ui/start_screen/screen/start_screen.dart';
import 'package:evently_app/core/resoources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, StartScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Image.asset(AssetsManager.logo)
                  .animate()
                  .slideX(duration: Duration(milliseconds: 800))
                  .then()
                  .scale(begin: Offset(0.5, 0.5)),

              Spacer(),
              Image.asset(AssetsManager.brand),
            ],
          ),
        ),
      ),
    );
  }
}
