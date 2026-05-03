import 'package:evently_app/Ui/create_event/screen/create_event_screen.dart';
import 'package:evently_app/Ui/forgot%20_password/screen/forgot_password_screen.dart';
import 'package:evently_app/Ui/home/screens/home_screen.dart';
import 'package:evently_app/Ui/home/tabs/profile_tab/profile_tab.dart';
import 'package:evently_app/Ui/login/screen/login_screen.dart';
import 'package:evently_app/Ui/on/onboarding_screen.dart';
import 'package:evently_app/Ui/register/screens/register_screen.dart';
import 'package:evently_app/Ui/splash_screen/screen/splash_screen.dart';
import 'package:evently_app/Ui/start_screen/screen/start_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
    SplashScreen.routeName: (_) => const SplashScreen(),
    StartScreen.routeName: (_) => const StartScreen(),
    OnboardingScreen.routeName: (_) => const OnboardingScreen(),
    RegisterScreen.routeName: (_) => const RegisterScreen(),
    LoginScreen.routeName: (_) => const LoginScreen(),
    ForgotPasswordScreen.routeName: (_) => const ForgotPasswordScreen(),
    HomeScreen.routeNeme: (_) => const HomeScreen(),
    CreateEventScreen.routeName: (_) => const CreateEventScreen(),
    ProfileTab.routeName: (_) => const ProfileTab(),
  };
}
