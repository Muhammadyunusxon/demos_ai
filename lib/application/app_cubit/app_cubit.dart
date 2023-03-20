
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../infrastructure/services/local_storage.dart';

part 'app_state.dart';

class MyAppCubit extends Cubit<MyAppState> {
  MyAppCubit() : super(MyAppState());

  getTheme() async =>
      emit(state.copyWith(isChangeTheme: await LocalStore.getTheme()));

  Future<void> change() async {
    emit(state.copyWith(isChangeTheme: !state.isChangeTheme));
    LocalStore.setTheme(state.isChangeTheme);
  }

  changePageIndex({required VoidCallback onPushed}) {
    state.page != 2 ? emit(state.copyWith(page: state.page + 1)) : onPushed();
  }

  changePage(int select) {
    emit(state.copyWith(selected: select));
  }


  void loadAd() {
    // print("Start");
    final String adUnitId = Platform.isAndroid
        ? 'ca-app-pub-4573737784354321/1273614648'
        : 'ca-app-pub-4573737784354321/2809794262';
    // print("platform");
    BannerAd bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          emit(state.copyWith(isLoaded: true));
        },

        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: ${err.message}');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
    // print("end");
    emit(state.copyWith(bannerAd: bannerAd));
  }

}
