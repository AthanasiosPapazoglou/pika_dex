import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

ScrollbarThemeData _scrollbarThemeData = ScrollbarThemeData(
  // thickness: MaterialStateProperty.all(10),
  // thumbColor: MaterialStateProperty.all(Colors.blue),
  radius: const Radius.circular(10),
  // minThumbLength: 100,
);

class AppThemes {
  AppThemes._();

  static final ThemeData lightTheme = FlexThemeData.light(
    colors: const FlexSchemeColor(
      primary: AppColors.kPrimaryColor,
      primaryContainer: AppColors.darkGray,
      secondary: Color(0xff1FA2C1),
      secondaryContainer: Color.fromARGB(255, 178, 207, 214),
      tertiary: Color(0xff006875),
      tertiaryContainer: Color(0xff95f0ff),
      appBarColor: Color(0xffffdbcf),
      error: AppColors.red,
    ),
    surface: AppColors.white,
    onSurface: AppColors.darkGray,
    scaffoldBackground: AppColors.background,
    surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
    blendLevel: 24,
    appBarOpacity: 0.95,

    onPrimary: AppColors.white,
    fontFamily: 'ProductSans',
    tooltipsMatchBackground: true,
    subThemesData: const FlexSubThemesData(
      outlinedButtonSchemeColor: SchemeColor.primary,
      outlinedButtonOutlineSchemeColor: SchemeColor.primary,
      cardElevation: 1,
      cardRadius: 40,
      fabUseShape: true,
      blendOnLevel: 6,
      useTextTheme: true,
      blendTextTheme: false,
      buttonPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      blendOnColors: false,
      defaultRadius: 6.0,
      toggleButtonsRadius: 25.0,
      inputDecoratorUnfocusedHasBorder: false,
      fabRadius: 35.0,
      snackBarBackgroundSchemeColor: SchemeColor.onError,
      chipRadius: 26.0,
      dialogRadius: 18,
      popupMenuRadius: 12.0,
      elevatedButtonRadius: 40,
      outlinedButtonRadius: 40,
      inputDecoratorRadius: 40.0,
      dialogBackgroundSchemeColor: SchemeColor.onInverseSurface,
      navigationRailOpacity: 0.73,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    // To use the playground font, add GoogleFonts package and uncomment
    // fontFamily: GoogleFonts.notoSans().fontFamily,
  ).copyWith(scrollbarTheme: _scrollbarThemeData);

  static final ThemeData darkTheme = FlexThemeData.dark(
    /* colors: FlexSchemeColor(
      primary: AppColors.kPrimaryColor,
      primaryContainer: AppColors.darkGray,
      secondary: Color(0xff1FA2C1),
      secondaryContainer: Color.fromARGB(255, 178, 207, 214),
      tertiary: Color(0xff006875),
      tertiaryContainer: Color(0xff95f0ff),
      appBarColor: Color(0xffffdbcf),
      error: AppColors.red,
    ), */
    colors: FlexSchemeColor.from(primary: AppColors.kPrimaryColor),
    scheme: FlexScheme.aquaBlue,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 30,
    appBarStyle: FlexAppBarStyle.surface,
    appBarOpacity: 0.90,
    onPrimary: AppColors.white,
    fontFamily: 'ProductSans',
    tooltipsMatchBackground: true,
    subThemesData: const FlexSubThemesData(
      outlinedButtonSchemeColor: SchemeColor.primary,
      outlinedButtonOutlineSchemeColor: SchemeColor.primary,
      fabUseShape: true,
      cardElevation: 4,
      cardRadius: 40,
      blendOnLevel: 20,
      blendOnColors: false,
      useTextTheme: true,
      blendTextTheme: false,
      buttonPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      defaultRadius: 8.0,
      toggleButtonsRadius: 25.0,
      inputDecoratorUnfocusedHasBorder: false,
      fabRadius: 35.0,
      snackBarBackgroundSchemeColor: SchemeColor.onError,
      chipRadius: 26.0,
      dialogRadius: 18,
      popupMenuRadius: 12.0,
      elevatedButtonRadius: 40,
      outlinedButtonRadius: 40,
      inputDecoratorRadius: 40.0,
      navigationRailOpacity: 0.73,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    // To use the playground font, add GoogleFonts package and uncomment
    // fontFamily: GoogleFonts.notoSans().fontFamily,
  ).copyWith(scrollbarTheme: _scrollbarThemeData);
}
