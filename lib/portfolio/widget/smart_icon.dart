import 'package:flutter/material.dart';

class SmartIcon extends StatefulWidget {
  final IconData? iconData;
  final String? riveAsset;
  final double size;
  final Color? iconColor;
  final List<Color>? gradientColors;
  final bool isAnimated;
  final VoidCallback? onTap;

  const SmartIcon({
    Key? key,
    this.iconData,
    this.riveAsset,
    this.size = 24.0,
    this.iconColor,
    this.gradientColors,
    this.isAnimated = true,
    this.onTap,
  }) : super(key: key);

  @override
  State<SmartIcon> createState() => _SmartIconState();
}

class _SmartIconState extends State<SmartIcon> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = widget.iconColor ??
        (isDark ? const Color(0xFF00D2FF) : const Color(0xFF0066FF));

    final defaultGradient = widget.gradientColors ??
        (isDark
            ? [const Color(0xFF00D2FF).withValues(alpha: 0.25), const Color(0xFFA855F7).withValues(alpha: 0.25)]
            : [const Color(0xFF0066FF).withValues(alpha: 0.15), const Color(0xFF8B5CF6).withValues(alpha: 0.15)]);

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: isHovered ? 1.12 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(widget.size * 0.45),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isHovered
                    ? [
                        defaultGradient.first.withValues(alpha: 0.4),
                        defaultGradient.last.withValues(alpha: 0.4),
                      ]
                    : defaultGradient,
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: isHovered
                    ? primaryColor.withValues(alpha: 0.6)
                    : primaryColor.withValues(alpha: 0.2),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: isHovered
                      ? primaryColor.withValues(alpha: 0.4)
                      : primaryColor.withValues(alpha: 0.12),
                  blurRadius: isHovered ? 16 : 8,
                  spreadRadius: isHovered ? 2 : 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              widget.iconData ?? Icons.code_rounded,
              size: widget.size,
              color: primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

