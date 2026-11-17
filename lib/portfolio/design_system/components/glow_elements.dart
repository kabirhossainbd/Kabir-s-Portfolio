import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/design_system/app_colors.dart';
import 'package:portpolio/portfolio/design_system/app_typography_tokens.dart';

/// Displays text masked with a sleek electric-blue to purple gradient.
class GradientGlowText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;
  final TextAlign? textAlign;

  const GradientGlowText(
    this.text, {
    Key? key,
    required this.style,
    this.gradient = AppGradients.brandHorizontal,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: Text(
        text,
        textAlign: textAlign,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}

/// Reusable JetBrains Mono eyebrow pill with subtle border glow.
class GlowBadge extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? accentColor;

  const GlowBadge({
    Key? key,
    required this.label,
    this.icon,
    this.accentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors =
        Theme.of(context).extension<AppColorTokens>() ?? AppColorTokens.dark;
    final typography = Theme.of(context).extension<AppTypographyTokens>() ??
        AppTypographyTokens.fromColors(colors);
    final tone = accentColor ?? colors.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: tone.withValues(alpha: 0.30),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: tone.withValues(alpha: 0.12),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: tone),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: typography.monoBadge.copyWith(color: tone),
          ),
        ],
      ),
    );
  }
}

/// GPU-friendly radial glow orb for atmospheric futuristic depth.
class AmbientGlowOrb extends StatelessWidget {
  final double size;
  final Color color;
  final double intensity;

  const AmbientGlowOrb({
    Key? key,
    required this.size,
    required this.color,
    this.intensity = 0.22,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: intensity),
              color.withValues(alpha: intensity * 0.25),
              Colors.transparent,
            ],
            stops: const [0.0, 0.45, 1.0],
          ),
        ),
      ),
    );
  }
}
