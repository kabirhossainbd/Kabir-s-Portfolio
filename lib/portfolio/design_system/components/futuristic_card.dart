import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/design_system/app_colors.dart';
import 'package:portpolio/portfolio/design_system/app_spacing.dart';

/// Reusable futuristic glass card with optional gradient rim, hover lift,
/// and a soft cursor-following spotlight.
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
  Alignment? _spotlight;

  void _updateSpotlight(Offset localPosition) {
    final size = context.size;
    if (size == null || size.isEmpty) return;
    setState(() {
      _spotlight = Alignment(
        (localPosition.dx / size.width) * 2 - 1,
        (localPosition.dy / size.height) * 2 - 1,
      );
    });
  }

  void _setPressed(bool value) {
    if (widget.onTap == null || _isPressed == value) return;
    setState(() => _isPressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final colors =
        Theme.of(context).extension<AppColorTokens>() ?? AppColorTokens.dark;
    final radius =
        widget.borderRadius ?? BorderRadius.circular(AppSpacing.radiusLg);
    final hovered = widget.enableHoverGlow && _isHovered;

    // Opaque fill: a translucent one would let the gradient rim bleed through.
    final baseColor = Color.alphaBlend(
      colors.surface.withValues(alpha: hovered ? 0.96 : 0.86),
      colors.background,
    );

    Widget buildSurface(BorderRadius bgRadius) {
      final surface = AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: bgRadius,
          border: widget.useGradientBorder
              ? null
              : Border.all(
                  color: hovered
                      ? colors.primary.withValues(alpha: 0.55)
                      : colors.border,
                ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: bgRadius,
            gradient: hovered && _spotlight != null
                ? RadialGradient(
                    center: _spotlight!,
                    radius: 1.1,
                    colors: [
                      colors.primary.withValues(alpha: 0.10),
                      colors.accent.withValues(alpha: 0.03),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.45, 1.0],
                  )
                : null,
          ),
          child: Padding(
            padding: widget.padding ?? const EdgeInsets.all(AppSpacing.lg),
            child: widget.child,
          ),
        ),
      );

      return ClipRRect(
        borderRadius: bgRadius,
        child: widget.blur > 0
            ? BackdropFilter(
                filter:
                    ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
                child: surface,
              )
            : surface,
      );
    }

    Widget cardBody;
    if (widget.useGradientBorder) {
      const borderStroke = 1.2;
      final resolvedTopLeft = radius.resolve(TextDirection.ltr).topLeft.x;
      final innerRadius = BorderRadius.circular(
        (resolvedTopLeft - borderStroke).clamp(0.0, 100.0),
      );
      cardBody = Container(
        padding: const EdgeInsets.all(borderStroke),
        decoration: BoxDecoration(
          borderRadius: radius,
          gradient: AppGradients.glassBorder(isHovered: hovered),
        ),
        child: buildSurface(innerRadius),
      );
    } else {
      cardBody = buildSurface(radius);
    }

    if (widget.onTap != null) {
      cardBody = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: radius,
          child: cardBody,
        ),
      );
    }

    return MouseRegion(
      onEnter: (e) {
        setState(() => _isHovered = true);
        _updateSpotlight(e.localPosition);
      },
      onHover: (e) => _updateSpotlight(e.localPosition),
      onExit: (_) => setState(() {
        _isHovered = false;
        _isPressed = false;
      }),
      child: Listener(
        onPointerDown: (_) => _setPressed(true),
        onPointerUp: (_) => _setPressed(false),
        onPointerCancel: (_) => _setPressed(false),
        child: AnimatedScale(
          scale: _isPressed ? 0.985 : 1.0,
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            width: widget.width,
            height: widget.height,
            margin: widget.margin,
            transform:
                Matrix4.translationValues(0.0, hovered ? -3.0 : 0.0, 0.0),
            decoration: BoxDecoration(
              borderRadius: radius,
              boxShadow: [
                BoxShadow(
                  color: hovered
                      ? colors.glowPrimary
                      : Colors.black.withValues(
                          alpha: Theme.of(context).brightness == Brightness.dark
                              ? 0.18
                              : 0.06,
                        ),
                  blurRadius: hovered ? 26 : 14,
                  offset: Offset(0, hovered ? 10 : 4),
                ),
              ],
            ),
            child: cardBody,
          ),
        ),
      ),
    );
  }
}
