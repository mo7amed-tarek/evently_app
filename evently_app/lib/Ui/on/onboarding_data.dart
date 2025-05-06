import 'package:evently_app/core/resoources/assets_manager.dart';
import 'package:evently_app/core/resoources/strings_manager.dart';
import 'package:evently_app/model/onboarding_content.dart';

List<OnboardingContent> contents = [
  OnboardingContent(
    image2: AssetsManager.on1,
    description: StringsManager.onTitle1,
    additionalDescription: StringsManager.onDesc1,
  ),
  OnboardingContent(
    image2: AssetsManager.on2,
    description: StringsManager.onTitle2,
    additionalDescription: StringsManager.onDesc2,
  ),
  OnboardingContent(
    image2: AssetsManager.on3,
    description: StringsManager.onTitle3,
    additionalDescription: StringsManager.onDesc3,
  ),
];
