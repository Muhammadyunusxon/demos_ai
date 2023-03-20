import 'package:demos_ai/application/chat_cubit/chat_cubit.dart';
import 'package:demos_ai/presentation/pages/auth/auth_page.dart';
import 'package:demos_ai/presentation/pages/chat/chat_page.dart';
import 'package:demos_ai/presentation/pages/home/home_page.dart';
import 'package:demos_ai/presentation/pages/initial/onboarding_page.dart';
import 'package:demos_ai/presentation/pages/initial/splash.dart';
import 'package:demos_ai/presentation/pages/maps/maps_page.dart';
import 'package:demos_ai/presentation/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/app_cubit/app_cubit.dart';
import '../application/auth_cubit/auth_cubit.dart';
import '../application/home_cubit/home_cubit.dart';
import '../application/maps_cubit/maps_cubit.dart';

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

  static PageRoute goHome() {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (BuildContext context) => HomeCubit()..getUserInfo(),
            child: const HomePage()));
  }

  static PageRoute goProfile(BuildContext context) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
            value: BlocProvider.of<HomeCubit>(context),
            child: const ProfilePage()));
  }

  static PageRoute goAuth() {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (BuildContext context) => AuthCubit(),
            child: const AuthPage()));
  }

  static PageRoute goMaps({required VoidCallback onExit,required bool theme}) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (BuildContext context) => MapsCubit(),
            child:  MapsPage(onExit: onExit,theme: theme,)));
  }

  static PageRoute goChat({required VoidCallback onExit}) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (BuildContext context) => ChatCubit()..getLimit(),
            child: ChatPage(onExit: onExit,)));
  }
}
