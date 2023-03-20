import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demos_ai/infrastructure/services/app_errors.dart';
import 'package:demos_ai/infrastructure/services/app_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../infrastructure/services/api_service.dart';
import '../../infrastructure/services/assets_manager.dart';
import '../../infrastructure/services/local_storage.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  MapsCubit() : super(MapsState());

  initial(BuildContext context) {
    getLimit();
    getTheme(context);
    setMarkerIcon(context: context);
  }

  search(String searchText) {
    emit(state.copyWith(searchText: searchText));
  }

  getTheme(BuildContext context) {
    DefaultAssetBundle.of(context)
        .loadString(AssetsManager.darkThemePath)
        .then((value) => emit(state.copyWith(mapTheme: value)));
  }

  // searchPosition(String position){
  //   emit(state.);
  // }

  void setMarkerIcon(
      {LatLng? position,
      VoidCallback? onTap,
      required BuildContext context}) async {
    Set<Marker> setOfMarker = {
      Marker(
          markerId: const MarkerId("1"),
          draggable: true,
          consumeTapEvents: true,
          flat: true,
          position: position ?? const LatLng(41.285416, 69.204007),
          onTap: () async {
            await sendMessageFCT(
                msg:
                    'longitude:${position!.longitude}, latitude:${position.latitude}',
                context: context,
                onSummit: () {
                  AppHelpers.showMyBottomSheet(
                    context: context,
                    msg: state.info,
                    isLoading: state.isLoading,
                  );
                },
                onFinal: () {
                  AppHelpers.showMyBottomSheet(
                    context: context,
                    msg: state.info,
                    isLoading: state.isLoading,
                  );
                });
            onTap != null ? onTap() : null;
          },
          onDrag: (location) {
            debugPrint("location: ${location.latitude}");
            debugPrint("location: ${location.longitude}");
          }),
    };
    emit(state.copyWith(setOfMarker: setOfMarker));
  }

  determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showTopSnackBar(
          // ignore: use_build_context_synchronously
          Overlay.of(context),
          const CustomSnackBar.error(message: AppErrors.disableService));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        showTopSnackBar(Overlay.of(context),
            const CustomSnackBar.error(message: AppErrors.permissionDenied));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      showTopSnackBar(Overlay.of(context),
          const CustomSnackBar.error(message: AppErrors.requestPermission));
      return;
    }
    Position location = await Geolocator.getCurrentPosition();
    emit(state.copyWith(currentPosition: location));
    return LatLng(location.latitude, location.longitude);
  }

  getLimit() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    var res = await firestore
        .collection("users")
        .doc(await LocalStore.getDocId())
        .get();
    emit(state.copyWith(
        extraLimit: res.data()?["extraLimit"],
        dailyLimit: res.data()?["dailyLimit"]));
  }

  sendMessageAndGetAnswers({required String msg}) async {
    print((await ApiService.sendMessageGPT(message: msg)).first.msg);
    emit(state.copyWith(
        info: (await ApiService.sendMessageGPT(message: msg)).first.msg));
  }

  Future<void> sendMessageFCT(
      {required String msg,
      required BuildContext context,
      required VoidCallback onSummit,
      required VoidCallback onFinal}) async {
    if (state.dailyLimit == 0 && state.extraLimit == 0) {
      showTopSnackBar(Overlay.of(context),
          const CustomSnackBar.error(message: AppErrors.limit));
      return;
    }
    if (state.isLoading) {
      showTopSnackBar(Overlay.of(context),
          const CustomSnackBar.error(message: AppErrors.multipleMessage));
      return;
    }

    if (msg.isEmpty) {
      showTopSnackBar(Overlay.of(context),
          const CustomSnackBar.error(message: AppErrors.emptyMessage));
      return;
    }
    try {
      emit(state.copyWith(isLoading: true));
      onSummit();
      await sendMessageAndGetAnswers(msg: msg);
    } catch (error) {
      log("error $error");
      showTopSnackBar(
          Overlay.of(context), CustomSnackBar.error(message: error.toString()));
      return;
    } finally {
      emit(state.copyWith(isLoading: false));
      onFinal();
      changeLimit();
    }
  }

  changeLimit() async {
    if (state.dailyLimit == 0) {
      emit(state.copyWith(extraLimit: state.extraLimit - 1));
    } else {
      emit(state.copyWith(dailyLimit: state.dailyLimit - 1));
    }
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection("users")
        .doc(await LocalStore.getDocId())
        .update({
      "dailyLimit": state.dailyLimit,
      "extraLimit": state.extraLimit,
    });
  }
}
