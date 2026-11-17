import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';

const fontFamily = 'Inter';

final themeLight = ThemeData(
  useMaterial3: false,
  brightness: Brightness.light,
  primaryColor: AppColors.electricBlue,
  primaryColorLight: AppColors.cyanHighlight,
  highlightColor: AppColors.purpleAccent,
  canvasColor: AppColors.surfaceLight,
  fontFamily: fontFamily,
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: AppColors.backgroundLight,
  textTheme: AppTypographyTokens.buildMaterialTextTheme(AppColorTokens.light),
  colorScheme: const ColorScheme.light(
    primary: AppColors.electricBlue,
    secondary: AppColors.purpleAccent,
    surface: AppColors.surfaceLight,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: AppColors.textPrimaryLight,
  ),
  extensions: [
    AppColorTokens.light,
    AppTypographyTokens.fromColors(AppColorTokens.light),
  ],
);

final themeDark = ThemeData(
  useMaterial3: false,
  brightness: Brightness.dark,
  primaryColor: AppColors.electricBlue,
  primaryColorDark: AppColors.electricBlueSoft,
  highlightColor: AppColors.purpleAccent,
  canvasColor: AppColors.backgroundDark,
  fontFamily: fontFamily,
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: AppColors.backgroundDark,
  textTheme: AppTypographyTokens.buildMaterialTextTheme(AppColorTokens.dark),
  colorScheme: const ColorScheme.dark(
    primary: AppColors.electricBlue,
    secondary: AppColors.purpleAccent,
    surface: AppColors.surfaceDark,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: AppColors.textPrimaryDark,
  ),
  extensions: [
    AppColorTokens.dark,
    AppTypographyTokens.fromColors(AppColorTokens.dark),
  ],
);
