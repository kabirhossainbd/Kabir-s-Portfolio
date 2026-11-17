import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/design_system/app_colors.dart';

/// Font family constants for the futuristic design system.
abstract final class AppFontFamilies {
  static const String display = 'Sora';
  static const String body = 'Inter';
  static const String mono = 'JetBrains Mono';
}

/// Typography tokens combining Sora (display/headings), Inter (body/UI),
/// and JetBrains Mono (badges, tech pills, metrics, and code labels).
@immutable
class AppTypographyTokens extends ThemeExtension<AppTypographyTokens> {
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle headingLarge;
  final TextStyle headingMedium;
  final TextStyle titleMedium;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelButton;
  final TextStyle monoBadge;
  final TextStyle monoMetric;

  const AppTypographyTokens({
    required this.displayLarge,
    required this.displayMedium,
    required this.headingLarge,
    required this.headingMedium,
    required this.titleMedium,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelButton,
    required this.monoBadge,
    required this.monoMetric,
  });

  static TextStyle _sora({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: AppFontFamilies.display,
      fontFamilyFallback: const [AppFontFamilies.body, 'sans-serif'],
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle _inter({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: AppFontFamilies.body,
      fontFamilyFallback: const ['system-ui', 'sans-serif'],
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle _mono({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: AppFontFamilies.mono,
      fontFamilyFallback: const ['monospace'],
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  factory AppTypographyTokens.fromColors(AppColorTokens colors) {
    return AppTypographyTokens(
      displayLarge: _sora(
        fontSize: 44,
        fontWeight: FontWeight.w800,
        color: colors.textPrimary,
        height: 1.15,
        letterSpacing: -0.8,
      ),
      displayMedium: _sora(
        fontSize: 34,
        fontWeight: FontWeight.w800,
        color: colors.textPrimary,
        height: 1.2,
        letterSpacing: -0.5,
      ),
      headingLarge: _sora(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
        height: 1.25,
        letterSpacing: 0.4,
      ),
      headingMedium: _sora(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
        height: 1.3,
      ),
      titleMedium: _sora(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
        height: 1.35,
      ),
      bodyLarge: _inter(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: colors.textSecondary,
        height: 1.6,
      ),
      bodyMedium: _inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: colors.textSecondary,
        height: 1.55,
      ),
      bodySmall: _inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: colors.textMuted,
        height: 1.45,
      ),
      labelButton: _inter(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
        letterSpacing: 0.3,
      ),
      monoBadge: _mono(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: colors.primary,
        letterSpacing: 1.4,
      ),
      monoMetric: _mono(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
      ),
    );
  }

  static TextTheme buildMaterialTextTheme(AppColorTokens colors) {
    final t = AppTypographyTokens.fromColors(colors);
    return TextTheme(
      displayLarge: t.displayLarge,
      displayMedium: t.displayMedium,
      headlineLarge: t.headingLarge,
      headlineMedium: t.headingMedium,
      titleLarge: t.headingMedium,
      titleMedium: t.titleMedium,
      bodyLarge: t.bodyLarge,
      bodyMedium: t.bodyMedium,
      bodySmall: t.bodySmall,
      labelLarge: t.labelButton,
      labelSmall: t.monoBadge,
    );
  }

  @override
  AppTypographyTokens copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? headingLarge,
    TextStyle? headingMedium,
    TextStyle? titleMedium,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelButton,
    TextStyle? monoBadge,
    TextStyle? monoMetric,
  }) {
    return AppTypographyTokens(
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      headingLarge: headingLarge ?? this.headingLarge,
      headingMedium: headingMedium ?? this.headingMedium,
      titleMedium: titleMedium ?? this.titleMedium,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      labelButton: labelButton ?? this.labelButton,
      monoBadge: monoBadge ?? this.monoBadge,
      monoMetric: monoMetric ?? this.monoMetric,
    );
  }

  @override
  AppTypographyTokens lerp(
      ThemeExtension<AppTypographyTokens>? other, double t) {
    if (other is! AppTypographyTokens) return this;
    return AppTypographyTokens(
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t)!,
      headingLarge: TextStyle.lerp(headingLarge, other.headingLarge, t)!,
      headingMedium: TextStyle.lerp(headingMedium, other.headingMedium, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      labelButton: TextStyle.lerp(labelButton, other.labelButton, t)!,
      monoBadge: TextStyle.lerp(monoBadge, other.monoBadge, t)!,
      monoMetric: TextStyle.lerp(monoMetric, other.monoMetric, t)!,
    );
  }
}
