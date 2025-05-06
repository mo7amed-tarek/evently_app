import 'package:evently_app/core/resoources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyle {
  static ThemeMode themeMode = ThemeMode.light;

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorManager.lightbackground,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      primary: ColorManager.blue,
      secondary: ColorManager.black,
      tertiary: ColorManager.red,
      brightness: Brightness.light,
      onPrimary: Colors.white,
    ),
    textTheme: TextTheme(
      labelMedium: TextStyle(
        fontSize: 20.h,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        color: ColorManager.blue,
        fontWeight: FontWeight.w700,
        fontSize: 20.sp,
      ),
      bodySmall: TextStyle(
        color: ColorManager.black,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorManager.darkbackground,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      primary: ColorManager.blue,
      secondary: ColorManager.withe,
      tertiary: ColorManager.red,
      brightness: Brightness.dark,
      onPrimary: Colors.black,
    ),
    textTheme: TextTheme(
      labelMedium: TextStyle(
        fontSize: 20.h,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        color: ColorManager.blue,
        fontWeight: FontWeight.w700,
        fontSize: 20.sp,
      ),
      bodySmall: TextStyle(
        color: ColorManager.withe,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
      ),
    ),
  );
}
