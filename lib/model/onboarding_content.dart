import 'package:evently_app/core/resoources/assets_manager.dart';
import 'package:evently_app/core/resoources/strings_manager.dart';
import 'package:flutter/material.dart';

class OnboardingContent {
  final String Function(BuildContext context) image2;
  final String description;
  final String additionalDescription;

  OnboardingContent({
    required this.image2,
    required this.description,
    required this.additionalDescription,
  });

  static List<OnboardingContent> contents = [
    OnboardingContent(
      image2: (_) => AssetsManager.on1,
      description: StringsManager.on_title1,
      additionalDescription: StringsManager.on_desc1,
    ),

    OnboardingContent(
      image2:
          (context) =>
              Theme.of(context).brightness == Brightness.dark
                  ? AssetsManager.on2Dark
                  : AssetsManager.on2,
      description: StringsManager.on_title2,
      additionalDescription: StringsManager.on_desc2,
    ),

    OnboardingContent(
      image2:
          (context) =>
              Theme.of(context).brightness == Brightness.dark
                  ? AssetsManager.on3Dark
                  : AssetsManager.on3,
      description: StringsManager.on_title3,
      additionalDescription: StringsManager.on_desc3,
    ),
  ];
}
