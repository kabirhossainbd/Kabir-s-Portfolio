import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/design_system/app_colors.dart';
import 'package:portpolio/portfolio/design_system/app_typography_tokens.dart';

export 'app_colors.dart';
export 'app_spacing.dart';
export 'app_typography_tokens.dart';
export 'components/futuristic_button.dart';
export 'components/futuristic_card.dart';
export 'components/glow_elements.dart';
export 'components/portfolio_section.dart';
export 'components/responsive_grid.dart';
export 'components/section_header.dart';

/// Convenient accessors for the active theme's futuristic design tokens.
extension DesignSystemContext on BuildContext {
  AppColorTokens get colors =>
      Theme.of(this).extension<AppColorTokens>() ?? AppColorTokens.dark;

  AppTypographyTokens get typography =>
      Theme.of(this).extension<AppTypographyTokens>() ??
      AppTypographyTokens.fromColors(colors);
}
