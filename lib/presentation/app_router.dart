import 'package:example_project/presentation/pages/auth/auth_page.dart';
import 'package:example_project/presentation/pages/initial/onboarding_page.dart';
import 'package:example_project/presentation/pages/initial/splash.dart';
import 'package:example_project/presentation/pages/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/app_cubit/app_cubit.dart';
import '../application/auth_cubit/auth_cubit.dart';
import '../application/home_cubit/home_cubit.dart';

abstract class Routes {
  Routes._();

  static PageRoute goSplash() {
    return MaterialPageRoute(builder: (_) => const SplashPage());
  }

  static PageRoute goOnBoarding() {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (BuildContext context) => AppCubit(),
            child: const OnBoardingPage()));
  }

  static PageRoute goMain() {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (BuildContext context) => HomeCubit(),
            child: const MainPage()));
  }

  static PageRoute goAuth() {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (BuildContext context) => AuthCubit(),
            child: const AuthPage()));
  }
}
