import 'package:demos_ai/infrastructure/services/assets_manager.dart';

class OnBoardingModel {
  String image;
  String title;
  String description;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
    image: AssetsManager.onBoarding1,
    title: "We are always there",
    description: "We are always ready to accompany you whenever and wherever",
  ),
  OnBoardingModel(
    image: AssetsManager.onBoarding2,
    title: "With us you become easy",
    description: "everything just got easier with our reminders feature",
  ),
  OnBoardingModel(
    image: AssetsManager.onBoarding3,
    title: "We are ready to help your worries",
    description: "We are ready to hear all your stories 24 hours",
  ),
];
