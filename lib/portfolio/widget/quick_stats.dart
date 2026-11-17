import 'package:flutter/material.dart';
import 'package:portpolio/portfolio/animations/entrance_fader.dart';
import 'package:portpolio/portfolio/design_system/design_system.dart';

class QuickStats extends StatelessWidget {
  const QuickStats({Key? key}) : super(key: key);

  static const _stats = [
    ('5+', 'Years Experience'),
    ('20+', 'Projects Delivered'),
    ('15k+', 'App Downloads'),
    ('3', 'Countries Served'),
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveGrid(
      spacing: 10,
      runSpacing: 10,
      columnsForWidth: (width) => width >= 500 ? 4 : 2,
      children: [
        for (int i = 0; i < _stats.length; i++)
          EntranceFader(
            offset: const Offset(0, 18),
            delay: Duration(milliseconds: 340 + (i * 55)),
            duration: const Duration(milliseconds: 450),
            beginScale: 0.96,
            child: _StatCard(value: _stats[i].$1, label: _stats[i].$2),
          ),
      ],
    );
  }
}

class _StatCard extends StatefulWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, isHovered ? -3 : 0, 0),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isHovered
              ? colors.surfaceElevated.withValues(alpha: isDark ? 0.94 : 1.0)
              : colors.surface.withValues(alpha: isDark ? 0.84 : 0.94),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHovered
                ? colors.primary.withValues(alpha: 0.8)
                : colors.primary.withValues(alpha: 0.22),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? colors.glowPrimary
                  : Colors.black.withValues(alpha: isDark ? 0.22 : 0.05),
              blurRadius: isHovered ? 20 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            GradientGlowText(
              widget.value,
              gradient: AppGradients.brandHorizontal,
              style: typography.monoMetric.copyWith(fontSize: 22, height: 1.1),
            ),
            const SizedBox(height: 4),
            Text(
              widget.label,
              style: typography.bodySmall.copyWith(
                fontSize: 11.5,
                color: colors.textSecondary,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
