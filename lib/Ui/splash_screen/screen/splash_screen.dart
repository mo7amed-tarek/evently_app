import 'dart:async';

import 'package:evently_app/Ui/home/screens/home_screen.dart';
import 'package:evently_app/Ui/start_screen/screen/start_screen.dart';

import 'package:evently_app/core/resoources/assets_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    navigateToNext();
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

  navigateToNext() async {
    if (FirebaseAuth.instance.currentUser != null) {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, HomeScreen.routeNeme);
      });
    } else {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, StartScreen.routeName);
      });
    }
  }
}
