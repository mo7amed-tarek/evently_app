import 'package:dots_indicator/dots_indicator.dart';
import 'package:evently_app/Ui/login/screen/login_screen.dart';

import 'package:evently_app/core/resoources/assets_manager.dart';
import 'package:evently_app/model/onboarding_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart'; // <-- إضافة هذا

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "onbordingscreen";

  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void nextPage() {
    if (currentIndex < OnboardingContent.contents.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }

  void previousPage() {
    if (currentIndex > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AssetsManager.titel),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: OnboardingContent.contents.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          OnboardingContent.contents[index].image2(context),
                          width: 350.w,
                          height: 350.h,
                        ),
                        SizedBox(height: 25.h),
                        Text(
                          // استخدم الترجمة على المفاتيح
                          OnboardingContent.contents[index].description.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 25.h),
                        Text(
                          OnboardingContent
                              .contents[index]
                              .additionalDescription
                              .tr(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentIndex > 0)
                    GestureDetector(
                      onTap: previousPage,
                      child: Container(
                        width: 40.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2.w,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).colorScheme.primary,
                          size: 24,
                        ),
                      ),
                    ),
                  Expanded(
                    child: DotsIndicator(
                      dotsCount: OnboardingContent.contents.length,
                      position: currentIndex.toDouble(),
                      decorator: DotsDecorator(
                        activeColor: Theme.of(context).colorScheme.primary,
                        color: Theme.of(context).colorScheme.secondary,
                        activeSize: Size(20.w, 7.h),
                        size: Size(7.w, 7.h),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: nextPage,
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2.w,
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Theme.of(context).colorScheme.primary,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
