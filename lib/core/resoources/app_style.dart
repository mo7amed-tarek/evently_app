import 'package:evently_app/core/resoources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyle {
  static ThemeMode themeMode = ThemeMode.light;

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorManager.lightbackground,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorManager.blue,
      shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 4.w)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorManager.blue,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorManager.whiteReal,
      unselectedItemColor: ColorManager.whiteReal,
      selectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      ),
    ),
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 22.sp,
        color: ColorManager.black,
      ),
    ),

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      primary: ColorManager.blue,
      secondary: ColorManager.black,
      tertiary: ColorManager.red,
      brightness: Brightness.light,
      onPrimary: Colors.white,
      onPrimaryContainer: ColorManager.grey,
      primaryContainer: ColorManager.blue,
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
      titleSmall: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorManager.grey,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorManager.darkbackground,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorManager.blue,
      shape: StadiumBorder(side: BorderSide(color: ColorManager.whiteReal, width: 4.w)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorManager.darkbackground,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorManager.blue,
      unselectedItemColor: ColorManager.white,
      selectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      ),
    ),
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 22.sp,
        color: ColorManager.blue,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      primary: ColorManager.blue,
      secondary: Colors.grey,
      tertiary: ColorManager.red,
      brightness: Brightness.dark,
      onPrimary: ColorManager.whiteReal,
      onSecondary: ColorManager.black,
      onSurface: ColorManager.whiteReal,
      onSurfaceVariant: ColorManager.white,
      onPrimaryContainer: ColorManager.white,
      primaryContainer: ColorManager.darkbackground,
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
        color: ColorManager.whiteReal,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
      ),
      titleSmall: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorManager.whiteReal,
      ),
    ),
  );
}
