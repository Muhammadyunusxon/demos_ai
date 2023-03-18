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
    image: "assets/images/on_boarding1.png",
    title: "We are always there",
    description: "We are always ready to accompany you whenever and wherever",
  ),
  OnBoardingModel(
    image: "assets/images/on_boarding2.png",
    title: "With us you become easy",
    description: "everything just got easier with our reminders feature",
  ),
  OnBoardingModel(
    image: "assets/images/on_boarding3.png",
    title: "We are ready to help your worries",
    description: "We are ready to hear all your stories 24 hours",
  ),
];
