import 'package:evently_app/Ui/on/onboarding_screen.dart';
import 'package:evently_app/core/prefs_manager.dart';
import 'package:evently_app/core/resoources/assets_manager.dart';
import 'package:evently_app/core/resoources/strings_manager.dart';
import 'package:evently_app/core/reusable_components/custom_buttom.dart';
import 'package:evently_app/core/reusable_components/custom_switch.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatefulWidget {
  static const String routeName = "start";

  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int selectedLanguage = 0;
  int selectedTheme = 0;

  @override
  Widget build(BuildContext context) {
    selectedLanguage = context.locale.languageCode == "ar" ? 1 : 0;

    themeprovider provider = Provider.of<themeprovider>(context, listen: false);
    selectedTheme = provider.themeMode == ThemeMode.dark ? 1 : 0;

    return Scaffold(
      appBar: AppBar(title: Image.asset(AssetsManager.titel)),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 28.h),
              Expanded(
                child: Image.asset(
                  Theme.of(context).brightness == Brightness.dark
                      ? AssetsManager.startdark
                      : AssetsManager.start,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 28.h),
              Text(
                StringsManager.startTitle.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 28.h),
              Text(
                StringsManager.startDesc.tr(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 28.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringsManager.language.tr(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomSwitch(
                    item1: AssetsManager.us,
                    item2: AssetsManager.eg,
                    isColord: false,
                    selected: selectedLanguage,
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value;

                        if (value == 0) {
                          context.setLocale(const Locale('en'));
                        } else {
                          context.setLocale(const Locale('ar'));
                        }
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringsManager.theme.tr(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomSwitch(
                    item1: AssetsManager.sunLight,
                    item2: AssetsManager.moon,
                    isColord: true,
                    selected: selectedTheme,
                    onChanged: (value) {
                      setState(() {
                        selectedTheme = value;
                        if (selectedTheme == 1) {
                          provider.changetheme(ThemeMode.dark);
                          PrefsManager.savathemeMode(true);
                        } else {
                          provider.changetheme(ThemeMode.light);
                          PrefsManager.savathemeMode(false);
                        }
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 28.h),
              CustomButton(
                title: StringsManager.letsStart.tr(),
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OnboardingScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
