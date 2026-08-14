import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final List<BoxShadow>? boxShadow;
  final Gradient? borderGradient;

  const GlassContainer({
    Key? key,
    required this.child,
    this.blur = 0.0,
    this.opacity = 0.1,
    this.borderRadius,
    this.borderColor,
    this.color,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.boxShadow,
    this.borderGradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultRadius = borderRadius ?? BorderRadius.circular(24);
    final defaultColor = color ??
        (isDark
            ? const Color(0xFF111827).withValues(alpha: 0.85)
            : Colors.white.withValues(alpha: 0.85));
    final defaultBorderColor = borderColor ??
        (isDark
            ? Colors.white.withValues(alpha: 0.15)
            : const Color(0xFF0066FF).withValues(alpha: 0.15));

    if (borderGradient != null) {
      const borderWidth = 1.5;
      final outerRadius = defaultRadius;
      final innerRadius = BorderRadius.circular(
        (defaultRadius.resolve(TextDirection.ltr).topLeft.x - borderWidth)
            .clamp(0.0, 100.0),
      );

      return Container(
        width: width,
        height: height,
        margin: margin,
        padding: const EdgeInsets.all(borderWidth),
        decoration: BoxDecoration(
          borderRadius: outerRadius,
          gradient: borderGradient,
          boxShadow: boxShadow ??
              [
                BoxShadow(
                  color: isDark
                      ? const Color(0xFF00D2FF).withValues(alpha: 0.15)
                      : const Color(0xFF0066FF).withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
        ),
        child: ClipRRect(
          borderRadius: innerRadius,
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: defaultColor,
              borderRadius: innerRadius,
            ),
            child: child,
          ),
        ),
      );
    }

    final innerContainer = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: defaultColor,
        borderRadius: defaultRadius,
        border: Border.all(
          color: defaultBorderColor,
          width: 1.0,
        ),
      ),
      child: child,
    );

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: defaultRadius,
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: isDark
                    ? const Color(0xFF00D2FF).withValues(alpha: 0.1)
                    : const Color(0xFF0066FF).withValues(alpha: 0.06),
                blurRadius: 20,
                spreadRadius: 0,
                offset: const Offset(0, 6),
              ),
            ],
      ),
      child: ClipRRect(
        borderRadius: defaultRadius,
        child: blur > 0
            ? BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                child: innerContainer,
              )
            : innerContainer,
      ),
    );
  }
}



