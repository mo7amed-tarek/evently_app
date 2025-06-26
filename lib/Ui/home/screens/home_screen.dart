import 'package:evently_app/Ui/create_event/screen/create_event_screen.dart';
import 'package:evently_app/Ui/home/tabs/home_tab/home_tab.dart';
import 'package:evently_app/Ui/home/tabs/love_tab/love_tab.dart';
import 'package:evently_app/Ui/home/tabs/map_tab/map_tab.dart';
import 'package:evently_app/Ui/home/tabs/profile_tab/profile_tab.dart';

import 'package:evently_app/core/resoources/assets_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  static const String routeNeme = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTap = 0;
  List<Widget> tabs = [HomeTab(), MapTab(), LoveTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreateEventScreen.routeName);
        },
        child: Icon(Icons.add, color: Colors.white, size: 40),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTap,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: (value) {
          selectedTap = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: SvgPicture.asset(
              AssetsManager.home,
              height: 24.h,
              width: 24.w,
            ),
            activeIcon: SvgPicture.asset(
              AssetsManager.homeSelected,
              height: 24.h,
              width: 24.w,
            ),
          ),
          BottomNavigationBarItem(
            label: "Map",
            icon: SvgPicture.asset(
              AssetsManager.map,
              height: 24.h,
              width: 24.w,
            ),
            activeIcon: SvgPicture.asset(
              AssetsManager.mapSelected,
              height: 24.h,
              width: 24.w,
            ),
          ),
          BottomNavigationBarItem(
            label: "love",
            icon: SvgPicture.asset(
              AssetsManager.heart,
              height: 24.h,
              width: 24.w,
            ),
            activeIcon: SvgPicture.asset(
              AssetsManager.heartSelected,
              height: 24.h,
              width: 24.w,
            ),
          ),
          BottomNavigationBarItem(
            label: "profile",
            icon: SvgPicture.asset(
              AssetsManager.user,
              height: 24.h,
              width: 24.w,
            ),
            activeIcon: SvgPicture.asset(
              AssetsManager.userSelected,
              height: 24.h,
              width: 24.w,
            ),
          ),
        ],
      ),
      body: tabs[selectedTap],
    );
  }
}
