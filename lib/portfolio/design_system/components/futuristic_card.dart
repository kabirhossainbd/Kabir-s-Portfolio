import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/design_system/app_colors.dart';
import 'package:portpolio/portfolio/design_system/app_spacing.dart';

/// Reusable futuristic glass card with optional gradient rim, hover lift,
/// and electric-blue / purple ambient glow.
class FuturisticGlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final double blur;
  final bool enableHoverGlow;
  final bool useGradientBorder;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const FuturisticGlassCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.blur = 0.0,
    this.enableHoverGlow = true,
    this.useGradientBorder = true,
    this.onTap,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<FuturisticGlassCard> createState() => _FuturisticGlassCardState();
}

class _FuturisticGlassCardState extends State<FuturisticGlassCard> {
  bool _isHovered = false;
  bool _isPressed = false;
  Offset _cursorPos = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorTokens>() ?? AppColorTokens.dark;
    final radius = widget.borderRadius ?? BorderRadius.circular(AppSpacing.radiusLg);
    final hovered = widget.enableHoverGlow && _isHovered;

    Widget buildBackgroundDecoration({required BorderRadius bgRadius}) {
      return Container(
        padding: widget.padding ?? const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: colors.surface.withValues(alpha: hovered ? 0.93 : 0.84),
          borderRadius: bgRadius,
          border: widget.useGradientBorder
              ? null
              : Border.all(
                  color: hovered ? colors.primary.withValues(alpha: 0.55) : colors.border,
                  width: 1.0,
                ),
          gradient: hovered && _cursorPos != Offset.zero
              ? RadialGradient(
                  center: Alignment(
                    ((_cursorPos.dx / (widget.width ?? 300)) - 0.5) * 2.0,
                    ((_cursorPos.dy / (widget.height ?? 240)) - 0.5) * 2.0,
                  ),
                  radius: 0.9,
                  colors: [
                    colors.primary.withValues(alpha: 0.16),
                    colors.accent.withValues(alpha: 0.05),
                    colors.surface.withValues(alpha: 0.93),
                  ],
                  stops: const [0.0, 0.45, 1.0],
                )
              : null,
        ),
        child: widget.child,
      );
    }

    Widget cardBody = ClipRRect(
      borderRadius: radius,
      child: widget.blur > 0
          ? BackdropFilter(
              filter: ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
              child: buildBackgroundDecoration(bgRadius: radius),
            )
          : buildBackgroundDecoration(bgRadius: radius),
    );

    if (widget.useGradientBorder) {
      const borderStroke = 1.3;
      final outerRadius = radius;
      final resolvedTopLeft = radius.resolve(TextDirection.ltr).topLeft.x;
      final innerRadius = BorderRadius.circular(
        (resolvedTopLeft - borderStroke).clamp(0.0, 100.0),
      );

      cardBody = Container(
        padding: const EdgeInsets.all(borderStroke),
        decoration: BoxDecoration(
          borderRadius: outerRadius,
          gradient: AppGradients.glassBorder(isHovered: hovered),
        ),
        child: ClipRRect(
          borderRadius: innerRadius,
          child: widget.blur > 0
              ? BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
                  child: buildBackgroundDecoration(bgRadius: innerRadius),
                )
              : buildBackgroundDecoration(bgRadius: innerRadius),
        ),
      );
    }

    final double scale = _isPressed
        ? 0.97
        : hovered
            ? 1.01
            : 1.0;

    final animatedContainer = AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        width: widget.width,
        height: widget.height,
        margin: widget.margin,
        transform: Matrix4.translationValues(0.0, hovered ? -4.0 : 0.0, 0.0),
        decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: hovered ? colors.glowPrimary : Colors.black.withValues(alpha: 0.20),
            blurRadius: hovered ? 28 : 14,
            offset: Offset(0, hovered ? 8 : 4),
          ),
          if (hovered)
            BoxShadow(
              color: colors.glowAccent,
              blurRadius: 22,
              offset: const Offset(4, 4),
            ),
        ],
      ),
      child: widget.onTap != null
          ? Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onTap,
                borderRadius: radius,
                child: cardBody,
              ),
            )
          : cardBody,
      ),
    );

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: MouseRegion(
        onEnter: (e) => setState(() {
          _isHovered = true;
          _cursorPos = e.localPosition;
        }),
        onHover: (e) => setState(() => _cursorPos = e.localPosition),
        onExit: (_) => setState(() => _isHovered = false),
        child: animatedContainer,
      ),
    );
  }
}

