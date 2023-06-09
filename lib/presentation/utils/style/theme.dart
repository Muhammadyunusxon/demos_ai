import 'package:demos_ai/presentation/utils/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ThemeStyle {
  ThemeStyle._();

  static ThemeData? lightTheme = ThemeData(
    applyElevationOverlayColor: true,
    scaffoldBackgroundColor: Style.whiteColor,
    primaryColor: Style.whiteColor,
    cardColor: Style.greyscale300Color,
    hintColor: Style.whiteColor,
    hoverColor: Style.primaryColor.withOpacity(0.1),
    secondaryHeaderColor: Style.greyscale900Color,
    textTheme: TextTheme(
      displayLarge: Style.textStyleBold(textColor: Style.greyscale900Color),
      displayMedium:
          Style.textStyleSemiBold(textColor: Style.greyscale900Color),
      displaySmall: Style.textStyleNormal(textColor: Style.greyscale900Color),
      headlineMedium:
          Style.textStyleRegular(textColor: Style.greyscale900Color),
      titleMedium:
          Style.textStyleCustom(textColor: Style.greyColor, size: 16.sp),
    ),
    appBarTheme: const AppBarTheme(backgroundColor: Style.whiteColor),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Style.greyscale900Color,
      selectedLabelStyle:
          Style.textStyleSemiBold(textColor: Style.primaryColor, size: 15),
      unselectedLabelStyle:
          Style.textStyleSemiBold(textColor: Style.greyscale900Color, size: 14),
    ),
  );

  static ThemeData? darkTheme = ThemeData(
    scaffoldBackgroundColor: Style.dark1Color,
    primaryColor: Style.dark1Color,
    cardColor: Style.dark3Color,
    hintColor: Style.dark2Color,
    hoverColor: Style.dark3Color,
    secondaryHeaderColor: Style.whiteColor,
    appBarTheme: const AppBarTheme(backgroundColor: Style.dark1Color),
    textTheme: TextTheme(
      displayLarge: Style.textStyleBold(textColor: Style.whiteColor),
      displayMedium: Style.textStyleSemiBold(textColor: Style.whiteColor),
      displaySmall: Style.textStyleNormal(textColor: Style.whiteColor),
      headlineMedium: Style.textStyleRegular(textColor: Style.whiteColor),
      titleMedium:
          Style.textStyleCustom(textColor: Style.greyColor, size: 16.sp),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Style.whiteColor,
      selectedLabelStyle:
          Style.textStyleSemiBold(textColor: Style.primaryColor, size: 15),
      unselectedLabelStyle:
          Style.textStyleSemiBold(textColor: Style.whiteColor, size: 14),
    ),
  );
}
