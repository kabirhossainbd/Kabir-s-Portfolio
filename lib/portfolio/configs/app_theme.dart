import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/design_system/app_colors.dart';

import 'app_core_theme.dart';

class AppTheme {
  static final _core = AppCoreTheme(
    shadowSub: AppColors.electricBlue.withValues(alpha: 0.22),
    primary: AppColors.electricBlue,
    primaryLight: AppColors.cyanHighlight,
    textSub: AppColors.textSecondaryDark,
    textSub2: AppColors.textMutedDark,
  );

  static AppCoreTheme light = _core.copyWith(
    background: AppColors.surfaceLight,
    backgroundSub: AppColors.surfaceElevatedLight,
    scaffold: AppColors.backgroundLight,
    scaffoldDark: const Color(0xFFE2E8F0),
    text: AppColors.textPrimaryLight,
    textSub2: AppColors.textSecondaryLight,
  );

  static AppCoreTheme dark = _core.copyWith(
    primary: AppColors.electricBlue,
    background: AppColors.surfaceDark,
    backgroundSub: AppColors.backgroundDark,
    scaffold: AppColors.backgroundDark,
    text: AppColors.textPrimaryDark,
    textSub2: AppColors.textSecondaryDark,
  );

  static AppCoreTheme? c;

  // Init
  static init(BuildContext context) {
    c = isDark(context) ? dark : light;
  }

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}

