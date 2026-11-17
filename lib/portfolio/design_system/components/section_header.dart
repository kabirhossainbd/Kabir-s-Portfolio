import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/scroll_reveal.dart';
import 'package:portpolio/portfolio/design_system/app_colors.dart';
import 'package:portpolio/portfolio/design_system/app_spacing.dart';
import 'package:portpolio/portfolio/design_system/app_typography_tokens.dart';
import 'package:portpolio/portfolio/design_system/components/glow_elements.dart';

/// Reusable futuristic section header with optional mono eyebrow badge,
/// Sora gradient heading, glowing divider, and Inter subtitle.
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? eyebrow;
  final CrossAxisAlignment alignment;

  const SectionHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.eyebrow,
    this.alignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors =
        Theme.of(context).extension<AppColorTokens>() ?? AppColorTokens.dark;
    final typography = Theme.of(context).extension<AppTypographyTokens>() ??
        AppTypographyTokens.fromColors(colors);
    final textAlign = alignment == CrossAxisAlignment.center
        ? TextAlign.center
        : TextAlign.start;

    return ScrollReveal(
      offset: const Offset(0, 20),
      duration: const Duration(milliseconds: 480),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: alignment,
        children: [
          if (eyebrow != null && eyebrow!.isNotEmpty) ...[
            GlowBadge(label: eyebrow!),
            const SizedBox(height: AppSpacing.sm),
          ],
          GradientGlowText(
            title,
            textAlign: textAlign,
            gradient: AppGradients.brandHorizontal,
            style: typography.headingLarge.copyWith(
              letterSpacing: 1.6,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Container(
            width: 64,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
              gradient: AppGradients.brandHorizontal,
              boxShadow: [
                BoxShadow(
                  color: colors.primary.withValues(alpha: 0.45),
                  blurRadius: 12,
                ),
              ],
            ),
          ),
          if (subtitle != null && subtitle!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              subtitle!,
              textAlign: textAlign,
              style: typography.bodyLarge.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
