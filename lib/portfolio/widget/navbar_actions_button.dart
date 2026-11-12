import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/provider/scroll_provider.dart';
import 'package:provider/provider.dart';

class NavBarActionButton extends StatefulWidget {
  final String label;
  final int index;
  const NavBarActionButton({
    Key? key,
    required this.label,
    required this.index,
  }) : super(key: key);

  @override
  State<NavBarActionButton> createState() => _NavBarActionButtonState();
}

class _NavBarActionButtonState extends State<NavBarActionButton> {
  bool isHovered = false;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isActive = context.select<ScrollProvider, bool>(
      (p) => p.activeIndex == widget.index,
    );
    final colors = context.colors;
    final typography = context.typography;
    final bool highlighted = isHovered || isActive;

    return EntranceFader(
      offset: const Offset(0, -10),
      delay: Duration(milliseconds: 60 + (widget.index * 35)),
      duration: const Duration(milliseconds: 360),
      curve: Curves.easeOutCubic,
      child: GestureDetector(
        onTapDown: (_) => setState(() => isPressed = true),
        onTapUp: (_) => setState(() => isPressed = false),
        onTapCancel: () => setState(() => isPressed = false),
        child: MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: InkWell(
            onTap: () => context.read<ScrollProvider>().scroll(widget.index),
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            child: AnimatedScale(
              scale: isPressed ? 0.94 : (isHovered ? 1.02 : 1.0),
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: highlighted
                    ? colors.primary.withValues(alpha: isActive ? 0.16 : 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                border: Border.all(
                  color: isActive
                      ? colors.primary.withValues(alpha: 0.45)
                      : Colors.transparent,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.label,
                    style: typography.monoBadge.copyWith(
                      fontSize: 11.5,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w700,
                      color: highlighted ? colors.primary : colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 2.2,
                    width: highlighted ? 20 : (isActive ? 18 : 0),
                    decoration: BoxDecoration(
                      gradient: AppGradients.brandHorizontal,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
}
