part of 'app_cubit.dart';

class MyAppState {
  int page;
  bool isChangeTheme;
  int selected;

  BannerAd? bannerAd;
  bool isLoaded;

  MyAppState(
      {this.page = 0,
      this.isChangeTheme = false,
      this.selected = 0,
      this.bannerAd,
      this.isLoaded = false});

  MyAppState copyWith({
    int? page,
    bool? isChangeTheme,
    int? selected,
    BannerAd? bannerAd,
    bool? isLoaded,
  }) {
    return MyAppState(
      page: page ?? this.page,
      isChangeTheme: isChangeTheme ?? this.isChangeTheme,
      selected: selected ?? this.selected,
      bannerAd: bannerAd ?? this.bannerAd,
      isLoaded: isLoaded ?? this.isLoaded,
    );
  }
}
