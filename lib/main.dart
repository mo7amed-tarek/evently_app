import 'package:evently_app/Ui/forgot%20_password/screen/forgot_password_screen.dart';
import 'package:evently_app/Ui/home/screens/home_screen.dart';
import 'package:evently_app/Ui/login/screen/login_screen.dart';
import 'package:evently_app/Ui/on/onboarding_screen.dart';
import 'package:evently_app/Ui/register/screens/register_screen.dart';
import 'package:evently_app/core/prefs_manager.dart';
import 'package:evently_app/firebase_options.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/providers/user_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:evently_app/Ui/splash_screen/screen/splash_screen.dart';
import 'package:evently_app/Ui/start_screen/screen/start_screen.dart';
import 'package:evently_app/core/resoources/app_style.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await PrefsManager.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),

      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => themeprovider()..init()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
        ],

        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    themeprovider provider = Provider.of<themeprovider>(context);
    return ScreenUtilInit(
      designSize: const Size(393, 841),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppStyle.lightTheme,
          darkTheme: AppStyle.darkTheme,
          themeMode: provider.themeMode,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          routes: {
            SplashScreen.routeName: (_) => const SplashScreen(),
            StartScreen.routeName: (_) => const StartScreen(),
            OnboardingScreen.routeName: (_) => const OnboardingScreen(),
            RegisterScreen.routeName: (_) => const RegisterScreen(),
            LoginScreen.routeName: (_) => const LoginScreen(),
            ForgotPasswordScreen.routeName: (_) => const ForgotPasswordScreen(),
            HomeScreen.routeNeme: (_) => const HomeScreen(),
          },
          initialRoute: SplashScreen.routeName,
        );
      },
    );
  }
}
