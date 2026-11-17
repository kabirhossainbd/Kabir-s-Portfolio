import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';
import 'package:portpolio/portfolio/provider/scroll_provider.dart';
import 'package:provider/provider.dart';

class NavBarActionButton extends StatefulWidget {
  final String label;
  final int index;
  final bool compact;

  const NavBarActionButton({
    Key? key,
    required this.label,
    required this.index,
    this.compact = false,
  }) : super(key: key);

  @override
  State<NavBarActionButton> createState() => _NavBarActionButtonState();
}

class _NavBarActionButtonState extends State<NavBarActionButton> {
  bool isHovered = false;

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
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: InkWell(
          onTap: () => context.read<ScrollProvider>().scroll(widget.index),
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.symmetric(
              horizontal: widget.compact ? 9 : 13,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: isActive
                  ? colors.primary.withValues(alpha: 0.12)
                  : isHovered
                      ? colors.primary.withValues(alpha: 0.07)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label,
                  style: typography.monoBadge.copyWith(
                    fontSize: widget.compact ? 11 : 11.5,
                    letterSpacing: widget.compact ? 0.6 : 1.0,
                    fontWeight: FontWeight.w700,
                    color: highlighted ? colors.primary : colors.textSecondary,
                  ),
                ),
                const SizedBox(height: 3),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  height: 2,
                  width: isActive ? 18 : (isHovered ? 10 : 0),
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
    );
  }
}
