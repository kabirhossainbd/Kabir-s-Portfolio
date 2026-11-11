import 'package:flutter/material.dart';

/// Core color tokens for the futuristic portfolio design system.
abstract final class AppColors {
  // Primary dark surfaces
  static const Color backgroundDark = Color(0xFF080D19);
  static const Color surfaceDark = Color(0xFF0E1629);
  static const Color surfaceElevatedDark = Color(0xFF131D35);
  static const Color surfaceGlassDark = Color(0xCC0E1629);

  // Light surfaces (when user explicitly toggles light theme)
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceElevatedLight = Color(0xFFF1F5F9);
  static const Color surfaceGlassLight = Color(0xE6FFFFFF);

  // Brand accents
  static const Color electricBlue = Color(0xFF1677FF);
  static const Color electricBlueSoft = Color(0xFF4D9AFF);
  static const Color cyanHighlight = Color(0xFF38BDF8);
  static const Color purpleAccent = Color(0xFF9B72FF);
  static const Color purpleDeep = Color(0xFF7C4DFF);

  // Semantic accents
  static const Color successEmerald = Color(0xFF10B981);
  static const Color warningAmber = Color(0xFFF59E0B);
  static const Color errorRose = Color(0xFFF43F5E);

  // Text tokens
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textMutedDark = Color(0xFF64748B);

  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF475569);
  static const Color textMutedLight = Color(0xFF64748B);

  // Borders
  static const Color borderDark = Color(0x1FFFFFFF);
  static const Color borderBlueDark = Color(0x4D1677FF);
  static const Color borderPurpleDark = Color(0x4D9B72FF);
  static const Color borderLight = Color(0x1F1677FF);
}

/// Reusable gradients for surfaces, borders, text, and ambient glows.
abstract final class AppGradients {
  static const LinearGradient brandPrimary = LinearGradient(
    colors: [AppColors.electricBlue, AppColors.purpleAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient brandHorizontal = LinearGradient(
    colors: [AppColors.electricBlue, AppColors.purpleAccent],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient brandTriTone = LinearGradient(
    colors: [
      AppColors.electricBlue,
      AppColors.cyanHighlight,
      AppColors.purpleAccent,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient glassBorder({bool isHovered = false}) {
    return LinearGradient(
      colors: isHovered
          ? [AppColors.electricBlue, AppColors.purpleAccent]
          : [
              AppColors.electricBlue.withValues(alpha: 0.35),
              AppColors.purpleAccent.withValues(alpha: 0.25),
            ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}

/// Theme-aware color tokens attached to [ThemeData.extensions].
@immutable
class AppColorTokens extends ThemeExtension<AppColorTokens> {
  final Color background;
  final Color surface;
  final Color surfaceElevated;
  final Color primary;
  final Color accent;
  final Color cyan;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color border;
  final Color borderAccent;
  final Color glowPrimary;
  final Color glowAccent;

  const AppColorTokens({
    required this.background,
    required this.surface,
    required this.surfaceElevated,
    required this.primary,
    required this.accent,
    required this.cyan,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.border,
    required this.borderAccent,
    required this.glowPrimary,
    required this.glowAccent,
  });

  static const AppColorTokens dark = AppColorTokens(
    background: AppColors.backgroundDark,
    surface: AppColors.surfaceDark,
    surfaceElevated: AppColors.surfaceElevatedDark,
    primary: AppColors.electricBlue,
    accent: AppColors.purpleAccent,
    cyan: AppColors.cyanHighlight,
    textPrimary: AppColors.textPrimaryDark,
    textSecondary: AppColors.textSecondaryDark,
    textMuted: AppColors.textMutedDark,
    border: AppColors.borderDark,
    borderAccent: AppColors.borderBlueDark,
    glowPrimary: Color(0x4D1677FF),
    glowAccent: Color(0x409B72FF),
  );

  static const AppColorTokens light = AppColorTokens(
    background: AppColors.backgroundLight,
    surface: AppColors.surfaceLight,
    surfaceElevated: AppColors.surfaceElevatedLight,
    primary: AppColors.electricBlue,
    accent: AppColors.purpleAccent,
    cyan: AppColors.cyanHighlight,
    textPrimary: AppColors.textPrimaryLight,
    textSecondary: AppColors.textSecondaryLight,
    textMuted: AppColors.textMutedLight,
    border: AppColors.borderLight,
    borderAccent: AppColors.borderBlueDark,
    glowPrimary: Color(0x331677FF),
    glowAccent: Color(0x2B9B72FF),
  );

  @override
  AppColorTokens copyWith({
    Color? background,
    Color? surface,
    Color? surfaceElevated,
    Color? primary,
    Color? accent,
    Color? cyan,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? border,
    Color? borderAccent,
    Color? glowPrimary,
    Color? glowAccent,
  }) {
    return AppColorTokens(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      primary: primary ?? this.primary,
      accent: accent ?? this.accent,
      cyan: cyan ?? this.cyan,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      border: border ?? this.border,
      borderAccent: borderAccent ?? this.borderAccent,
      glowPrimary: glowPrimary ?? this.glowPrimary,
      glowAccent: glowAccent ?? this.glowAccent,
    );
  }

  @override
  AppColorTokens lerp(ThemeExtension<AppColorTokens>? other, double t) {
    if (other is! AppColorTokens) return this;
    return AppColorTokens(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      cyan: Color.lerp(cyan, other.cyan, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderAccent: Color.lerp(borderAccent, other.borderAccent, t)!,
      glowPrimary: Color.lerp(glowPrimary, other.glowPrimary, t)!,
      glowAccent: Color.lerp(glowAccent, other.glowAccent, t)!,
    );
  }
}

