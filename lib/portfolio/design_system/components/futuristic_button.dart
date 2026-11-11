import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/design_system/app_colors.dart';
import 'package:portpolio/portfolio/design_system/app_spacing.dart';
import 'package:portpolio/portfolio/design_system/app_typography_tokens.dart';

enum FuturisticButtonVariant { primary, outlined, ghost }

/// Reusable futuristic action button with gradient glow, outlined glass,
/// or subtle ghost styles and smooth hover lift.
class FuturisticButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final FuturisticButtonVariant variant;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const FuturisticButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = FuturisticButtonVariant.primary,
    this.padding,
    this.borderRadius = AppSpacing.radiusXl,
  }) : super(key: key);

  @override
  State<FuturisticButton> createState() => _FuturisticButtonState();
}

class _FuturisticButtonState extends State<FuturisticButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorTokens>() ?? AppColorTokens.dark;
    final typography = Theme.of(context).extension<AppTypographyTokens>() ??
        AppTypographyTokens.fromColors(colors);

    final radius = BorderRadius.circular(widget.borderRadius);
    final effectivePadding = widget.padding ??
        const EdgeInsets.symmetric(horizontal: 22, vertical: 14);

    final bool isPrimary = widget.variant == FuturisticButtonVariant.primary;
    final bool isOutlined = widget.variant == FuturisticButtonVariant.outlined;

    final Color fgColor = isPrimary ? Colors.white : colors.textPrimary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _isHovered ? -2.0 : 0.0, 0),
        decoration: BoxDecoration(
          borderRadius: radius,
          gradient: isPrimary ? AppGradients.brandHorizontal : null,
          color: isPrimary
              ? null
              : isOutlined
                  ? (_isHovered
                      ? colors.primary.withValues(alpha: 0.14)
                      : colors.surface.withValues(alpha: 0.55))
                  : (_isHovered
                      ? colors.primary.withValues(alpha: 0.12)
                      : Colors.transparent),
          border: isOutlined
              ? Border.all(
                  color: _isHovered
                      ? colors.accent
                      : colors.primary.withValues(alpha: 0.75),
                  width: 1.4,
                )
              : null,
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: colors.primary.withValues(alpha: _isHovered ? 0.48 : 0.3),
                    blurRadius: _isHovered ? 22 : 14,
                    offset: const Offset(0, 4),
                  ),
                ]
              : _isHovered && isOutlined
                  ? [
                      BoxShadow(
                        color: colors.glowPrimary,
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: radius,
            child: Padding(
              padding: effectivePadding,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, size: 17, color: fgColor),
                    const SizedBox(width: AppSpacing.xs),
                  ],
                  Text(
                    widget.label,
                    style: typography.labelButton.copyWith(color: fgColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

