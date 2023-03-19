import 'package:flutter/material.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../infrastructure/services/local_storage.dart';
import '../../app_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    checking();
    super.initState();
  }

  checking() async {
    if (await LocalStore.getOnBoarding()) {
      // ignore: use_build_context_synchronously
      Navigator.push(context, Routes.goOnBoarding());
    } else {
      if (await LocalStore.getDocId() != null) {
        // ignore: use_build_context_synchronously
        Navigator.push(context, Routes.goHome());
      } else {
        // ignore: use_build_context_synchronously
        Navigator.push(context, Routes.goAuth());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/splash.png",
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
